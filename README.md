
# Feature selection method comparison

<!-- badges: start -->
<!-- badges: end -->

The goal of project was to compare 3 feature selection methods.

## Info

- feature selection methods
  - stepwise regression
  - PCR (Principial Components Regression, using % of variance explained by components)
  - random forest (variable importance)
- data
  - mtcars
  - [wine quality data set](https://archive.ics.uci.edu/ml/datasets/wine+quality)
  - [student performance data set](https://archive.ics.uci.edu/ml/datasets/student+performance)

## Installation

You can install the development version of projekt like so:

``` r
devtools::install_github("mikolajm190/R_feature_selection")
```

## Example

This is a basic example which shows you how to use this package:

``` r
library(projekt)
show_results()
```

## References

- <https://www.statology.org/stepwise-regression-r/>
- <https://www.statology.org/principal-components-regression-in-r/>
- <https://www.rdocumentation.org/packages/randomForest/versions/4.7-1.1/topics/randomForest>
