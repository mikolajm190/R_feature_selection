#' Compare feature selection methods
#'
#' This function combines results of 3 selection methods on given data.
#'
#' @param dataset A dataframe.
#' @param resVar A string with response variable name.
#' @param varNum A number of features to select in random forest method.
#'
#' @return A list with results table and selected variables for each method.
#' @export
#'
#' @importFrom caTools sample.split
#' @importFrom stats cor
#'
#' @examples
#' res <- compare_select(mtcars, "hp", 3)
compare_select <- function(dataset, resVar, varNum)
{

  df <- dataset

  # korelacja

  cor.matrix <- cor(df)
  corrplot::corrplot(cor.matrix, type = "upper")

  # podzial danych

  split <- sample.split(df, SplitRatio = 0.7)
  train <- df[split, ]
  test <- df[!split, ]

  #############
  # automatyczna metoda oparta na kryteriach (step)
  #############

  res_step <- projekt::step_select(resVar, train, test)

  #############
  # pcr
  #############

  res_pcr <- projekt::pcr_select(resVar, train, test)

  #############
  # las losowy (metody oparte na komitetach)
  #############

  res_rf <- projekt::rf_select(resVar, varNum, train, test)

  #############
  # przygotowanie wynikow
  #############

  # rmse
  results <- matrix(c(res_step[[1]], res_step[[3]], res_pcr[[1]], res_rf[[1]]), ncol = 4, nrow = 1)
  colnames(results) <- c("full", "step", "pcr", "rforest")
  rownames(results) <- "RMSE"

  # zmienne
  coef_full <- res_step[[2]] # zmienne dla pelnego modelu
  coef_step <- res_step[[4]] # zmienne wybrane dla algorytmu step
  comp_nm <- res_pcr[[2]] # ilosc skladowych glownych dla pcr
  coef_rf <- res_rf[[2]] # zmienne wybrane dla analizy istotnosci zmiennych przy uzyciu algorytmu randomForest

  return(list(results, coef_full, coef_step, comp_nm, coef_rf))

}
