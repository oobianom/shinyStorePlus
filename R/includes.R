#' Included package scripts
#'
#' Include Dexie and the package script in the header
#'
#' @return Initialize the storage by including scripts necessary for the persistent storage handling
#' @examples
#' \donttest{
#' library(shiny)
#' library(shinyStorePlus)
#'
#' if (interactive()) {
#'   ui <- shiny::fluidPage(
#'     # initialize stores
#'     initStore(),
#'     titlePanel("Sample
#'              shinyStorePlus Init Inputs"),
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
#'   }
#'   shiny::shinyApp(ui = ui, server = server)
#' }
#' }
#'
#' @export
#'

initStore <- function() {
  ssp <- "shinyStorePlus"
  vs <- "0.6"
  template.loc1 <- file.path(find.package(package = ssp), "scripts")
  htmltools::htmlDependency(
    ssp, vs,
    src = template.loc1,
    script = c("dexie.js", paste0(tolower(ssp), ".js")),
    all_files = FALSE
  )
}
