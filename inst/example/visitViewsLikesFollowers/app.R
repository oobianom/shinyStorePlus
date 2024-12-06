library(shiny)
library(shinyStorePlus)
ui <- fluidPage(
  titlePanel("Simplified shiny app storage of views, likes and followers"),
  initStore("all",rpkg.api.key = "c20c5eead7714c119dd3f20bd249a388e72db2aa0f9305d0380b683a37c5296a"),
  h2("Save App Views"),hr(),
  viewsBox("viewsshow","loading views..."),
  h2("Save App Likes, and allow user to Like!"),hr(),
  lfButton("liket",suffix="likes"),
  h2("Save App Followers, and allow user to Follow!"),hr(),
  lfButton("followt",suffix="followers"),
  h2("Also incorporate in-browser storage for input fields!"),hr(),
  selectInput("sel_not0", "Color (store):", choices = c("","brown", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  selectInput("sel_color", "Color (should be stored):", choices = c("", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  hr(),p(p(tags$i("Like or Follow and Refresh the page - the values are saved and the views are incremented.")))
)

server <- function(input, output, session) {
  # set up views, likes and follows, leave as NULL if you don't need tracking for either
  # in this case, we leave followID as NULL since we don't need to use that
  setupRPKG(viewsID = "viewsshow", likesID = "liket", followID = "followt")

  # setup for in browser tracking
  setupStorage(appId = "shinest12", inputs = c("sel_not0","sel_color"), session = session)
}


shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE,shiny.port =7171))




