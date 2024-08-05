# Nearest-neighbors subsampling

![Unit tests](https://github.com/libscran/nenesub/actions/workflows/run-tests.yaml/badge.svg)
![Documentation](https://github.com/libscran/nenesub/actions/workflows/doxygenate.yaml/badge.svg)
[![Codecov](https://codecov.io/gh/libscran/nenesub/graph/badge.svg?token=bmenggvgzE)](https://codecov.io/gh/libscran/nenesub)

## Overview

**nenesub** implements a simple algorithm for deterministic subsampling of a dataset based on nearest neighbors.
Starting from dense regions of the high-dimensional space, we select an observation for inclusion into the subsampled set.
Every time we select an observation, we remove it and all of its nearest neighbors from the dataset.
We then select the next observation with the most remaining neighbors, with ties broken by density; this is repeated until there are no more observations.

The general idea is that each selected observation serves as a representative for its nearest neighbors.
This ensures that the subsampled points are well-distributed across the dataset.
Low-frequency subpopulations will always have at least a few representatives if they are sufficiently distant from other subpopulations.
We also preserve the relative density across the dataset as more representatives will be generated from high-density regions. 

## Quick start

Given a column-major array of coordinates (possibly in some [low-dimensional space](https://github.com/libscran/scran_pca)),
we can subsample the observations using their nearest neighbors:

```cpp
#include "nenesub/nenesub.hpp"

size_t nobs = 1000;
size_t ndims = 100;
std::vector<double> coordinates(ndims * nobs);
// Fill it with some coordinates...

nenesub::Options opt;
opt.num_neighbors = 20;
opt.min_remaining = 10;
opt.num_threads = 3;

auto selected = nenesub::compute(
    ndims,
    nobs,
    coordinates.data(),
    knncolle::VptreeBuilder<>(), // any NN algorithm can be used here.
    opt
);
```

Alternatively, we can supply a precomputed list of neighbors:

```cpp
// Getting the nearest neighbors:
knncolle::VptreeBuilder algorithm;
knncolle::SimpleMatrix kmatrix(ndims, nobs, coordinates.data());
auto prebuilt = algorithm.build_unique(kmatrix);
auto neighbors = knncolle::find_nearest_neighbors(*prebuilt, /* k = */ 20);

auto selected = nenesub::compute(neighbors, opt);
```

Check out the [reference documentation](https://libscran.github.io/nenesub) for more details.

## Building projects

### CMake with `FetchContent`

If you're using CMake, you just need to add something like this to your `CMakeLists.txt`:

```cmake
include(FetchContent)

FetchContent_Declare(
  nenesub
  GIT_REPOSITORY https://github.com/libscran/nenesub
  GIT_TAG master # or any version of interest
)

FetchContent_MakeAvailable(nenesub)
```

Then you can link to **nenesub** to make the headers available during compilation:

```cmake
# For executables:
target_link_libraries(myexe libscran::nenesub)

# For libaries
target_link_libraries(mylib INTERFACE libscran::nenesub)
```

### CMake with `find_package()`

```cmake
find_package(libscran_nenesub CONFIG REQUIRED)
target_link_libraries(mylib INTERFACE libscran::nenesub)
```

To install the library, use:

```sh
mkdir build && cd build
cmake .. -DNENESUB_TESTS=OFF
cmake --build . --target install
```

By default, this will use `FetchContent` to fetch all external dependencies.
If you want to install them manually, use `-DNENESUB_FETCH_EXTERN=OFF`.
See the tags in [`extern/CMakeLists.txt`](extern/CMakeLists.txt) to find compatible versions of each dependency.

### Manual

If you're not using CMake, the simple approach is to just copy the files in `include/` - either directly or with Git submodules - and include their path during compilation with, e.g., GCC's `-I`.
This requires the external dependencies listed in [`extern/CMakeLists.txt`](extern/CMakeLists.txt), which also need to be made available during compilation.
