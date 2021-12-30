feature_selection <- function()
{
  library(pacman)
  
  pacman::p_load(dplyr)
  
  res1 <- select_var(mtcars, "hp")
  
  res2 <- select_var(wine, "quality")
  
  res3 <- select_var(student, "G3")
  
  res4 <- select_var(abalone, "Rings")
  
  rmse_table <- union(res1[[1]], res2[[1]], res3[[1]], res4[[1]])
  print(rmse_table)
  
  coefs_table1 <- res1[[2:5]]
  coefs_table2 <- res2[[2:5]]
  coefs_table3 <- res3[[2:5]]
  coefs_table4 <- res4[[2:5]]
}