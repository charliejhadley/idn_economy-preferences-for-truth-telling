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
    ## ==== tab2
    tabPanel("2 states",
             fluidPage(
               div(
                 id = "loading-tab2_2states",
                 class = "loading-content",
                 h2(class = "animated infinite pulse", "Loading data...")
               ),
               # highchartOutput("tab2_2states_hc_bubble")
               uiOutput("tab2_2states_line_hc_UI"),
               bsModal(
                 "tab2_2states_bubbleModal",
                 "Study Info",
                 trigger = "tab2_2states_line_hc_click",
                 size = "large",
                 uiOutput("tab2_2states_bubble_model_UI")
               )
               
             )),
    ## tab 3
    tabPanel("3 states",
             fluidPage(
               div(
                 id = "loading-tab3_3states",
                 class = "loading-content",
                 h2(class = "animated infinite pulse", "Loading data...")
               ),
               # highchartOutput("tab3_3states_hc_bubble")
               uiOutput("tab3_3states_line_hc_UI"),
               bsModal(
                 "tab3_3states_bubbleModal",
                 "Study Info",
                 trigger = "tab3_3states_line_hc_click",
                 size = "large",
                 uiOutput("tab3_3states_bubble_model_UI")
               )
               
             )),
    ## tab 4
    tabPanel("10 states",
             fluidPage(
               div(
                 id = "loading-tab4_10states",
                 class = "loading-content",
                 h2(class = "animated infinite pulse", "Loading data...")
               ),
               # highchartOutput("tab4_10states_hc_bubble")
               uiOutput("tab4_10states_line_hc_UI"),
               bsModal(
                 "tab4_10states_bubbleModal",
                 "Study Info",
                 trigger = "tab4_10states_line_hc_click",
                 size = "large",
                 uiOutput("tab4_10states_bubble_model_UI")
               )
               
             )),
    tabPanel("About",
             fluidPage(includeMarkdown(
               knitr::knit("tab_about.Rmd")
             ))),
    collapsible = TRUE
  )
)