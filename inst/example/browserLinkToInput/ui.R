ui <- fluidPage(
  #Initialize shinyStorePlus
  initStore(),

  # Application title
  titlePanel("Example for all inputs automatically saved using shinyStorePlus by Obinna Obianom"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins1",
        "Number of bins:",
        min = 1,
        max = 50,
        value = 30
      ),
      selectInput(
        inputId = "dataset",
        label = "Choose a dataset:",
        choices = c("rock", "pressure", "cars")
      ),

      # Input: Numeric entry for number of obs to view ----
      textInput(
        inputId = "cd323",
        label = "New feature:",
        value = 10
      ),

      numericInput(
        inputId = "obs1",
        label = "Number of observations to view:",
        value = 10
      ),
      actionButton("clear1","Clear saved inputs"),
      textAreaInput("sure", "label textara", "nothing"),
      radioButtons("radi45o", "radioed", c("Obianom", "Obinna")),
      radioButtons("retired", "radioed", c("juice", "rock", "angelo")),
      column(
        3,
        h3("Single checkbox"),
        checkboxInput("checkbox", "Choice A", value = TRUE),
        checkboxInput("chec434kbox", "Choice T", value = FALSE)
      ),
      column(
        3,
        checkboxGroupInput("checkGroup",
          h3("Checkbox group"),
          choices = list(
            "Choice 1" = 1,
            "Choice 2" = 2,
            "Choice 3" = 3
          ),
          selected = c(1, 2)
        )
      ),
      column(
        3,
        checkboxGroupInput("checkGroup2",
          h3("Checkbox group"),
          choices = list(
            "Choice b" = "b",
            "Choice d" = "d",
            "Choice e" = "e"
          ),
          selected = c("b")
        )
      ),

      column(
        3,
        dateInput("date1",
          h3("Date input"),
          value = "2014-01-01"
        )
      ),
      column(
        3,
        dateInput("date2",
          h3("Date input"),
          value = "2010-01-01"
        )
      ),
      column(
        6,
        dateRangeInput("dates", h3("Date range"))
      ),

      column(
        6,
        dateRangeInput("dates2", h3("Date range"))
      ),

      column(
        3,
        fileInput("file", h3("File input"), multiple = TRUE)
      ),

      column(
        3,
        h3("Help text"),
        helpText(
          "Note: help text isn't a true widget,",
          "but it provides an easy way to add text to",
          "accompany other widgets."
        )
      ),

      column(
        3,
        numericInput(
          inputId = "num2",
          h3("Numeric input"),
          value = 1
        )
      )
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      tabsetPanel(
        id = "tabcard",
        tabPanel(
          title = "Tab 1",
          "Tab 1 content",
          numericInput(inputId = "modal1ax", label = "outputs", value = 10),

          numericInput(
            inputId = "tab1a",
            label = "Number of observations to view:",
            value = 10
          ),
          selectInput("variableselinput", "Select input with multiple select:",
                      c("Cylinders" = "cyl",
                        "Transmission" = "am",
                        "Gears" = "gear"), multiple = TRUE,
                      selected = c('cyl','am')),

          selectizeInput(
            'e4selectizeable', 'Selectize input with searchable item', choices = state.name,
            options = list(maxOptions = 5)
          ),
          selectizeInput(
            'e4selectizeable2', 'Selectize multiple input with searchable item', choices = state.name,
            options = list(maxOptions = 12), multiple = TRUE
          )
        ),
        tabPanel(
          title = "Tab 2",
          "Tab 2 content",
          numericInput(
            inputId = "tab2a",
            label = "Number of observations to view:",
            value = 10
          )
        )
      )
    )
  )
)
