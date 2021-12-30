library(pacman)

pacman::p_load(corrplot)
pacman::p_load(stats)
pacman::p_load(caTools)
pacman::p_load(pls)
pacman::p_load(caret)

# rozpoznanie zbioru danych
df <- read.csv("dane/winequality-red.csv", stringsAsFactors = T)
str(df)
summary(df)

# korelacja

cor.matrix <- cor(df)
corrplot.mixed(cor.matrix, order = "AOE")

# podzial danych

split <- sample.split(df, SplitRatio = 0.7)
train <- df[split, ]
test <- df[!split, ]

# model pelny

full_m <- lm(quality ~ ., data = train)

# rmse

y_predicted1 <- predict(full_m, newdata = test)

sqrt(mean((test$quality - y_predicted1)^2))

# automatyczna metoda oparta na kryteriach

empty_m <- lm(quality ~ 1, data = train)

step_m <- step(empty_m, direction = "forward", scope = list(lower = empty_m, upper = full_m), trace = 0)

# rmse

y_predicted2 <- predict(step_m, newdata = test)

sqrt(mean((test$quality - y_predicted2)^2))

coef(step_m)

# pca

set.seed(646)

pcr_m <- pcr(quality ~ ., data = train, scale = T, validation = "CV")

summary(pcr_m)

validationplot(pcr_m, val.type = "MSEP")
validationplot(pcr_m, val.type = "R2")

# rmse

y_predicted3 <- predict(pcr_m, newdata = test, ncomp = 5)

sqrt(mean((test$quality - y_predicted3)^2))

# las losowy

rf_m <- randomForest(formula = quality ~ ., data = train)

varImpPlot(rf_m)
impVars <- names(sort(rf_m$importance[,1], decreasing = T)[1:5])

rf_lm <- lm(as.formula(paste("quality ~ ", paste(impVars, collapse = " + "))), data = train)

y_predicted4 <- predict(rf_lm, newdata = test)

sqrt(mean((test$quality - y_predicted4)^2))
