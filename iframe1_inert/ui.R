library(shiny)
library(highcharter)
library(shinyjs)
library(shinyBS)

shinyUI(navbarPage(
  "",
  tabPanel(
    "Average report by incentive level",
    fluidPage(
      useShinyjs(),
      uiOutput("url_allow_popout_UI"),
      includeCSS("www/animate.min.css"),
      # provides pulsating effect
      includeCSS("www/loading-content.css"),
      div(
        id = "loading-tab1_bubblechart",
        class = "loading-content",
        h2(class = "animated infinite pulse", "Loading data...")
      ),
      # highchartOutput("tab1_bubblechart_hc_bubble")
      uiOutput("tab1_bubblechart_hc_bubble_UI"),
      bsModal(
        "bubbleModal",
        "Study Info",
        trigger = "tab1_bubblechart_hc_bubble_click",
        size = "large",
        uiOutput("bubble_model_UI")
      )
    )
  ),
  tabPanel(
    "Distribution of reports by incentive level",
    fluidPage(highchartOutput("tab2_linechart_hc", height = "500px"))
  ),
  tabPanel("About",
           fluidPage(includeMarkdown(
             knitr::knit("tab_about.Rmd")
           ))),
  collapsible = TRUE
))