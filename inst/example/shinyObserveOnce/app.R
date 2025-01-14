library(shiny)
library(shinyStorePlus)
ui <- fluidPage(
  titlePanel("A shiny app that shows welcome message only once accross multple sessions. Refresh and see it in action"),
  initStore("browser"),sidebarPanel(
    sliderInput("slidex", label = "Sample slider", min = 1, max = 50, value = 30)

  ),
  shiny::mainPanel(width=6,textOutput("slidexresres"),
         "The current function in the 'Shiny' app
         enables users to execute an expression once
         across multiple sessions, ensuring that
         certain actions or elements only appear
         the first time a user interacts with the app.
         For example, it could be used to display
         a welcome modal or a cookie acceptance prompt
         only during the user's first session. After
         the initial interaction, these elements will
         not appear again, even if the user refreshes
         the app or closes and reopens it later. This
         functionality helps streamline the user experience
         by preventing repetitive prompts and maintaining a
         clean interface for returning users.")
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
  observeOnceRestart()
}


shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE,shiny.port =7171))




