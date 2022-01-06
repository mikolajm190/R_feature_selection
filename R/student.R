#' Student Performance Data Set
#'
#' This data approach student achievement in secondary education of two Portuguese schools. The data attributes include student grades, demographic, social and school related features) and it was collected by using school reports and questionnaires.
#'
#' @format A data frame with 395 rows and 30 variables:
#' \describe{
#'   \item{school}{student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)}
#'   \item{sex}{student's sex (binary: 'F' - female or 'M' - male)}
#'   \item{age}{student's age (numeric: from 15 to 22)}
#'   \item{address}{student's home address type (binary: 'U' - urban or 'R' - rural)}
#'   \item{famsize}{family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)}
#'   \item{Pstatus}{parent's cohabitation status (binary: 'T' - living together or 'A' - apart)}
#'   \item{Medu}{mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 - 5th to 9th grade, 3 - secondary education or 4 - higher education)}
#'   \item{Fedu}{father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 - 5th to 9th grade, 3 - secondary education or 4 - higher education)}
#'   \item{Mjob}{mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')}
#'   \item{Fjob}{father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')}
#'   \item{reason}{reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')}
#'   \item{guardian}{student's guardian (nominal: 'mother', 'father' or 'other')}
#'   \item{traveltime}{home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)}
#'   \item{studytime}{weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)}
#'   \item{failures}{number of past class failures (numeric: n if 1<=n<3, else 4)}
#'   \item{schoolsup}{extra educational support (binary: yes or no)}
#'   \item{famsup}{family educational support (binary: yes or no)}
#'   \item{paid}{extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)}
#'   \item{activities}{extra-curricular activities (binary: yes or no)}
#'   \item{nursery}{attended nursery school (binary: yes or no)}
#'   \item{higher}{wants to take higher education (binary: yes or no)}
#'   \item{internet}{Internet access at home (binary: yes or no)}
#'   \item{romantic}{with a romantic relationship (binary: yes or no)}
#'   \item{famrel}{quality of family relationships (numeric: from 1 - very bad to 5 - excellent)}
#'   \item{freetime}{free time after school (numeric: from 1 - very low to 5 - very high)}
#'   \item{goout}{going out with friends (numeric: from 1 - very low to 5 - very high)}
#'   \item{Dalc}{workday alcohol consumption (numeric: from 1 - very low to 5 - very high)}
#'   \item{Walc}{weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)}
#'   \item{health}{current health status (numeric: from 1 - very bad to 5 - very good)}
#'   \item{absences}{number of school absences (numeric: from 0 to 93)}
#'   \item{G1}{first period grade (numeric: from 0 to 20)}
#'   \item{G2}{second period grade (numeric: from 0 to 20)}
#'   \item{G3}{final grade (numeric: from 0 to 20, output target)}
#' }
#' @source \url{https://archive.ics.uci.edu/ml/datasets/Student+Performance}
"student"
