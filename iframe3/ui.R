library(shinyjs)
library(leaflet)
library(shinyBS)
library(highcharter)

shinyUI(navbarPage(
  useShinyjs(),
  "Experimental Economics",
  tabPanel("World Map",
           fluidPage(leafletOutput(
             "tab1_worldmap_leaflet"
           ))),
  tabPanel("Scatter Plot",
           
           fluidPage(
             fluidRow(
               column(
                 actionButton("tab2_scatterplot_reset", "Back to full sample"),
                 width = 3
               ),
               div(
                 id = "tab2_scatterplot_controls",
                 # div provides the target for the reset button,
                 fluidPage(column(
                   radioButtons(
                     "tab2_scatterplot_population_options",
                     label = "Students vs General Population",
                     choices = list(
                       "Both" = 2,
                       "Students" = 1,
                       "General Population" = 0
                     ),
                     selected = 2,
                     inline = TRUE
                   ),
                   width = 4
                 ),
                 column(
                   uiOutput("tab2_scatterplot_selected_continents_UI"),
                   width = 5
                 )),
                 bsCollapsePanel(
                   HTML(
                     paste0(
                       '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                       "Additional Filters"
                     )
                   ),
                   fluidRow(
                     column(
                       # uiOutput("tab2_scatterplot_selected_continents_UI"),
                       uiOutput("tab2_scatterplot_selected_countries_UI"),
                       uiOutput("tab2_scatterplot_citation_selectize_UI"),
                       width = 6
                     ),
                     column(
                       sliderInput(
                         "tab2_scatterplot_incentive_range",
                         label = "Incentive Range",
                         min = 0,
                         max = 60,
                         value = c(0, 60),
                         step = 10
                       ),
                       width = 6
                     )
                   ),
                   wellPanel("Drag a rectangle to zoom"),
                   style = "primary"
                 )
               )
             ),
             highchartOutput("tab2_scatterplot_hc")
           )),
  tabPanel("About",
           fluidPage(includeMarkdown(
             knitr::knit("tab_about.Rmd")
           )))
))