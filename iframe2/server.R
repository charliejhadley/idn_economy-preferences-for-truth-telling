library(plyr)
library(tidyverse)
library(highcharter)
library(RColorBrewer)
library(shinyjs)

source("data-processing.R", local = TRUE)

shinyServer(
  function(input, output){
  
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