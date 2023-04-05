## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  
#  if(interactive()) {
#  ui <- fluidPage(
#    # Application title
#    titlePanel("Transfer browser link parameters to shiny input"),
#  
#    # Sidebar with a slider input for number of bins
#    selectInput(
#      inputId = "datasetbin",
#      label = "Choose an option",
#      choices = c("rock", "pressure", "cars")
#    ),
#    textInput(
#      inputId = "cd323",
#      label = "Choose a name",
#      value = "No name"
#    ),
#  
#    numericInput(
#      inputId = "number1",
#      label = "Choose a number",
#      value = 10
#    ),
#  
#    htmlOutput("outputnum")
#  )
#  
#  server <- function(input,output,session) {
#  }
#  
#  shinyApp(ui = ui, server = server)
#  }
#  

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  library(shinyStorePlus)
#  
#  if(interactive()) {
#  ui <- fluidPage(
#    # Application title
#    titlePanel("Transfer browser link parameters to shiny input"),
#  
#    # Sidebar with a slider input for number of bins
#    selectInput(
#      inputId = "datasetbin",
#      label = "Choose an option",
#      choices = c("rock", "pressure", "cars")
#    ),
#    textInput(
#      inputId = "cd323",
#      label = "Choose a name",
#      value = "No name"
#    ),
#  
#    numericInput(
#      inputId = "number1",
#      label = "Choose a number",
#      value = 10
#    ),
#  
#    htmlOutput("outputnum")
#  )
#  
#  server <- function(input,output,session) {
#  }
#  
#  shinyApp(ui = ui, server = server)
#  }
#  

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  library(shinyStorePlus)
#  
#  if(interactive()) {
#  ui <- fluidPage(
#  
#    #Initialize shinyStorePlus
#    initStore(),
#  
#    # Application title
#    titlePanel("Transfer browser link parameters to shiny input"),
#  
#    # Sidebar with a slider input for number of bins
#    selectInput(
#      inputId = "datasetbin",
#      label = "Choose an option",
#      choices = c("rock", "pressure", "cars")
#    ),
#    textInput(
#      inputId = "cd323",
#      label = "Choose a name",
#      value = "No name"
#    ),
#  
#    numericInput(
#      inputId = "number1",
#      label = "Choose a number",
#      value = 10
#    ),
#  
#    htmlOutput("outputnum")
#  )
#  
#  server <- function(input,output,session) {
#  }
#  
#  shinyApp(ui = ui, server = server)
#  }
#  

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  library(shinyStorePlus)
#  
#  if(interactive()) {
#  ui <- fluidPage(
#  
#    #Initialize shinyStorePlus
#    initStore(),
#  
#    # Application title
#    titlePanel("Transfer browser link parameters to shiny input"),
#  
#    # Sidebar with a slider input for number of bins
#    selectInput(
#      inputId = "datasetbin",
#      label = "Choose an option",
#      choices = c("rock", "pressure", "cars")
#    ),
#    textInput(
#      inputId = "cd323",
#      label = "Choose a name",
#      value = "No name"
#    ),
#  
#    numericInput(
#      inputId = "number1",
#      label = "Choose a number",
#      value = 10
#    ),
#  
#    htmlOutput("outputnum")
#  )
#  
#  server <- function(input,output,session) {
#    # for the inputs
#    link2input(
#      #example: shiny element ID = link parameter
#      cd323 = "name",
#      datasetbin = "data",
#      number1 = "num"
#      )
#    #for the outputs
#    link2input(
#      outputnum = "outt",
#      inputtype = "output"
#    )
#  
#  }
#  
#  shinyApp(ui = ui, server = server)
#  }
#  

