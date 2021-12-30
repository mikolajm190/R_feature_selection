library(pacman)

pacman::p_load(corrplot)
pacman::p_load(stats)
pacman::p_load(caTools)
pacman::p_load(pls)
pacman::p_load(caret)

# rozpoznanie zbioru danych
df <- read.table("dane/abalone/abalone.data", sep = ",", stringsAsFactors = T)
colnames(df) <- c("Sex", "Length", "Diameter", "Height", "Whole.weight", "Shucked.weight", "Viscera.weight", "Shell.weight", "Rings")
str(df)
summary(df)

# korelacja

df$Sex <- as.numeric(df$Sex)
cor.matrix <- cor(df)
corrplot.mixed(cor.matrix, order = "AOE")

# podzial danych

split <- sample.split(df, SplitRatio = 0.7)
train <- df[split, ]
test <- df[!split, ]

# model pelny

full_m <- lm(Rings ~ ., data = train)

# rmse

y_predicted1 <- predict(full_m, newdata = test)

sqrt(mean((test$Rings - y_predicted1)^2))

# automatyczna metoda oparta na kryteriach

empty_m <- lm(Rings ~ 1, data = train)

step_m <- step(empty_m, direction = "forward", scope = list(lower = empty_m, upper = full_m), trace = 0)

# rmse

y_predicted2 <- predict(step_m, newdata = test)

sqrt(mean((test$Rings - y_predicted2)^2))

coef(step_m)

# pca

set.seed(646)

pcr_m <- pcr(Rings ~ ., data = train, scale = T, validation = "CV")

summary(pcr_m)

validationplot(pcr_m, val.type = "MSEP")
validationplot(pcr_m, val.type = "R2")

# rmse

y_predicted3 <- predict(pcr_m, newdata = test, ncomp = 5)

sqrt(mean((test$Rings - y_predicted3)^2))

# las losowy

rf_m <- randomForest(formula = Rings ~ ., data = train)

varImpPlot(rf_m)
impVars <- names(sort(rf_m$importance[,1], decreasing = T)[1:5])

rf_lm <- lm(as.formula(paste("Rings ~ ", paste(impVars, collapse = " + "))), data = train)

y_predicted4 <- predict(rf_lm, newdata = test)

sqrt(mean((test$Rings - y_predicted4)^2))
