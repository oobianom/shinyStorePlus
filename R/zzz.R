#' @import shiny
#' @import utils
#' @import htmltools
#' @importFrom jsonlite fromJSON
#'
#' @export
#'

utils::globalVariables(c("updateSelectInput", "updateCheckboxGroupInput", "updateDateInput", "updateDateRangeInput", "updateCheckboxInput", "updateRadioButtons", "updateTextInput", "renderText"))



# drop all the NULL items, adapted from shiny pkg
rmNULL <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}
