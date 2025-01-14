library(shiny)
library(shinyStorePlus)
ui <- fluidPage(
  titlePanel("A shiny app that shows welcome message only once accross multple sessions. Refresh and see it in action"),
  initStore("browser"),sidebarPanel(
    sliderInput("slidex", label = "Sample slider", min = 1, max = 50, value = 30)

  ),
  shiny::mainPanel(width=6,textOutput("slidexresres"),
         "sample text")
)

server <- function(input, output, session) {
  # setup for in browser tracking
  observeOnce({
    output$slidexresres <- renderText(input$slidex)
    showModal(modalDialog(
      title = "Welcome to my app",
      "Welcome to the app! We're excited to have you here.
      Please note that this message will only appear the first time you visit.
      After this, it won’t show up again, even if you refresh or reopen the app.
      Feel free to explore, and we hope you enjoy your experience!",
      size = "m"
    ))
  }, input = input, output = output)

  # optional: clear the storage for the previous time it was executed
  #observeOnceRestart()
}


shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE,shiny.port =7171))




