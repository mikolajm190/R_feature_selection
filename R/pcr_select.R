#' Select variables with principial components regression.
#'
#' This function builds pcr model, calculate number of components and rmse.
#'
#' @param responseVar A string corresponding to response variable name.
#' @param train A train subset of data.
#' @param test A test subset of data.
#'
#' @return A list containing rmse and number od components selected of pcr model.
#' @export
#'
#' @importFrom pls pcr validationplot
#'
#' @examples
#' df <- mtcars
#' split <- caTools::sample.split(df, SplitRatio = 0.7)
#' train <- df[split, ]
#' test <- df[!split, ]
#' res <- pcr_select("hp", train, test)
pcr_select <- function(responseVar, train, test)
{
  pacman::p_load(pls)

  full_formula = as.formula(paste(responseVar, "~."))

  pcr_m <- pcr(full_formula, data = train, scale = T, validation = "CV")

  # skladowe glowne wg procentu wyjasionej wariancji
  procVar = pcr_m$Xvar / pcr_m$Xtotvar

  # wykres wartosci rmse w zaleznosci od ilosci wybranych skladowych glownych
  validationplot(pcr_m, val.type = "R2", main = "Wykres R2 w zaleznosci od ilosci skladowych glownych", type = "b")
  validationplot(pcr_m, val.type = "RMSEP", main = "Wykres RMSE w zaleznosci od ilosci skladowych glownych", type = "b")

  # wybor ilosci skladowych glownych wg kryterium procentu wyjasnionej wariancji
  sum=0
  comp_nm=1
  for (i in procVar)
  {
    sum = sum + i
    if (sum >= 0.8)
      break
    comp_nm = comp_nm + 1
  }

  # rmse
  y_predicted3 <- predict(pcr_m, newdata = test, ncomp = comp_nm)

  rmse_pcr <- sqrt(mean((test[,responseVar] - y_predicted3)^2))

  return(list(rmse_pcr, comp_nm))
}
