% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setup.R
\name{setupStorage}
\alias{setupStorage}
\title{Set up inputs for storage}
\usage{
setupStorage(
  appId,
  inputs = TRUE,
  outputs = FALSE,
  session = getDefaultReactiveDomain(),
  dyn.inputs = list()
)
}
\arguments{
\item{appId}{your desired application id}

\item{inputs}{choose whether to track all inputs or specific input variables}

\item{outputs}{choose whether to track all outputs or specific output variables}

\item{session}{current session to track}

\item{dyn.inputs}{dynamic inputs; inputs that get added to the app from the server function}
}
\value{
Embed within a page storage that allows input changes to be saved without slowing down the shiny application
}
\description{
Set up the application and inputs to track and retrieve stores
}
\details{
As of version 1.2, the user may be able to store dynamically generated inputs \cr
}
\note{
the inputs argument may be a \code{TRUE} or \code{FALSE} or a list of input ids. More examples are located at https://github.com/oobianom/aagarw30_shinyapps_to-shinyStorePlus
}
