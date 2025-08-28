reference <- function(x, k, m) {
    res <- findKNN(x, k, transposed=TRUE)

    distances <- res$distance[,k]
    candidates <- seq_len(ncol(x))
    keep <- integer(0)

    while (length(candidates)) {
        available <- rowSums(!is.na(res$index[candidates,,drop=FALSE]), na.rm=TRUE)
        if (!any(available >= m)) {
            break
        }
        o <- order(-available, distances[candidates])
        chosen <- candidates[o[1]]
        keep <- c(keep, chosen)
        neighbors <- res$index[chosen,]
        new.invalid <- c(chosen, neighbors)
        res$index[res$index %in% new.invalid] <- NA
        candidates <- setdiff(candidates, new.invalid)
    }

    sort(keep)
}
