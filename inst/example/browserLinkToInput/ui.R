ui <- fluidPage(
  #Initialize shinyStorePlus
  initStore(),

  # Application title
  titlePanel("Transfer browser link parameters to shiny input"),

  # Sidebar with a slider input for number of bins
  selectInput(
    inputId = "datasetbin",
    label = "Choose an option",
    choices = c("rock", "pressure", "cars")
  ),
  textInput(
    inputId = "cd323",
    label = "Choose a name",
    value = "No name"
  ),

  numericInput(
    inputId = "number1",
    label = "Choose a number",
    value = 10
  ),
  htmlOutput("outputnum")
)
