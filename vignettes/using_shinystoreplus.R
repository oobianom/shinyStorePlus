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
#      # Application title
#      titlePanel("shinyStorePlus by Obi Obianom"),
#  
#      # Sidebar with a slider input for number of bins
#      sidebarLayout(
#          sidebarPanel(
#              sliderInput("bins",
#                          "Number of bins:",
#                          min = 1,
#                          max = 50,
#                          value = 30),
#              selectizeInput(
#                'foo', label = NULL, choices = state.name,
#                options = list(create = TRUE),
#                multiple = TRUE
#              ),
#             textInput("redd","What if I?",value = "Wayword...")
#          ),
#  
#          # Show a plot of the generated distribution
#          mainPanel(
#              plotOutput("distPlot")
#          )
#      )
#  )
#  
#  server <- function(input,output,session) {
#    # make sure the  input, output, session arguments are present !IMPORTANT
#  
#      output$distPlot <- renderPlot({
#  
#          # generate bins based on input$bins from ui.R
#          x    <- faithful[, 2]
#          bins <- seq(min(x), max(x), length.out = input$bins + 1)
#  
#          # draw the histogram with the specified number of bins
#          hist(x, breaks = bins, col = 'darkgray', border = 'white',
#               xlab = 'Waiting time to next eruption (in mins)',
#               main = 'Histogram of waiting times')
#  
#      })
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
#      # Application title
#      titlePanel("shinyStorePlus by Obi Obianom"),
#  
#      # Sidebar with a slider input for number of bins
#      sidebarLayout(
#          sidebarPanel(
#              sliderInput("bins",
#                          "Number of bins:",
#                          min = 1,
#                          max = 50,
#                          value = 30),
#              selectizeInput(
#                'foo', label = NULL, choices = state.name,
#                options = list(create = TRUE),
#                multiple = TRUE
#              ),
#             textInput("redd","What if I?",value = "Wayword...")
#          ),
#  
#          # Show a plot of the generated distribution
#          mainPanel(
#              plotOutput("distPlot")
#          )
#      )
#  )
#  
#  server <- function(input,output,session) {
#    # make sure the  input, output, session arguments are present !IMPORTANT
#  
#      output$distPlot <- renderPlot({
#  
#          # generate bins based on input$bins from ui.R
#          x    <- faithful[, 2]
#          bins <- seq(min(x), max(x), length.out = input$bins + 1)
#  
#          # draw the histogram with the specified number of bins
#          hist(x, breaks = bins, col = 'darkgray', border = 'white',
#               xlab = 'Waiting time to next eruption (in mins)',
#               main = 'Histogram of waiting times')
#  
#      })
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
#  if (interactive()) {
#    ui <- fluidPage(
#      # Initialize shinyStorePlus
#      initStore(),
#  
#      # Application title
#      titlePanel("shinyStorePlus by Obi Obianom"),
#  
#      # Sidebar with a slider input for number of bins
#      sidebarLayout(
#        sidebarPanel(
#          sliderInput("bins",
#            "Number of bins:",
#            min = 1,
#            max = 50,
#            value = 30
#          ),
#          selectizeInput(
#            "foo",
#            label = NULL, choices = state.name,
#            options = list(create = TRUE),
#            multiple = TRUE
#          ),
#          textInput("redd", "What if I?", value = "Wayword...")
#        ),
#  
#        # Show a plot of the generated distribution
#        mainPanel(
#          plotOutput("distPlot")
#        )
#      )
#    )
#  
#    server <- function(input, output, session) {
#      # make sure the  input, output, session arguments are present !IMPORTANT
#  
#      output$distPlot <- renderPlot({
#  
#        # generate bins based on input$bins from ui.R
#        x <- faithful[, 2]
#        bins <- seq(min(x), max(x), length.out = input$bins + 1)
#  
#        # draw the histogram with the specified number of bins
#        hist(x,
#          breaks = bins, col = "darkgray", border = "white",
#          xlab = "Waiting time to next eruption (in mins)",
#          main = "Histogram of waiting times"
#        )
#      })
#    }
#  
#    shinyApp(ui = ui, server = server)
#  }
#  

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  library(shinyStorePlus)
#  
#  if (interactive()) {
#    ui <- fluidPage(
#      # Initialize shinyStorePlus
#      initStore(),
#  
#      # Application title
#      titlePanel("shinyStorePlus by Obi Obianom"),
#  
#      # Sidebar with a slider input for number of bins
#      sidebarLayout(
#        sidebarPanel(
#          sliderInput("bins",
#            "Number of bins:",
#            min = 1,
#            max = 50,
#            value = 30
#          ),
#          selectizeInput(
#            "foo",
#            label = NULL, choices = state.name,
#            options = list(create = TRUE),
#            multiple = TRUE
#          ),
#          textInput("redd", "What if I?", value = "Wayword...")
#        ),
#  
#        # Show a plot of the generated distribution
#        mainPanel(
#          plotOutput("distPlot")
#        )
#      )
#    )
#  
#    server <- function(input, output, session) {
#      # make sure the  input, output, session arguments are present !IMPORTANT
#  
#      output$distPlot <- renderPlot({
#  
#        # generate bins based on input$bins from ui.R
#        x <- faithful[, 2]
#        bins <- seq(min(x), max(x), length.out = input$bins + 1)
#  
#        # draw the histogram with the specified number of bins
#        hist(x,
#          breaks = bins, col = "darkgray", border = "white",
#          xlab = "Waiting time to next eruption (in mins)",
#          main = "Histogram of waiting times"
#        )
#      })
#  
#  
#      # insert at the bottom  !!!IMPORTANT
#      appid <- "applicatio32n501"
#      setupStorage(appId = appid, inputs = TRUE)
#    }
#  
#    shinyApp(ui = ui, server = server)
#  }
#  

