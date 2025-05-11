#' Included package scripts
#'
#' Include Dexie and the package script in the header
#'
#' @return Initialize the storage by including scripts necessary for the persistent storage handling
#' @param src scripts to include
#' @param rpkg.api.key API key obtained from rpkg.net to use if src = "rpkg" or "all"
#' @note
#' Choices for "src":\cr\cr
#' "browser" - include only scripts relevant for storing data within browser\cr\cr
#' "rpkg" - include scripts relevant for storing app views, likes and followers in rpkg.net\cr\cr
#' "all" - include all scripts\cr
#'
#' @details
#' To unlock the "rpkg" or "all" functionality, you'll need to obtain a FREE API key from https://api.rpkg.net \cr
#' However, before requesting your API key, it's recommended to do an initial deployment of your app.
#' This is because the API key generation process requires you to provide the link to your Shiny app.
#'
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
#'
#'
#' # Example app that stores App user views, likes and followers
#'
#' library(shiny)
#' library(shinyStorePlus)
#'
#' if (interactive()) {
#' ui <- fluidPage(
#'   titlePanel("Simplified shiny app storage of views, likes and followers"),
#'   initStore("all",rpkg.api.key =
#'   "c20c5eead7714c119dd3f20bd249a388e72db2aa0f9305d0380b683a37c5296a"),
#'   # get API key from https://api.rpkg.net
#'   h2("Save App Views"),hr(),
#'   viewsBox("viewsshow","loading views..."),
#'   h2("Save App Likes, and allow user to Like!"),hr(),
#'   lfButton("liket",suffix="likes"),
#'   h2("Save App Followers, and allow user to Follow!"),hr(),
#'   lfButton("followt",suffix="followers"),
#'   hr(),p(p("Like or Follow and Refresh the page -
#'   the values are saved and the views are incremented."))
#' )
#'
#' server <- function(input, output, session) {
#'   # set up views, likes and follows, leave as
#'   # NULL if you don't need tracking for either
#'   # in this case, we leave followID as NULL
#'   # since we don't need to use that
#'   setupRPKG(
#'     viewsID = "viewsshow",
#'     likesID = "liket",
#'     followID = "followt"
#'  )
#' }
#'
#'
#' shinyApp(ui = ui, server = server)
#' }
#'
#' }
#'
#' @export
#'

initStore <- function(src = c("browser","rpkg","all"), rpkg.api.key) {
  src = match.arg(src)
  if(src %in% c("rpkg","all") & missing(rpkg.api.key)){
    stop("In order to use the rpkg API, you need to obtain a FREE API key from https://api.rpkg.net")
  }
  switch (src,
          "browser" = initBRStore(),
          "rpkg" = initRPKGStore(API = rpkg.api.key),
          "all" = list(initBRStore(),initRPKGStore(API = rpkg.api.key))
  )
}


# sub functions for inclusion of scripts


initBRStore <- function() {
  ssp <- "shinyStorePlus"
  vs <- "1.1"
  template.loc1 <- file.path(find.package(package = .packageName), "scripts")
  htmltools::htmlDependency(
    ssp, vs,
    src = template.loc1,
    script = c("dexie.js", "misc.js", paste0(tolower(ssp), ".js")),
    all_files = FALSE
  )
}


initRPKGStore <- function(API) {
  template.loc1 <- file.path(find.package(package = .packageName), "scripts")
  htmltools::htmlDependency(
    "rpkg", "0.1",
    src = template.loc1,
    script = list(src = "rpkg.js", identifier=API, id="rpkgapiscript"),
    all_files = FALSE
  )
}
