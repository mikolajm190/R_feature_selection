library(pacman)

pacman::p_load(corrplot)
pacman::p_load(stats)
pacman::p_load(caTools)
pacman::p_load(pls)
pacman::p_load(caret)

# rozpoznanie zbioru danych
df <- read.csv("dane/student-mat.csv", stringsAsFactors = T, sep = ";")
str(df)
summary(df)

which(colnames(df) == "G3")

# korelacja

df <- sapply(df, function(x) as.numeric(x))
cor.matrix <- cor(df)
corrplot::corrplot(cor.matrix, method = "square")
df <- as.data.frame(df)

# podzial danych

split <- sample.split(df, SplitRatio = 0.7)
train <- df[split, ]
test <- df[!split, ]

# model pelny

full_m <- lm(G3 ~ ., data = train)

# rmse

y_predicted1 <- predict(full_m, newdata = test)

sqrt(mean((test$G3 - y_predicted1)^2))

# automatyczna metoda oparta na kryteriach

empty_m <- lm(G3 ~ 1, data = train)

step_m <- step(empty_m, direction = "forward", scope = list(lower = empty_m, upper = full_m), trace = 0)

# rmse

y_predicted2 <- predict(step_m, newdata = test)

sqrt(mean((test$G3 - y_predicted2)^2))

coef(step_m)

# pca

set.seed(646)

pcr_m <- pcr(G3 ~ ., data = train, scale = T, validation = "CV")

summary(pcr_m)

validationplot(pcr_m, val.type = "RMSEP")
validationplot(pcr_m, val.type = "R2")

# rmse

y_predicted3 <- predict(pcr_m, newdata = test, ncomp = 18)

sqrt(mean((test$G3 - y_predicted3)^2))

# las losowy

rf_m <- randomForest(formula = G3 ~ ., data = train)

varImpPlot(rf_m)
impVars <- names(sort(rf_m$importance[,1], decreasing = T)[1:5])

rf_lm <- lm(as.formula(paste("G3 ~ ", paste(impVars, collapse = " + "))), data = train)

y_predicted4 <- predict(rf_lm, newdata = test)

sqrt(mean((test$G3 - y_predicted4)^2))


# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
results <- rfe(train[,1:32], train[,33], sizes=c(1:32), rfeControl=control)
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))

optVars <- results$optVariables

rf_lm2 <- lm(as.formula(paste("G3 ~ ", paste(optVars, collapse = " + "))), data = train)

y_predicted5 <- predict(rf_lm2, newdata = test)

sqrt(mean((test$G3 - y_predicted5)^2))
