#' Convert Browser Location Parameters to Shiny Input and Output Values
#'
#' Parse the browser link and retrieve parameters for inclusion as values in inputs or outputs
#'
#' @param ... List of Shiny input IDs to match with window location parameters
#' @param inputtype Type of inputs being included
#'
#' @note a great example of how to use this functionality can be found in https://cran.r-project.org/web/packages/shinyStorePlus/vignettes/shinystoreplus_v08.html
#' @return Setting of the Shiny inputs to the values of the parameters in the browser link
#' @examples
#' if (interactive()) {
#'   # within the server function
#'   server <- function(input, output, session) {
#'     link2input(
#'       cd323 = "name",
#'       datasetbin = "data",
#'       numberid = "num"
#'     )
#'
#'     link2input(
#'       outputid = "outt",
#'       inputtype = "output"
#'     )
#'   }
#' }
#' @export
#'

link2input <- function(..., inputtype = "default", session = getDefaultReactiveDomain()) {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output

  elm <- list(...)

  # retrieve parameters in the browser link
  # collect and parse data
  shiny::observe({
    if (!is.null(input$sSP1locationParams)) {
      if (input$sSP1locationParams != "{}") {
        var.list <- as.data.frame(jsonlite::fromJSON((input$sSP1locationParams)))
        var.list <- as.data.frame(t(var.list))
        var.list$var <- row.names(var.list)
        var.list <- var.list[(var.list$V1 != "NULL"), ]
        if (length(var.list)) {
          if (nrow(var.list) & length(names(elm))) {
            for (row in names(elm)) {
              finalval <- var.list[var.list$var == elm[[row]], ][1]
              if (nrow(finalval)) {
                thisrow <- list(
                  var = row,
                  val = as.character(finalval)
                )
                switch(inputtype,
                  "select" = {
                    shiny::updateSelectInput(session, inputId = thisrow$var, selected = thisrow$val)
                  },
                  "checkboxgroup" = {
                    shiny::updateCheckboxGroupInput(session, inputId = thisrow$var, selected = thisrow$val)
                  },
                  "dateinput" = {
                    if (length(thisrow$val) == 1) {
                      shiny::updateDateInput(session, inputId = thisrow$var, value = thisrow$val)
                    } else {
                      shiny::updateDateRangeInput(session, start = thisrow$val[1], end = thisrow$val[2], inputId = thisrow$var)
                    }
                  },
                  "dateinputrange" = {
                    shiny::updateDateRangeInput(session, start = thisrow$val[1], end = thisrow$val[2], inputId = thisrow$var)
                  },
                  "checkbox" = {
                    shiny::updateCheckboxInput(session, inputId = thisrow$var, value = as.logical(thisrow$val))
                  },
                  "radio" = {
                    shiny::updateRadioButtons(session, inputId = thisrow$var, selected = thisrow$val)
                  },
                  "output" = {
                    output[[thisrow$var]] <- renderText({
                      thisrow$val
                    })
                  },
                  {
                    shiny::updateTextInput(session, inputId = thisrow$var, value = thisrow$val)
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
