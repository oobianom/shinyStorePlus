# shinyStorePlus R package

In-browser storage for Shiny persistent, synchronized data from the inputs using IndexedDB

There has been tremendous contribution from the R community on the topic of storing Shiny data and re-using them within an application. The current solutions include Dropbox, Amazon s3, Googlesheets, SQLite, MongoDB and so on. However, a problem with these methods is that it takes a number of steps in order to correctly program your Shiny application for them. More so, the owner of the accounts may need to consistently monitor the storage accounts to ensure that it is not expire or that the data storage is not exhausted. 

__So let's face it. When you build a shiny app that allows a user to change inputs and see the results immediately, guess what the user is itching to have?? The ability to change the inputs and when they refresh or reopen the shiny app at a later time, still see the inputs they previously entered. Well, <code>shinyStorePlus R package</code> gives that!__

## Installation and Usage

### Install

`install.packages(shinyStorePlus)`

### Usage

`library(shinyStorePlus)`

### Use example

`seeexample()`

## Demo 

### Demo link

[Link to shiny app](https://r2apps.shinyapps.io/shinystoreplus)

### Demo screenshot

![](https://shinystoreplus.obi.obianom.com/shinystoreplus_demo.png)
