## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shinyStorePlus)
#  
#  # seeexample()
#  

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  
#  # library
#  library(shiny)
#  library(shinyStorePlus)
#  
#  if(interactive()) {
#  ui <- fluidPage(
#    titlePanel("Sample
#               shinyStorePlus Track Inputs"),
#  
#    #initialize stores
#    initStore(),
#  
#    sidebarLayout(
#      sidebarPanel(
#        sliderInput("nextgenshinyapps1",
#                    "Number of bins:",
#                    min = 1,
#                    max = 200,
#                    value = 150),
#        textInput("caption",
#                  "simple caption:",
#                  "summary, try editing"),
#        numericInput("obs",
#                     "sample observations:",
#                     10, min = 1, max = 100)
#      ),
#      mainPanel(
#        plotOutput("distPlot")
#      )
#    )
#  )
#  
#  server <- function(input, output, session) {
#  
#    output$distPlot <- renderPlot({
#      # generate bins based on input$bins from ui.R
#      x <- faithful[, 2]
#      bins <- seq(min(x), max(x), length.out = input$nextgenshinyapps1 + 1)
#  
#      # draw the histogram with the specified number of bins
#      hist(x, breaks = bins, col = "darkgray", border = "white")
#    })
#  
#  
#  
#    #stores setup - insert at the bottom  !!!IMPORTANT
#    appid = "application31"
#    setupStorage(appId = appid,inputs = TRUE)
#  
#  
#  }
#  
#  shinyApp(ui = ui, server = server)
#  }
#  

