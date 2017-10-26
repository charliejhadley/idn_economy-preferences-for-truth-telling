library("tidyverse")
library("highcharter")
library("RColorBrewer")
library("shinyjs")
library("RCurl")
library("shinyBS")
library("rfigshare")

source("data-processing.R", local = TRUE)
source("beta-highchart-feature.R", local = TRUE)

shinyServer(
  function(input, output, session){
    
    ## this calls the contents of url_allowPopout.R as if it was copied and 
    ## pasted directly into the shinyServer function. This allows the 
    ## output$url_allow_popout_UI to be displayed in the client
    source("url_allowPopout.R", local = TRUE)
    
    source("tab1_bubblechart.R", local = TRUE)$value
    source("tab2_linechart.R", local = TRUE)$value
    
  }
)