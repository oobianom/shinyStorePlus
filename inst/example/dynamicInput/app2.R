library(shiny)
library(shinyStorePlus)

ui <- fluidPage(
  initStore(),
  titlePanel("Edit inputs and refresh..."),

  tags$h1("Non-Dynamic Input with '*'"),
  selectInput("mnth", "Non-dynamic:", choices = c("", month.name), selected = ""),

  tags$h1(id="dyn1","Dynamic Input Selected By Full ID name"),
  #dyamic input will appear here

  tags$h1(id="dyn2","Dynamic Input Selected By 'sampletext*'"),
  #dyamic input will appear here

  tags$h1(id="dyn3","Dynamic Input Selected By '*sampletext'"),
  #dyamic input will appear here


  # this won't work because shinyStorePlus does not create the input for you
  tags$h2("User created dynamic inputs"),
  textInput("ID","Insert an ID"),
  actionButton("add", "Add UI")
)

server <- function(input, output, session) {

  observeEvent(input$add, { insertUI( selector = "#add", where = "afterEnd", ui = textInput(paste0("random", input$ID), input$ID) ) })

  insertUI( selector = "#dyn1", where = "afterEnd", ui = textInput("dynamicinput1", "Dynamic input with id dynamicinput1","Okay" ) )

  for(n in letters[1:3])insertUI( selector = "#dyn2", where = "afterEnd", ui = textInput( paste0("sampletext",n), paste0("Dyn input with id sampletext",n),"Hi" ) )

  for(n in letters[1:3])insertUI( selector = "#dyn3", where = "afterEnd", ui = textInput( paste0(n,"sampletext"), paste0("Dyn input with id ",n,"sampletext"),"Hi" ) )


  # shinyStorePlus
  setupStorage(
    appId = "appdyn27",
    inputs = TRUE,
    dyn.inputs = list("dynamicinput1", "*sampletext", "sampletext*"),
    session = session
  )

}

shinyApp(ui, server)
