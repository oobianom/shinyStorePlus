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
    if (!is.null(input$sSP1locationParams)) {

      if(input$sSP1locationParams != "{}"){
      var.list <- as.data.frame(jsonlite::fromJSON((input$sSP1locationParams)))
      var.list <-as.data.frame(t(var.list))
      var.list$var <- row.names(var.list)
      #var.list <- var.list[(var.list$V1 != "NULL"), ]
print(var.list)
      if (length(var.list)) {
        if (nrow(var.list)) {
          for (row in 1:nrow(var.list)) {
            thisrow <- var.list[row, ]

            if (grepl("bound-input", thisrow$type)) {
              typeofinput <- strsplit(thisrow$type, "\\.")[[1]][1]
              finalval <- unlist(thisrow$V1)
              switch(inputtype,
                "select" = {
                  shiny::updateSelectInput(session, inputId = thisrow$var, selected = finalval)
                },
                "checkboxgroup" = {
                  shiny::updateCheckboxGroupInput(session, inputId = thisrow$var, selected = finalval)
                },
                "dateinput" = {
                  if (length(finalval) == 1) {
                    shiny::updateDateInput(session, inputId = thisrow$var, value = finalval)
                  } else {
                    shiny::updateDateRangeInput(session, start = finalval[1], end = finalval[2], inputId = thisrow$var)
                  }
                },
                "dateinputrange" = {
                  shiny::updateDateRangeInput(session, start = finalval[1], end = finalval[2], inputId = thisrow$var)
                },
                "checkbox" = {
                  shiny::updateCheckboxInput(session, inputId = thisrow$var, value = as.logical(thisrow$V1))
                },
                "radio" = {
                  shiny::updateRadioButtons(session, inputId = thisrow$var, selected = thisrow$V1)
                },
                {
                  shiny::updateTextInput(session, inputId = thisrow$var, value = finalval)
                }
              )
            }
          }
        }
      }
      }
    }
  })
}
