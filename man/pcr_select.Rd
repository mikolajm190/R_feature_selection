% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pcr_select.R
\name{pcr_select}
\alias{pcr_select}
\title{Select variables with principial components regression.}
\usage{
pcr_select(responseVar, train, test)
}
\arguments{
\item{responseVar}{A string corresponding to response variable name.}

\item{train}{A train subset of data.}

\item{test}{A test subset of data.}
}
\value{
A list containing rmse and number od components selected of pcr model.
}
\description{
This function builds pcr model, calculate number of components and rmse.
}
\examples{
df <- mtcars
split <- caTools::sample.split(df, SplitRatio = 0.7)
train <- df[split, ]
test <- df[!split, ]
res <- pcr_select("hp", train, test)
}
