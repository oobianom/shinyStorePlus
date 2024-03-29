library(shiny)
library(shinyWidgets)
library(shinyStorePlus)

ui <- fluidPage(
  initStore(),
  radioGroupButtons(
    inputId = "hook0",
    choices = c("A", "B", "C"),
    label = "shinyWidgets compatibility example"
  ),
  verbatimTextOutput(outputId = "res"),
  pickerInput(
    inputId = "updateselected", label = "Update selected:",
    choices = c("A", "B", "C"), multiple = FALSE
  ),
  textInput(inputId = "updatelabel", label = "Update label", value = "shinyWidgets compatibility example"),
  "Material switch",
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
  "Others (still not working)",
  virtualSelectInput(
    inputId = "hook9",
    label = "Select:",
    choices = list(
      "Spring" = c("March", "April", "May"),
      "Summer" = c("June", "July", "August"),
      "Autumn" = c("September", "October", "November"),
      "Winter" = c("December", "January", "February")
    ),
    showValueAsTags = FALSE,
    search = TRUE,
    multiple = TRUE
  ),
  switchInput(inputId = "hook121", value = FALSE),
  airDatepickerInput(
    inputId = "hook10",
    label = "Select:",
    placeholder = "Placeholder",
    multiple = 5,
    clearButton = TRUE
  )
)

server <- function(input, output, session) {
  output$res <- renderPrint({
    input$hook0
  })

  observeEvent(input$updatechoices, {
    newchoices <- sample(letters, sample(3:7))
    updateRadioGroupButtons(
      session = session,
      inputId = "hook0",
      choices = newchoices
    )
    updatePickerInput(
      session = session,
      inputId = "updateselected",
      choices = newchoices
    )
  })

  observeEvent(input$updateselected,
    {
      updateRadioGroupButtons(
        session = session, inputId = "hook0",
        selected = input$updateselected
      )
    },
    ignoreNULL = TRUE,
    ignoreInit = TRUE
  )

  observeEvent(input$updatelabel,
    {
      updateRadioGroupButtons(
        session = session, inputId = "hook0",
        label = input$updatelabel
      )
    },
    ignoreInit = TRUE
  )

  # stores setup - save the values we gave it
  appid <- "test71"
  setupStorage(appId = appid, inputs = TRUE)
}

if (interactive()) {
  shinyApp(ui = ui, server = server)
}
