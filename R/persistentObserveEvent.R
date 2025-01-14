#' Observe event once across multiple sessions
#'
#' Observe event that only gets executed one across multiple shiny sessions
#'
#' @param session the shiny server session object passed to function. Default is getDefaultReactiveDomain()
#' @param input the shiny server input
#' @param output the shiny server output
#'
#' @details
#' The current set of functions enables users to execute an expression in the 'Shiny' app ONCE across multiple sessions, ensuring that certain actions or elements only appear the first time a user interacts with the app. For example, it could be used to display a welcome modal or a cookie acceptance prompt only during the user's first session. After the initial interaction, these elements will not appear again, even if the user refreshes the app or closes and reopens it later. This functionality helps streamline the user experience by preventing repetitive prompts and maintaining a clean interface for returning users.
#'
#' @examples
#' \donttest{
#' library(shiny)
#' library(shinyStorePlus)
#'
#' if (interactive()) {
#'
#' shiny::shinyApp(ui = ui, server = server)
#' }
#'
#' }
#'
#' @export
#' @rdname observeonce

observeOnce <- function(expression, session = getDefaultReactiveDomain(), input, output){
  session$sendCustomMessage("shinystoreplusalreadyExecuted", "start")
  if(not.null(input$shinystoreplusalreadyExecuted)){
    if(input$shinystoreplusalreadyExecuted == FALSE) expression
  }
}

#' @export
#' @rdname observeonce

observeOnceRestart <- function(session = getDefaultReactiveDomain()){
  return(
    session$sendCustomMessage("stpobserveEventsOnce", "restart")
  )
}
