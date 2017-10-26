library(plyr)
library(tidyverse)
library(highcharter)
library(RColorBrewer)
library(shinyjs)
library("rfigshare")

source("data-processing.R", local = TRUE)
source("beta-highchart-feature.R", local = TRUE)

shinyServer(
  function(input, output, session){
    
    ## this calls the contents of url_allowPopout.R as if it was copied and 
    ## pasted directly into the shinyServer function. This allows the 
    ## output$url_allow_popout_UI to be displayed in the client
    source("url_allowPopout.R", local = TRUE)
  
    source("tab1_6states.R", local = TRUE)$value
    
    source("tab2_2states.R", local = TRUE)$value
    
    source("tab3_3states.R", local = TRUE)$value
    
    source("tab4_10states.R", local = TRUE)$value
    
    ## ==== About Page
    output$about_page_UI <- renderUI({
      includeHTML(knitr::knit("About_Page.Rmd"))
    })
    
  }
)