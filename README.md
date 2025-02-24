# shinyStorePlus R package <img src="https://shinystoreplus.obi.obianom.com/hex-shinyStorePlus.png" align="right" width="200">

### THREE MAIN FEATURES: 

 - [x] In-browser storage for Shiny persistent, synchronized data from the inputs using IndexedDB. 
 - [x] Transfer browser link parameters to Shiny input or output values.
 - [x] __Store shiny app visitor views, likes and followers !NEW__

Note: As of version 1.3, shinyStorePlus now allows storage of visitor views, likes and followers

Note: As of version 1.2, shinyStorePlus now stores inputs dynamically generated within the server function.

---------------------------------------------------------------------------------------

### Official docs link: [https://shinystoreplus.obi.obianom.com](https://shinystoreplus.obi.obianom.com)

### Demo 1: https://r2apps.shinyapps.io/shinystoreplus/
### Demo 2: https://r2apps.shinyapps.io/browserLinkToInput/?data=pressure&name=obinna&num=50&outt=wowowow
### Demo 3: https://rpkg.shinyapps.io/shiny-app-views-likes-followers/

### Transformation of various shiny apps with the shinyStorePlus package: https://github.com/oobianom/aagarw30_shinyapps_to-shinyStorePlus

### Start with more simple example code #2: https://github.com/oobianom/shinyStorePlus/tree/main/inst/example/storeInputs

### Start with more simple example code #3: https://github.com/oobianom/shinyStorePlus/tree/main/inst/example/browserLinkToInput

### Teaser video: https://www.youtube.com/watch?v=gkZfCF4Kr7I

### Other packages required for shinyStorePlus: https://depends.rpkg.net/package/shinyStorePlus 

### Author R scholar profile: https://scholar.rpkg.net/aut/obinna+obianom 

[![](https://rpkg.net/pub-age/shinyStorePlus)](https://rpkg.net/package/shinyStorePlus)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/shinyStorePlus)](https://cran.r-project.org/package=shinyStorePlus) [![](https://cranlogs.r-pkg.org/badges/grand-total/shinyStorePlus)](https://cran.r-project.org/package=shinyStorePlus) 




-------------------------------------------------------------------------------------------------

There has been tremendous contribution from the R community on the topic of storing Shiny data and re-using them within an application. The current solutions include Dropbox, Amazon s3, Googlesheets, SQLite, MongoDB and so on. However, a problem with these methods is that it takes a number of steps in order to correctly program your Shiny application for them. More so, the owner of the accounts may need to consistently monitor the storage accounts to ensure that it is not expire or that the data storage is not exhausted. 

__So let's face it. When you develop a shiny app that allows a user to change inputs and see the results immediately, guess what the user is itching to have?? The ability to change the inputs and when they refresh or reopen the shiny app at a later time, still see the inputs they previously entered. Well, <code>shinyStorePlus R package</code> gives that!__

----------------------------------------------------------------------------------------------

As of __version 0.8__ , you are also able to transfer the parameters in a browser link to Shiny inputs and outputs. e.g extracting the value of name from __http://127.0.0.1:6692/?data=pressure&name=obinna&num=50&outt=wowowow__. See [link](https://shinystoreplus.obi.obianom.com/articles/shinystoreplus_v08.html)

-------------------------------------------------------------------------------------------------

![](https://shinystoreplus.obi.obianom.com/shinystoreplus-2.png)

## Installation and Usage

### Install

```{r shinyStorePlus}

# From CRAN
install.packages(shinyStorePlus)

# OR from Github
library(devtools)
install_github("oobianom/shinyStorePlus")

```

### Usage

`library(shinyStorePlus)`

### Use example

`seeexample()`

## Sample code

```
library(shiny)
library(shinyStorePlus)
ui <- fluidPage(
  titlePanel("Simplified shiny app in-browser storage of inputs, long term storage of app views, likes and followers"),
  initStore("all",rpkg.api.key = "c20c5eead7714c119dd3f20bd249a388e72db2aa0f9305d0380b683a37c5296a"), # need to get api at https://api.rpkg.net
  h2("Save App Views"),hr(),
  viewsBox("viewsshow","loading views..."),
  h2("Save App Likes, and allow user to Like!"),hr(),
  lfButton("liket",suffix="likes"),
  h2("Save App Followers, and allow user to Follow!"),hr(),
  lfButton("followt",suffix="followers"),
  h2("Also incorporate in-browser storage for input fields!"),hr(),
  selectInput("sel_not0", "Color (store):", choices = c("","brown", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  selectInput("sel_color", "Color (should be stored):", choices = c("", "green", "blue", "red", "yellow", "cyan"), selected = ""),
  hr(),p(p(i("Like or Follow and Refresh the page - the values are saved and the views are incremented.")))
)

server <- function(input, output, session) {
  # set up views, likes and follows, leave as NULL if you don't need tracking for either
  # in this case, we leave followID as NULL since we don't need to use that
  setupRPKG(viewsID = "viewsshow", likesID = "liket", followID = "followt")

  # setup for in browser tracking for all inputs
  setupStorage(appId = "shinest12", inputs = TRUE, session = session)

  # setup for in browser tracking for specific inputs
  setupStorage(appId = "shinest12", inputs = c("sel_not0","sel_color"), session = session)
}


shinyApp(ui = ui, server = server, options = list(launch.browser = TRUE,shiny.port =7171))


```


### Demo screenshot

![](https://shinystoreplus.obi.obianom.com/shinystoreplus_demo.png)
