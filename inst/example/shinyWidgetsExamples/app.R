library(shiny)
library(shinyWidgets)
library(shinyStorePlus)

ui <- fluidPage(initStore(),
  radioGroupButtons(
    inputId = "somevalue",
    choices = c("A", "B", "C"),
    label = "My label"
  ),

  verbatimTextOutput(outputId = "res"),

  pickerInput(
    inputId = "updateselected", label = "Update selected:",
    choices = c("A", "B", "C"), multiple = FALSE
  ),
  switchInput(inputId = "hook1", value = TRUE),

  textInput(inputId = "updatelabel", label = "Update label"),
  materialSwitch(inputId = "hook2", label = "Primary switch", status = "danger"),
  prettyCheckbox(
    inputId = "hook3", label = "Check me!", icon = icon("check")
  ),
  prettySwitch(
    inputId = "hook4",
    label = "Switch:",
    fill = TRUE,
    status = "primary"
  ),
  prettyToggle(
    inputId = "hook5",
    label_on = "Checked!",
    label_off = "Unchecked..."
  ),
  checkboxGroupButtons( # or radioGroupButtons
    inputId = "hook6",
    label = "Choice: ",
    choices = c("A", "B", "C")
  ),
  prettyCheckboxGroup( # or prettyRadioButtons
    inputId = "hook7",
    label = "Choice",
    choices = c("A", "B", "c"),
    outline = TRUE,
    plain = TRUE,
    status = "primary",
    icon = icon("check")
  ),
  pickerInput(
    inputId = "hook8",
    label = "Select:",
    choices = month.name,
    options = pickerOptions(
      actionsBox = TRUE,
      size = 10,
      selectedTextFormat = "count > 3"
    ),
    multiple = TRUE
  ),

  virtualSelectInput(
    inputId = "hook9",
    label = "Select:",
    choices = list(
      "Spring" = c("March", "April", "May"),
      "Summer" = c("June", "July", "August"),
      "Autumn" = c("September", "October", "November"),
      "Winter" = c("December", "January", "February")
    ),
    showValueAsTags = TRUE,
    search = TRUE,
    multiple = TRUE
  ),

  airDatepickerInput(
    inputId = "hook10",
    label = "Select:",
    placeholder = "Placeholder",
    multiple = 5,
    clearButton = TRUE
  ),

  searchInput(
    inputId = "hook12",
    label = "Enter your search :",
    placeholder = "This is a placeholder",
    btnSearch = icon("search"),
    btnReset = icon("remove"),
    width = "100%"
  )


)

server <- function(input, output, session) {

  output$res <- renderPrint({
    input$somevalue
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(3:7))
    updateRadioGroupButtons(
      session = session,
      inputId = "somevalue",
      choices = newchoices
    )
    updatePickerInput(
      session = session,
      inputId = "updateselected",
      choices = newchoices
    )
  })

  observeEvent(input$updateselected, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      selected = input$updateselected
    )
  }, ignoreNULL = TRUE, ignoreInit = TRUE)

  observeEvent(input$updatelabel, {
    updateRadioGroupButtons(
      session = session, inputId = "somevalue",
      label = input$updatelabel
    )
  }, ignoreInit = TRUE)

  #stores setup - save the values we gave it
  appid = "application334"
  setupStorage(appId = appid,inputs = TRUE)

}

if (interactive())
  shinyApp(ui = ui, server = server)
