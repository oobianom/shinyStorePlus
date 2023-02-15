#' Set up inputs for storage
#'
#' Set up the application and inputs to track and retrieve stores
#'
#' @param appId your desired application id
#' @param inputs choose whether to track all inputs or specific input variables
#' @param outputs choose whether to track all outputs or specific output variables
#' @param session current session to track
#'
#' @note the inputs argument may be a \code{TRUE} or \code{FALSE} or a list of input ids. More examples are located at https://github.com/oobianom/aagarw30_shinyapps_to-shinyStorePlus
#' @return Embed within a page storage that allows input changes to be saved without slowing down the shiny application
#' @examples
#' \donttest{
#' library(shiny)
#' library(shinyStorePlus)
#'
#' # example 1 that tracks all inputs
#' if (interactive()) {
#'   ui <- shiny::fluidPage(
#'     titlePanel("EX1
#'              shinyStorePlus All Inputs"),
#'     initStore(),
#'     sidebarLayout(
#'       sidebarPanel(
#'         sliderInput("nextgenshinyapps1",
#'           "Number of bins:",
#'           min = 1,
#'           max = 200,
#'           value = 150
#'         ),
#'         textInput(
#'           "caption",
#'           "simple caption:",
#'           "try editing - r2resize pkg"
#'         ),
#'         numericInput("obs",
#'           "sample observations:",
#'           10,
#'           min = 1, max = 100
#'         )
#'       ),
#'       mainPanel(
#'         plotOutput("distPlot")
#'       )
#'     )
#'   )
#'   server <- function(input, output, session) {
#'     output$distPlot <- renderPlot({
#'       x <- faithful[, 2]
#'       bins <- seq(min(x),
#'         max(x),
#'         length.out =
#'           input$nextgenshinyapps1 + 1
#'       )
#'       hist(x,
#'         breaks = bins,
#'         col = "blue",
#'         border = "gray"
#'       )
#'     })
#'
#'     # insert at the bottom
#'     appid <- "application01"
#'     setupStorage(
#'       appId = appid,
#'       inputs = TRUE
#'     )
#'   }
#'   shiny::shinyApp(ui = ui, server = server)
#' }
#'
#'
#' # example 2 that tracks only 2 inputs
#' if (interactive()) {
#'   ui <- shiny::fluidPage(
#'     # init stores
#'     initStore(),
#'     titlePanel("Ex2:
#'              shinyStorePlus Some Inputs"),
#'     sidebarLayout(
#'       sidebarPanel(
#'         sliderInput("nextgenshinyapps1",
#'           "Number of bins:",
#'           min = 1,
#'           max = 200,
#'           value = 150
#'         ),
#'         textInput(
#'           "caption",
#'           "simple caption:",
#'           "summary, try editing"
#'         ),
#'         numericInput("obs",
#'           "sample observations:",
#'           10,
#'           min = 1, max = 100
#'         )
#'       ),
#'       mainPanel(
#'         plotOutput("distPlot")
#'       )
#'     )
#'   )
#'   server <- function(input, output, session) {
#'     output$distPlot <- renderPlot({
#'       x <- faithful[, 2]
#'       bins <- seq(min(x),
#'         max(x),
#'         length.out =
#'           input$nextgenshinyapps1 + 1
#'       )
#'       hist(x,
#'         breaks = bins,
#'         col = "blue",
#'         border = "gray"
#'       )
#'     })
#'
#'     # insert at the bottom  !!!IMPORTANT
#'     appid <- "application023"
#'     setupStorage(
#'       appId = appid,
#'       inputs = list(
#'         "nextgenshinyapps1",
#'         "caption"
#'       )
#'     )
#'   }
#'   shiny::shinyApp(ui = ui, server = server)
#' }
#' }
#'
#' @export
#'

setupStorage <- function(appId, inputs = TRUE, outputs = FALSE, session = getDefaultReactiveDomain()) {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output
  # setup input stores
  result <- (list(
    appname = appId,
    input = inputs,
    output = outputs
  ))
  session$sendCustomMessage(
    "retriever",
    result
  )

  # retrieve any previously stored
  # collect previous data
  shiny::observe({
    if (!is.null(input$transmittedDatax0x)) {
      var.list <- as.data.frame(jsonlite::fromJSON((input$transmittedDatax0x)))
      var.list <- var.list[(var.list$value != "NULL"), ]

      if (length(var.list)) {
        if (nrow(var.list)) {
          for (row in 1:nrow(var.list)) {
            thisrow <- var.list[row, ]

            if (grepl("bound-input", thisrow$type)) {
              typeofinput <- strsplit(thisrow$type, "\\.")[[1]][1]
              selrange <- unlist(thisrow$value)
              switch(typeofinput,
                "select" = {
                  shiny::updateSelectInput(session, inputId = thisrow$var, selected = selrange)
                },
                "checkboxgroup" = {
                  shiny::updateCheckboxGroupInput(session, inputId = thisrow$var, selected = selrange)
                },
                "dateinput" = {
                  if (length(selrange) == 1) {
                    shiny::updateDateInput(session, inputId = thisrow$var, value = selrange)
                  } else {
                    shiny::updateDateRangeInput(session, start = selrange[1], end = selrange[2], inputId = thisrow$var)
                  }
                },
                "dateinputrange" = {
                  shiny::updateDateRangeInput(session, start = selrange[1], end = selrange[2], inputId = thisrow$var)
                },
                "checkbox" = {
                  shiny::updateCheckboxInput(session, inputId = thisrow$var, value = as.logical(thisrow$value))
                },
                "radio" = {
                  shiny::updateRadioButtons(session, inputId = thisrow$var, selected = thisrow$value)
                },
                {
                  shiny::updateTextInput(session, inputId = thisrow$var, value = selrange)
                }
              )
            }

            # for outputs
            if (grepl("bound-output", thisrow$type)) {
              output[[thisrow$var]] <- shiny::renderText({
                unlist(thisrow$value)
              })
            }
          }
        }
      }
    }
  })
}
