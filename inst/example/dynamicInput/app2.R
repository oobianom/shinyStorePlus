library(shiny)
library(shinyStorePlus)

ui <- fluidPage(
  initStore(),
  tags$h1("Dynamic Input with '*'"),
  selectInput("mnth", "Non-dynamic:", choices = c("", month.name), selected = ""),

  tags$h2("Hard coded with id starting with txteee:"),
  textInput( "txteee1", "Random one","A name" ),
  textInput( "txteee2", "Random two" ),
  textInput( "shutxteee", "Random three" ),
  tags$h2(id="dynstart","Dynamically started with txteee:"),
  tags$h2("User-entered (id starting with txteee*):"),
  textInput(
    "ID",
    "OriginalTexttt"
  ),
  actionButton("add", "Add UI"),
  tags$h2("User-entered (id ending with txteee*):"),
  textInput(
    "ID2",
    "OriginalTexttt"
  ),
  actionButton("add2", "Add UI")
)

server <- function(input, output, session) {
  observeEvent(input$add, {
    insertUI(
      selector = "#add",
      where = "afterEnd",
      ui = textInput(
        paste0("txteee", input$ID),
        input$ID
      )
    )
  })

  observeEvent(input$add2, {
    insertUI(
      selector = "#add2",
      where = "afterEnd",
      ui = textInput(
        paste0("txteee", input$ID2),
        input$ID2
      )
    )
  })

  insertUI(
    selector = "#dynstart",
    where = "afterEnd",
    ui = textInput(
      paste0("txteeedancerr"),
      "Id start with txteee","Okay"
    )
  )
  insertUI(
    selector = "#dynstart",
    where = "afterEnd",
    ui = textInput(
      paste0("appletxteee"),
      "Id ending with txteee","None"
    )
  )
setupStorage(appId = "appdyn23",inputs = FALSE, dyn.inputs = list("mnth","apple","txteee*"), session = session)

}

shinyApp(ui, server)
