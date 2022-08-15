#' Clear storage for an application
#'
#' Remove all stored inputs of an application
#'
#' @param appId the application identification
#'
#' @note Ensure not to use this function when the inputs are intended to be tracked.
#' @return No return value, called for side effects
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyStorePlus)
#'
#'   ui <- fluidPage(
#'     # initialize stores
#'     initStore(),
#'     "Sample delete storage",
#'     selectInput("dataset",
#'       label = "Dataset",
#'       choices = c("dataset 1", "dataset 2")
#'     )
#'   )
#'   server <- function(input, output, session) {
#'     appid <- "application01"
#'     clearStore(appId = appid)
#'   }
#'   shinyApp(ui, server)
#' }
#' @export
#'

clearStore <- function(appId) {
  envir <- parent.frame()
  envir$session$sendCustomMessage(
    "clearStorage",
    appId
  )
}
