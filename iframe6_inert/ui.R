library(shiny)
library(highcharter)
library(shinyjs)
library(shinyBS)

shinyUI(
  navbarPage(
    "",
    tabPanel(
      "Distribution of reports: 6 states",
      fluidPage(
        useShinyjs(),
        uiOutput("url_allow_popout_UI"),
        includeCSS("www/animate.min.css"),
        # provides pulsating effect
        includeCSS("www/loading-content.css"),
        div(
          id = "loading-tab1_6states",
          class = "loading-content",
          h2(class = "animated infinite pulse", "Loading data...")
        ),
        # highchartOutput("tab1_6states_hc_bubble")
        uiOutput("tab1_6states_line_hc_UI"),
        bsModal(
          "tab1_6states_bubbleModal",
          "Study Info",
          trigger = "tab1_6states_line_hc_click",
          size = "large",
          uiOutput("tab1_6states_bubble_model_UI")
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