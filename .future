library(shiny)
library(shinyStorePlus)

ui <- fluidPage(
  #initStore(),
  HTML("
            <script>
            Shiny.addCustomMessageHandler('hotget', function(m) {
              console.log(m)
              Shiny.setInputValue('getoutt', m);
            });
            </script>
            "),
  selectInput("sel_color", "Color (hardcoded input):", choices = c("", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  uiOutput("ui_moreinputs"),
  uiOutput("ui_moreinputs2"),
  actionButton("increment","increase!"),
  p("Refresh the page - the value of the hard coded input is retained, but the dynamic one is not")
)

server <- function(input, output, session) {
  observe({
    output$ui_moreinputs <- renderUI(
      selectInput("sel_month", "Month (dynamically generated):", choices = c("", month.name), selected = "")
    )

    print("nowwww.....")
    print(input$getoutt)
  })

  ranenv <- reactiveValues()
  ranenv$i1 <- 0
  ranenv$i2 <- mtcars

  observeEvent(input$increment,{
    ranenv$i1 = ranenv$i1 + 1
  })
  output$ui_moreinputs2 <- renderText({
    gh <- get('ranenv')
    session$sendCustomMessage("hotget", gh$i1)
    print(head(gh$i2))
    print(gh$i1)
  })
  #setupStorage(appId = "shinytest03", inputs = list("sel_color"), dyn.inputs = list("sel_month"), session = session)
}

shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE))
