
library(scrapper)
x <- matrix(rnorm(10000), nrow=10)
print(nrow(x))
keep <- subsampleByNeighbors(x, 20)

