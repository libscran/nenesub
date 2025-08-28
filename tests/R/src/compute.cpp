#include "Rcpp.h"
#include "nenesub/nenesub.hpp"

//[[Rcpp::export(rng=false)]]
SEXP compute(Rcpp::NumericMatrix data, int num_neighbors, int min_remaining) {
    auto selected = nenesub::compute(
        data.rows(),
        data.cols(),
        static_cast<const double*>(data.begin()),
        knncolle::VptreeBuilder<int, double, double>(std::make_shared<knncolle::EuclideanDistance<double, double> >()),
        [&]{
            nenesub::Options opt;
            opt.num_neighbors = num_neighbors;
            opt.min_remaining = min_remaining;
            return opt;
        }()
    );
    for (auto& s : selected) {
        ++s;
    }
    return Rcpp::IntegerVector(selected.begin(), selected.end());
}
