library(shinyjs)
library(leaflet)
library(shinyBS)
library(highcharter)

shinyUI(
  navbarPage(
    "",
    tabPanel(
      "Average Report over Repetitions",
      
      fluidPage(
        useShinyjs(),
        uiOutput("url_allow_popout_UI"),
        includeCSS("www/animate.min.css"),
        # provides pulsating effect
        includeCSS("www/loading-content.css"),
        div(
          id = "loading-tab1_scatter",
          class = "loading-content",
          h2(class = "animated infinite pulse", "Loading data...")
        ),
        highchartOutput("tab1_scatter_hc"),
        bsModal(
          "tab1_scatter_bubbleModal",
          "Study Info",
          trigger = "tab1_scatter_hc_click",
          size = "large",
          uiOutput("tab1_scatter_bubble_model_UI")
        )
      
    )),
    tabPanel("About",
             fluidPage(includeMarkdown(
               knitr::knit("tab_about.Rmd")
             ))
             ),
    collapsible = TRUE
  )
)