#include "scran_tests/scran_tests.hpp"
#include "nenesub/nenesub.hpp"

TEST(Nenesub, Basic) {
    knncolle::NeighborList<int, double> neighbors(5);
    neighbors[0].first = { 1, 2 }; // 0,1,2 are in the first group.
    neighbors[0].second = { 0.1, 0.2 };
    neighbors[1].first = { 0, 2 };
    neighbors[1].second = { 0.1, 0.3 };
    neighbors[2].first = { 0, 1 };
    neighbors[2].second = { 0.2, 0.3 };
    neighbors[3].first = { 4, 2 }; // 3,4 are in the second group.
    neighbors[3].second = { 0.05, 0.85 };
    neighbors[4].first = { 3, 2 };
    neighbors[4].second = { 0.05, 0.8 };

    nenesub::Options opt;
    auto out = nenesub::compute(neighbors, opt);
    EXPECT_TRUE(out.empty()); // doesn't satisfy minimum size requirements.

    opt.min_remaining = 2;
    out = nenesub::compute(neighbors, opt);
    std::vector<int> expected{ 0 };
    EXPECT_EQ(out, expected); // only 0 is chosen as it has the lowest distance from the first group AND has two neighbors.

    opt.min_remaining = 1;
    out = nenesub::compute(neighbors, opt);
    expected = std::vector<int>{ 0, 4 }; // 4 is chosen as it has a lower max distance.
    EXPECT_EQ(out, expected); 
}

TEST(Nenesub, Sanity) {
    int NR = 5, NC = 1000;
    auto vec = scran_tests::simulate_vector<double>(NR * NC, scran_tests::SimulationParameters());

    knncolle::VptreeBuilder builder;
    nenesub::Options opt;
    auto selected = nenesub::compute(NR, NC, vec.data(), builder, opt);
    EXPECT_LT(selected.size(), NC);

    // Same result with multiple threads.
    opt.num_threads = 3;
    auto pselected = nenesub::compute(NR, NC, vec.data(), builder, opt);
    EXPECT_EQ(selected, pselected);
}

TEST(Nenesub, OptCheck) {
    knncolle::VptreeBuilder builder;
    nenesub::Options opt;
    opt.min_remaining = 1000;
    scran_tests::expect_error([&]() { nenesub::compute(5, 0, static_cast<double*>(NULL), builder, opt); }, "number of neighbors");
}
