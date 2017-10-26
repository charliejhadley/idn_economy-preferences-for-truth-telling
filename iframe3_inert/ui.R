library(shinyjs)
library(leaflet)
library(shinyBS)
library(highcharter)

shinyUI(navbarPage(
  "Experimental Economics",
  tabPanel("World Map",
           fluidPage(
             useShinyjs(),
             uiOutput("url_allow_popout_UI"),
             div(
               id = "loading-tab1_worldmap",
               class = "loading-content",
               h2(class = "animated infinite pulse", "Loading data...")
             ),
             leafletOutput(
             "tab1_worldmap_leaflet",width = "780px", height = "500px"
           ))),
  tabPanel("Average Report by Country",
           
           fluidPage(
             includeCSS("www/animate.min.css"),
             # provides pulsating effect
             includeCSS("www/loading-content.css"),
             div(
               id = "loading-tab2_scatterplot",
               class = "loading-content",
               h2(class = "animated infinite pulse", "Loading data...")
             ),
             # highchartOutput("tab2_scatterplot_hc_bubble")
             uiOutput("tab2_scatterplot_hc_UI"),
             bsModal(
               "tab2_scatterplot_bubbleModal",
               "Study Info",
               trigger = "tab2_scatterplot_hc_click",
               size = "large",
               uiOutput("tab2_scatterplot_bubble_model_UI")
             )
             
             
           )),
  tabPanel("About",
           fluidPage(includeMarkdown(
             knitr::knit("tab_about.Rmd")
           ))), collapsible = TRUE
))