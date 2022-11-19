#' Convert Browser Location Parameters to Shiny Input Values
#'
#' Parse the browser link and retrieve parameters for inclusion as values in inputs
#'
#' @param ... List of Shiny input IDs to match with window location parameters
#' @param inputtype Type of inputs being included
#'
#' @note the entered inputs should be a list in order to be parsed
#' @return Setting of the Shiny inputs to the values of the parameters in the browser link
#' @examples
#'
#' link2input(id1 = "name", id2="type")
#' @export
#'

link2input <- function(...,inputtype = "default") {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output
  session <- envir$session

  # retrieve parameters in the browser link
  # collect and parse data
  shiny::observe({
    print("yess its not null")
    if (!is.null(input$sSP1locationParams)) {
      var.list <- as.data.frame(jsonlite::fromJSON((input$transmittedDatax0x)))
      var.list <- var.list[(var.list$value != "NULL"), ]
print(var.list)
      # if (length(var.list)) {
      #   if (nrow(var.list)) {
      #     for (row in 1:nrow(var.list)) {
      #       thisrow <- var.list[row, ]
      #
      #       if (grepl("bound-input", thisrow$type)) {
      #         typeofinput <- strsplit(thisrow$type, "\\.")[[1]][1]
      #         selrange <- unlist(thisrow$value)
      #         switch(typeofinput,
      #           "select" = {
      #             shiny::updateSelectInput(session, inputId = thisrow$var, selected = selrange)
      #           },
      #           "checkboxgroup" = {
      #             shiny::updateCheckboxGroupInput(session, inputId = thisrow$var, selected = selrange)
      #           },
      #           "dateinput" = {
      #             if (length(selrange) == 1) {
      #               shiny::updateDateInput(session, inputId = thisrow$var, value = selrange)
      #             } else {
      #               shiny::updateDateRangeInput(session, start = selrange[1], end = selrange[2], inputId = thisrow$var)
      #             }
      #           },
      #           "dateinputrange" = {
      #             shiny::updateDateRangeInput(session, start = selrange[1], end = selrange[2], inputId = thisrow$var)
      #           },
      #           "checkbox" = {
      #             shiny::updateCheckboxInput(session, inputId = thisrow$var, value = as.logical(thisrow$value))
      #           },
      #           "radio" = {
      #             shiny::updateRadioButtons(session, inputId = thisrow$var, selected = thisrow$value)
      #           },
      #           {
      #             shiny::updateTextInput(session, inputId = thisrow$var, value = selrange)
      #           }
      #         )
      #       }
      #
      #       # for outputs
      #       if (grepl("bound-output", thisrow$type)) {
      #         output[[thisrow$var]] <- shiny::renderText({
      #           unlist(thisrow$value)
      #         })
      #       }
      #     }
      #   }
      # }
    }
  })
}
