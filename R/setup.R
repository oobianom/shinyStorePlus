#' Set up inputs for storage
#'
#' Set up the application and inputs to track and retrieve stores
#'
#' @param appId your desired application id
#' @param inputs choose whether to track all inputs or specific input variables
#' @param dyn.inputs dynamic inputs; inputs that get added to the app from the server function
#' @param outputs choose whether to track all outputs or specific output variables
#' @param session the session object passed to function. Default is getDefaultReactiveDomain()
#' @details
#' As of version 1.2, the user may be able to store dynamically generated inputs \cr
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
#'
#' # example 3 with dynamically generated inputs
#' if(interactive()){
#'   ui <- shiny::fluidPage(
#'     titlePanel("Select option,
#'                then referesh page."),
#'     initStore(),
#'     selectInput("sel_color",
#'                 "Color (hardcoded input):",
#'                 choices = c("", "green", "blue",
#'                             "red", "yellow",
#'                             "cyan"), selected = ""),
#'     uiOutput("ui_moreinputs")
#'   )
#'
#'   server <- function(input, output, session) {
#'     observe({
#'       output$ui_moreinputs <- renderUI(
#'         selectInput("sel_month",
#'                     "Month (dynamically generated):",
#'                     choices = c("", month.name),
#'                     selected = "")
#'       )
#'     })
#'
#'     setupStorage(appId = "dynamic02",
#'                  inputs = list("sel_color"),
#'                  dyn.inputs = list("sel_month"),
#'                  session = session)
#'   }
#'
#'   shinyApp(ui = ui, server = server)
#' }
#'
#'
#' }
#'
#' @export
#'

setupStorage <- function(appId, inputs = TRUE, outputs = FALSE, session = getDefaultReactiveDomain(), dyn.inputs = list()) {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output
  # setup input stores
  result <- list(
    appname = appId,
    input = inputs,
    output = outputs,
    dinput = dyn.inputs
  )
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
                  try(shinyWidgets::updateCheckboxGroupButtons(session, inputId = thisrow$var, selected = selrange),silent = TRUE)
                  try(shiny::updateCheckboxGroupInput(session, inputId = thisrow$var, selected = selrange),silent = TRUE)
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
                  try(shinyWidgets::updateSwitchInput(session, inputId = thisrow$var, value = as.logical(thisrow$value)), silent = TRUE)
                  try(shiny::updateCheckboxInput(session, inputId = thisrow$var, value = as.logical(thisrow$value)), silent = TRUE)
                },
                "radio" = {
                  try(shinyWidgets::updateRadioGroupButtons(session, inputId = thisrow$var, selected = thisrow$value), silent = TRUE)
                  try(shiny::updateRadioButtons(session, inputId = thisrow$var, selected = thisrow$value), silent = TRUE)
                },
                {
                  inputId = thisrow$var
                  message <- rmNULL(list(label=NULL, value=selrange, placeholder=NULL))
                  session$sendInputMessage(inputId, message)
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

