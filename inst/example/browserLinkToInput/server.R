
server <- function(input, output, session) {

  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins1 + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = "green", border = "red")
  })


  #to delete storage
  #clearStore("application501")

  #insert at the bottom  !!!IMPORTANT
  link2input(dataset="name")

}

