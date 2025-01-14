#' Observe event execution ONCE across multiple sessions
#'
#' Observe event that only gets executed one across multiple shiny sessions
#'
#' @param session the shiny server session object passed to function. Default is getDefaultReactiveDomain()
#' @param input the shiny server input
#' @param output the shiny server output
#' @param priority An integer or numeric that controls the priority with which this observer should be executed. A higher value means higher priority: an observer with a higher priority value will execute before all observers with lower priority values. Positive, negative, and zero values are allowed.
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
#'  ui <- fluidPage(
#'    titlePanel("A shiny app that shows welcome message only once accross multple sessions. Refresh and see it in action"),
#'    initStore("browser"),sidebarPanel(
#'      sliderInput("slidex", label = "Sample slider", min = 1, max = 50, value = 30)
#'
#'    ),
#'    shiny::mainPanel(width=6,textOutput("slidexresres"),
#'           "sample text")
#'  )
#'
#'  server <- function(input, output, session) {
#'    # setup for in browser tracking
#'    observeOnce({
#'      output$slidexresres <- renderText(input$slidex)
#'      showModal(modalDialog(
#'        title = "Welcome to my app",
#'        "Welcome to the app! We're excited to have you here.
#'        Please note that this message will only appear the first time you visit.
#'        After this, it won’t show up again, even if you refresh or reopen the app.
#'        Feel free to explore, and we hope you enjoy your experience!",
#'        size = "m"
#'      ))
#'    }, input = input, output = output)
#'
#'    # optional: clear the storage for the previous time it was executed
#'    #observeOnceRestart()
#'  }
#'
#'
#'  shinyApp(ui = ui, server = server)
#' }
#' }
#'
#' @export
#' @rdname observeonce

observeOnce <- function(expression, session = getDefaultReactiveDomain(), input, output, priority = 1) {
  session$sendCustomMessage("stpobserveEventsOnce", "start")
  shiny::observe(
    {
      if (!is.null(input$shinystoreplusalreadyExecuted)) {
        if (input$shinystoreplusalreadyExecuted == FALSE) {
          expression
        }
      }
    },
    priority = priority
  )
}

#' @export
#' @rdname observeonce

observeOnceRestart <- function(session = getDefaultReactiveDomain()) {
  return(
    session$sendCustomMessage("stpobserveEventsOnce", "restart")
  )
}
