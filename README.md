# shinyStorePlus R package

### TWO MAIN FEATURES: (1) In-browser storage for Shiny persistent, synchronized data from the inputs using IndexedDB. (2) Transfer browser link parameters to Shiny input or output values.

---------------------------------------------------------------------------------------

### Official docs link: [https://shinystoreplus.obi.obianom.com](https://shinystoreplus.obi.obianom.com)

### Demo 1: [View Demo Shiny  App](https://r2apps.shinyapps.io/shinystoreplus)
### Demo 2: [View Demo Shiny  App](https://r2apps.shinyapps.io/browserLinkToInput?data=pressure&name=obinna&num=50&outt=wowowow)

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

## Demo 



### Demo screenshot

![](https://shinystoreplus.obi.obianom.com/shinystoreplus_demo.png)
