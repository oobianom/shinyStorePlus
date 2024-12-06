#' Setup configuration for shiny page views, likes and followers
#'
#' Utilize the rpkg.net API to store and retrieve page views, likes and followers
#'
#' @param viewsID Optional. The container ID to display views
#' @param likesID Optional. The button ID to display likes
#' @param followID Optional. The button ID to display followers
#' @param session Optional. Current session to track
#' @param inputId The input slot that will be used to access the value.
#' @param label The contents of the button or link–usually a text label, but you could also use any other HTML, like an image.
#' @param icon.follow Optional. shiny::icon() to activate follow
#' @param icon.unfollow Optional. shiny::icon() to de-activate follow
#' @param icon.like Optional. shiny::icon() to activate likes
#' @param icon.unlike Optional. shiny::icon() to de-activate likes
#' @param text.follow Optional. text to activate follow
#' @param text.unfollow Optional. text to de-activate follow
#' @param text.like Optional. text to activate likes
#' @param text.unlike Optional. text to de-activate likes
#' @param icon Optional. A shiny::icon() to appear on the button.
#' @param width Optional. The width of the button input, e.g. '500px', or '100\%'
#' @param suffix suffix to add to likes or followers count
#' @param ... Optional. Named attributes to be applied to the likes or follows button or views box.
#' @rdname rpkgapi
#'
#' @description
#' To unlock this functionality, you'll need to obtain a FREE API key from https://api.rpkg.net \CR
#' However, before requesting your API key, it's recommended to do an initial deployment of your app.
#' This is because the API key generation process requires you to provide the link to your Shiny app.
#'
#' @export
setupRPKG <-
  function(viewsID = NULL,
           likesID = NULL,
           followID = NULL,
           session = getDefaultReactiveDomain(),
           icon.follow = icon("user-plus"),
           icon.unfollow = icon("user-plus"),
           icon.like = icon("heart"),
           icon.unlike = icon("heart",class = "fa-solid"),
           text.follow = "",
           text.unfollow = "",
           text.like = "",
           text.unlike = ""
           ) {
  envir <- parent.frame()
  input <- envir$input
  output <- envir$output
  # input$totalviewstracker # retrieve views value
  shiny::observeEvent(input$feedliketracker,{
    if(input$feedliketracker$liked == TRUE)
      updateActionButton(session,likesID, label = text.unlike, icon = icon.unlike)
    if(input$feedliketracker$liked == FALSE)
      updateActionButton(session,likesID, label = text.like, icon = icon.like)
  })

  shiny::observeEvent(input$feedfollowtracker,{
    if(input$feedfollowtracker$followed == TRUE)
      updateActionButton(session,followID, label=text.unfollow, icon = icon.unfollow)
    if(input$feedfollowtracker$followed == FALSE)
      updateActionButton(session,followID, label=text.follow, icon = icon.follow)
  })

  session$sendCustomMessage(
    "triggerViewsLikesFollows",
    list(
      views = viewsID,
      likes = likesID,
      follows = followID
    )
  )
}



#' @rdname rpkgapi
#' @export
viewsBox<- function(inputId,...){
  tags$span(
    id = inputId,
    class = "shinyspviewsbox shiny-bound-input",
    style = "display:inline-block",
    ...
  )
}

#' @rdname rpkgapi
#' @export
lfButton<- function(inputId, width = NULL, suffix = "", ...){
  tags$span(
  actionButton(
    inputId =  inputId, label = "", icon = icon("circle-dot",class = "fa-solid"), width = width, class="shinysplfbtn", style="pading:3px; border-radius:5px", ...
  ),
  tags$b(
  tags$span(id = paste0(inputId,"-totalv2"), class="shinysplfbtn-totl", style="display:inline-block; padding:0 5px;"),
  tags$span(id = paste0(inputId,"-totalv3"), class="shinysplfbtn-totl2", suffix)
  )
  )
}





