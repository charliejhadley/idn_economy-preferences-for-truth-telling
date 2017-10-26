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
             fluidRow(
               column(
                 actionButton("tab2_scatterplot_reset", "Back to full sample"),
                 bsTooltip(
                   "tab2_scatterplot_reset",
                   "Click here to return the visualisation to our defaults",
                   "bottom",
                   options = list(container = "body")
                 ),
                 width = 3
               ),
               div(
                 id = "tab2_scatterplot_controls",
                 # div provides the target for the reset button,
                 fluidPage(
                   column(
                     radioButtons(
                       "tab2_scatterplot_population_options",
                       label = "Students vs General Population",
                       choices = list(
                         "Both" = "both",
                         "Students" = 1,
                         "General Population" = 0
                       ),
                       selected = "both",
                       inline = TRUE
                     ),
                     width = 5
                   )
                 ),
                 bsCollapsePanel(HTML(
                   paste0(
                     '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                     "&nbsp;Click here for more filters &nbsp;&nbsp;&nbsp; (and click on a circle to open a study or draw a square to zoom)"
                   )
                 ),
                 fluidRow(
                   column(
                     uiOutput("tab2_scatterplot_citation_selectize_UI"),
                     bsTooltip(
                       "tab2_scatterplot_citation_selectize_UI",
                       "Filter the experiments by citations by deleting/adding their names",
                       "bottom",
                       options = list(container = "body")
                     ),
                     radioButtons(
                       "tab2_scatterplot_location",
                       label = "Experiment location?",
                       choices = list(
                         "Both" = "both",
                         "Only lab" = 0,
                         "Only Online/Telephone" = 1
                       ),
                       selected = "both",
                       inline = TRUE
                     ),
                     width = 6
                   ),
                   column(
                     radioButtons(
                       "tab2_scatterplot_controls_suggested",
                       label = "Control Rolls Suggested?",
                       choices = list(
                         "Both" = "both",
                         "Experimenter suggested control rolls" = 1,
                         "Experimenter did not suggest control rolls" = 0
                       ),
                       selected = "both",
                       inline = TRUE
                     ),
                     radioButtons(
                       "tab2_scatterplot_draw_or_mind",
                       label = "Was random draw or state of mind reported?",
                       choices = list(
                         "Both" = "both",
                         "Reporting random draw" = 0,
                         "Reporting State of Mind" = 1
                       ),
                       selected = "both",
                       inline = TRUE
                     ),
                     radioButtons(
                       "tab2_scatterplot_repeated_or_oneshot",
                       label = "Repeated vs. One-shot Reporting",
                       choices = list(
                         "Both" = "both",
                         "Only Repeated" = 1,
                         "Only One-shot Reporting" = 0
                       ),
                       selected = "both",
                       inline = TRUE
                     ),
                     width = 6
                   )
                   
                 ),
                 style = "primary")
               )
             ),
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