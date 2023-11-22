#' @import shiny
#' @import utils
#' @import htmltools
#' @importFrom jsonlite fromJSON
#'
#' @export
#'

utils::globalVariables(c("updateSelectInput", "updateCheckboxGroupInput", "updateDateInput", "updateDateRangeInput", "updateCheckboxInput", "updateRadioButtons", "updateTextInput", "renderText"))



# Given a vector or list, drop all the NULL items in it
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}
