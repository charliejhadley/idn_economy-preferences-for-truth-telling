library(shinyjs)
library(leaflet)
library(shinyBS)
library(highcharter)

shinyUI(
  navbarPage(
    "Experimental Economics",
    tabPanel(
      "Distribution by gender",
      fluidPage(
        useShinyjs(),
        uiOutput("url_allow_popout_UI"),
        uiOutput("tab1_linechart_hc_UI"),
        bsModal(
          "tab1_linechart_bubbleModal",
          "Study Info",
          trigger = "tab1_linechart_hc_click",
          size = "large",
          uiOutput("tab1_linechart_bubble_model_UI")
        )
        
      )
      
    ),
    tabPanel(
      "Average report by gender",
      
      fluidPage(
        includeCSS("www/animate.min.css"),
        # provides pulsating effect
        includeCSS("www/loading-content.css"),
        div(
          id = "loading-tab2_scatter",
          class = "loading-content",
          h2(class = "animated infinite pulse", "Loading data...")
        ),
        # highchartOutput("tab2_scatter_hc_bubble")
        uiOutput("tab2_scatter_hc_UI"),
        bsModal(
          "tab2_scatter_bubbleModal",
          "Study Info",
          trigger = "tab2_scatter_hc_click",
          size = "large",
          uiOutput("tab2_scatter_bubble_model_UI")
        )
      )
    ),
    tabPanel("About",
             fluidPage(includeMarkdown(
               knitr::knit("tab_about.Rmd")
             ))),
    collapsible = TRUE
  )
)