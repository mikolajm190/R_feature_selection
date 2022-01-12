#' Show results of feature selection comparison on data from package
#'
#' This is driver function for project.
#'
#' @export
#'
#' @examples
#' show_results()
show_results <- function()
{
  # przygotowanie srodowiska

  set.seed(646)

  # przygotowanie zbiorow danych

  stud <- projekt::student
  stud <- as.data.frame(sapply(stud, function(x) as.numeric(x)))

  wine <- projekt::wine

  # wykonanie metod selekcji

  res_mtcars <- projekt::compare_select(datasets::mtcars, "hp", 3)

  res_wine <- projekt::compare_select(wine, "quality", 4)

  res_student <- projekt::compare_select(stud, "G3", 12)

  # przedstawienie rezultatow

  cat("\n", "MTCARS", "\n")

  # rmse
  print(res_mtcars[[1]])

  # zmienne
  cat("\n", "full model features: ", res_mtcars[[2]], "\n", sep = " ", fill = T) # zmienne dla pelnego modelu
  cat("step model features: ", res_mtcars[[3]], "\n", sep = " ", fill = T) # zmienne wybrane dla algorytmu step
  cat("pcr model components count: ", res_mtcars[[4]], "\n", sep = " ", fill = T) # ilosc skladowych glownych dla pcr
  cat("rforest model features: ", res_mtcars[[5]], "\n", sep = " ", fill = T) # zmienne wybrane dla analizy istotnosci zmiennych przy uzyciu algorytmu randomForest
  cat("\n\n")

  cat("\n", "WINE", "\n")

  # rmse
  print(res_wine[[1]])

  # zmienne
  cat("\n", "full model features: ", res_wine[[2]], "\n", sep = " ", fill = T) # zmienne dla pelnego modelu
  cat("step model features: ", res_wine[[3]], "\n", sep = " ", fill = T) # zmienne wybrane dla algorytmu step
  cat("pcr model components count: ", res_wine[[4]], "\n", sep = " ", fill = T) # ilosc skladowych glownych dla pcr
  cat("rforest model features: ", res_wine[[5]], "\n", sep = " ", fill = T) # zmienne wybrane dla analizy istotnosci zmiennych przy uzyciu algorytmu randomForest
  cat("\n\n")

  cat("\n", "STUDENT", "\n")

  # rmse
  print(res_student[[1]])

  # zmienne
  cat("\n", "full model features: ", res_student[[2]], "\n", sep = " ", fill = T) # zmienne dla pelnego modelu
  cat("step model features: ", res_student[[3]], "\n", sep = " ", fill = T) # zmienne wybrane dla algorytmu step
  cat("pcr model components count: ", res_student[[4]], "\n", sep = " ", fill = T) # ilosc skladowych glownych dla pcr
  cat("rforest model features: ", res_student[[5]], "\n", sep = " ", fill = T) # zmienne wybrane dla analizy istotnosci zmiennych przy uzyciu algorytmu randomForest
}
