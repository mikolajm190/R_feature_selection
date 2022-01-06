#' Select variables with step algorithm
#'
#' This function builds full and step models of given data and calculate rmse.
#'
#' @param responseVar A string corresponding to response variable name.
#' @param train A train subset of data.
#' @param test A test subset of data.
#'
#' @return A list containing rmse and variables of full and step models.
#' @export
#'
#' @importFrom stats as.formula lm predict step coef
#'
#' @examples
#' df <- mtcars
#' split <- caTools::sample.split(df, SplitRatio = 0.7)
#' train <- df[split, ]
#' test <- df[!split, ]
#' res <- step_select("hp", train, test)
step_select <- function(responseVar, train, test)
{
  # formuly
  full_formula = as.formula(paste(responseVar, "~."))
  empty_formula = as.formula(paste(responseVar, "~1"))

  full_m <- lm(full_formula, data = train)

  # rmse
  y_predicted1 <- predict(full_m, newdata = test)

  rmse_full <- sqrt(mean((test[,responseVar] - y_predicted1)^2))

  # zmienne
  coef_full <- names(coef(full_m))[-1]

  empty_m <- lm(empty_formula, data = train)

  step_m <- step(empty_m, direction = "forward", scope = list(lower = empty_m, upper = full_m), trace = 0)

  # rmse
  y_predicted2 <- predict(step_m, newdata = test)

  rmse_step <- sqrt(mean((test[,responseVar] - y_predicted2)^2))

  # zmienne
  coef_step <- names(coef(step_m))[-1]

  return(list(rmse_full, coef_full, rmse_step, coef_step))
}
