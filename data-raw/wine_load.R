## code to prepare `winequality-red.csv` dataset goes here

wine <- utils::read.csv("data-raw//wine//winequality-red.csv", header=TRUE)

usethis::use_data(wine, overwrite = TRUE)
