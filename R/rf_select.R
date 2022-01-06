#' Select variables with random forest method
#'
#' This function builds random forest model, select n most important variables and calculates rmse.
#'
#' @param responseVar A string corresponding to response variable name.
#' @param varNum Number of features to be selected.
#' @param train A train subset of data.
#' @param test A test subset of data.
#'
#' @return A list with rmse of random forest model and vector of selected variables.
#' @export
#'
#' @importFrom randomForest randomForest varImpPlot
#'
#' @examples
#' df <- mtcars
#' split <- caTools::sample.split(df, SplitRatio = 0.7)
#' train <- df[split, ]
#' test <- df[!split, ]
#' res <- rf_select("hp", 3, train, test)
rf_select <- function(responseVar, varNum, train, test)
{
  full_formula = as.formula(paste(responseVar, "~."))

  rf_m <- randomForest(formula = full_formula, data = train)

  # wykres istotnosci zmiennych
  varImpPlot(rf_m, main = "Istotnosc zmiennych dla metody lasu losowego")

  # wybor n zmiennych pod wzgledem istotnosci w metodzie lasu losowego
  impVars <- names(sort(rf_m$importance[,1], decreasing = T)[1:varNum])

  rf_nm <- randomForest(as.formula(paste(responseVar, "~", paste(impVars, collapse = " + "))), data = train)

  # rmse
  y_predicted4 <- predict(rf_nm, newdata = test)

  rmse_rf <- sqrt(mean((test[,responseVar] - y_predicted4)^2))

  return(list(rmse_rf, impVars))
}
