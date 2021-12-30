select_var <- function(dataset, responseVar)
{
  set.seed(646)
  
  library(pacman)
  
  pacman::p_load(corrplot)
  pacman::p_load(stats)
  pacman::p_load(caTools)
  pacman::p_load(pls)
  pacman::p_load(caret)
  
  # korelacja
  
  dataset <- sapply(dataset, function(x) as.numeric(x))
  cor.matrix <- cor(dataset)
  corrplot::corrplot(cor.matrix, method = "circle")
  dataset <- as.data.frame(dataset)
  
  # podzial danych
  
  split <- sample.split(dataset, SplitRatio = 0.7)
  train <- dataset[split, ]
  test <- dataset[!split, ]
  
  # formuly
  full_formula = as.formula(paste(responseVar, "~."))
  empty_formula = as.formula(paste(responseVar, "~1"))
  
  responseVarIdx = which(colnames(dataset) == responseVar)
  
  # model pelny
  
  full_m <- lm(full_formula, data = train)
  
  # rmse
  
  y_predicted1 <- predict(full_m, newdata = test)
  
  full_rmse = sqrt(mean((test[,responseVar] - y_predicted1)^2))
  
  # algorytm stepwise
  
  empty_m <- lm(empty_formula, data = train)
  
  step_m <- step(empty_m, direction = "forward", scope = list(lower = empty_m, upper = full_m), trace = 0)
  
  # rmse
  
  y_predicted2 <- predict(step_m, newdata = test)
  
  step_rmse = sqrt(mean((test[,responseVar] - y_predicted2)^2))
  
  # pca
  
  pcr_m <- pcr(full_formula, data = train, scale = T, validation = "CV")
  
  summary(pcr_m)
  
  validationplot(pcr_m, val.type = "RMSEP")
  
  procVar = pcr_m$Xvar / pcr_m$Xtotvar
  
  sum=0
  iter=1
  for (i in procVar)
  {
    sum = sum + i
    if (sum >= 0.8)
      break
    iter = iter + 1
  }
  
  # rmse
  
  y_predicted3 <- predict(pcr_m, newdata = test, ncomp = iter)
  
  pcr_rmse = sqrt(mean((test[,responseVar] - y_predicted3)^2))
  
  # las losowy
  
  # define the control using a random forest selection function
  control <- rfeControl(functions=rfFuncs, method="cv", number=10)
  # run the RFE algorithm
  results <- rfe(train[,-responseVarIdx], train[,responseVarIdx], sizes=c(1:ncol(train)-1), rfeControl=control)
  # summarize the results
  print(results)
  # list the chosen features
  predictors(results)
  # plot the results
  plot(results, type=c("g", "o"))
  
  optVars <- results$optVariables
  
  optFormula <- as.formula(paste(paste(responseVar, "~"), paste(optVars, collapse = "+")))
  
  rf_lm2 <- lm(optFormula, data = train)
  
  y_predicted5 <- predict(rf_lm2, newdata = test)
  
  rf_rmse = sqrt(mean((test[,responseVar] - y_predicted5)^2))
  
  # preparing results
  results <- matrix(c(full_rmse, step_rmse, pcr_rmse, rf_rmse), ncol = 4, nrow = 1)
  colnames(results) <- c("full", "step", "pca", "rforest")
  rownames(results) <- "RMSE"

  return(list(results, names(coef(full_m)), names(coef(step_m)), iter, optVars))
}

testFun(mtcars, "hp")
