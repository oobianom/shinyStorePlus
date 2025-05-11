library(shiny)
library(shinyStorePlus)

ui <- fluidPage(
  initStore(),
  selectInput("sel_color", "Color (hardcoded input):", choices = c("", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  uiOutput("ui_moreinputs"),
  p("Refresh the page - the value of the hard coded input is retained, but the dynamic one is not")
)

server <- function(input, output, session) {
  observe({
    output$ui_moreinputs <- renderUI(
      selectInput("sel_month", "Month (dynamically generated):", choices = c("", month.name), selected = "")
    )
  })

  setupStorage(appId = "shinytest031", inputs = list("sel_color"), dyn.inputs = list("sel_month"), session = session)
}

shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
