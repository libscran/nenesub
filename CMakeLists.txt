cmake_minimum_required(VERSION 3.14)

project(nenesub
    VERSION 0.1.0
    DESCRIPTION "Nearest-neighbor-based subsampling"
    LANGUAGES CXX)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# Library
add_library(nenesub INTERFACE)
add_library(libscran::nenesub ALIAS nenesub)

target_include_directories(nenesub INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/nenesub>)
target_compile_features(nenesub INTERFACE cxx_std_17)

# Dependencies
option(SCRAN_GRAPH_CLUSTER_FETCH_EXTERN "Automatically fetch nenesub's external dependencies (except for igraph)." ON)
if(SCRAN_GRAPH_CLUSTER_FETCH_EXTERN)
    add_subdirectory(extern)
else()
    find_package(knncolle_knncolle 2.0.0 CONFIG REQUIRED)
endif()

target_link_libraries(nenesub INTERFACE knncolle::knncolle)

# Tests
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    option(SCRAN_GRAPH_CLUSTER_TESTS "Build nenesub's test suite." ON)
else()
    option(SCRAN_GRAPH_CLUSTER_TESTS "Build nenesub's test suite." OFF)
endif()

if(SCRAN_GRAPH_CLUSTER_TESTS)
    include(CTest)
    if(BUILD_TESTING)
        add_subdirectory(tests)
    endif() 
endif()

# Install
install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/nenesub)

install(TARGETS nenesub
    EXPORT nenesubTargets)

install(EXPORT nenesubTargets
    FILE libscran_nenesubTargets.cmake
    NAMESPACE libscran::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libscran_nenesub)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/libscran_nenesubConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libscran_nenesub)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/libscran_nenesubConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/libscran_nenesubConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/libscran_nenesubConfigVersion.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libscran_nenesub)
