library(plyr)
library(tidyverse)
library(highcharter)
library(RColorBrewer)
library(shinyjs)
library(sp)
library(oidnChaRts)
library(leaflet)
library(scales)
library(highcharter)
library(shinyBS)

source("data-processing.R", local = TRUE)

shinyServer(
  function(input, output){
    
    source("tab1_worldmap.R", local = TRUE)$value
    source("tab2_scatterplot.R", local = TRUE)$value
  }
)