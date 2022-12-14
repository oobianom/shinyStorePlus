% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clearStore.R
\name{clearStore}
\alias{clearStore}
\title{Clear storage for an application}
\usage{
clearStore(appId, session = getDefaultReactiveDomain())
}
\arguments{
\item{appId}{the application identification}

\item{session}{session object}
}
\value{
No return value, called for side effects
}
\description{
Remove all stored inputs of an application
}
\note{
Ensure not to use this function when the inputs are intended to be tracked.
}
\examples{
if (interactive()) {
  library(shiny)
  library(shinyStorePlus)

  ui <- fluidPage(
    # initialize stores
    initStore(),
    "Sample delete storage",
    selectInput("dataset",
      label = "Dataset",
      choices = c("dataset 1", "dataset 2")
    )
  )
  server <- function(input, output, session) {
    appid <- "application01"
    clearStore(appId = appid)
  }
  shinyApp(ui, server)
}
}
