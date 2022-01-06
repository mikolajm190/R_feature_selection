## code to prepare `student-mat.csv` dataset goes here

student <- utils::read.csv2("data-raw//student//student-mat.csv", header=TRUE, stringsAsFactors = TRUE)

usethis::use_data(student, overwrite = TRUE)
