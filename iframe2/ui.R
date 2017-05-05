library(shiny)
library(highcharter)
library(shinyjs)
library(shinyBS)

shinyUI(
  navbarPage(
    useShinyjs(),
    "Experimental Economics",
    tabPanel(
      "Distribution of reports: 6 states",
      fluidPage(
        fluidRow(
          column(
            actionButton("tab1_6states_reset", "Back to full sample"),
            width = 3
          ),
          div(
            id = "tab1_6states_controls",
            # div provides the target for the reset button,
            fluidPage(column(
              radioButtons(
                "tab1_6states_population_options",
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
              uiOutput("tab1_6states_selected_continents_UI"),
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
                  # uiOutput("tab1_6states_selected_continents_UI"),
                  uiOutput("tab1_6states_selected_countries_UI"),
                  uiOutput("tab1_6states_citation_selectize_UI"),
                  width = 6
                ),
                column(
                  sliderInput(
                    "tab1_6states_incentive_range",
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
        highchartOutput("tab1_6states_line_hc")
      )
      
    ),
    ## ==== tab2
    tabPanel(
      "2 states",
      fluidPage(
        fluidRow(
          column(
            actionButton("tab2_2states_reset", "Back to full sample"),
            width = 3
          ),
          div(
            id = "tab2_2states_controls",
            # div provides the target for the reset button,
            fluidPage(column(
              radioButtons(
                "tab2_2states_population_options",
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
              uiOutput("tab2_2states_selected_continents_UI"),
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
                  # uiOutput("tab2_2states_selected_continents_UI"),
                  uiOutput("tab2_2states_selected_countries_UI"),
                  uiOutput("tab2_2states_citation_selectize_UI"),
                  width = 6
                ),
                column(
                  sliderInput(
                    "tab2_2states_incentive_range",
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
        highchartOutput("tab2_2states_line_hc")
      )
    ),
    ## tab 3
    tabPanel(
      "3 states",
      fluidPage(
        fluidRow(
          column(
            actionButton("tab3_3states_reset", "Back to full sample"),
            width = 3
          ),
          div(
            id = "tab3_3states_controls",
            # div provides the target for the reset button,
            fluidPage(
              column(
                radioButtons(
                  "tab3_3states_population_options",
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
              column(uiOutput("tab3_3states_selected_continents_UI"),
                     width = 5)
            ),
            bsCollapsePanel(
              HTML(
                paste0(
                  '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                  "Additional Filters"
                )
              ),
              fluidRow(
                column(
                  # uiOutput("tab3_3states_selected_continents_UI"),
                  uiOutput("tab3_3states_selected_countries_UI"),
                  uiOutput("tab3_3states_citation_selectize_UI"),
                  width = 6
                ),
                column(
                  sliderInput(
                    "tab3_3states_incentive_range",
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
        highchartOutput("tab3_3states_line_hc")
      )
      
    ),
    ## tab 4
    tabPanel(
      "10 states",
      fluidPage(
        fluidRow(
          column(
            actionButton("tab4_10states_reset", "Back to full sample"),
            width = 3
          ),
          div(
            id = "tab4_10states_controls",
            # div provides the target for the reset button,
            fluidPage(
              column(
                radioButtons(
                  "tab4_10states_population_options",
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
              column(uiOutput("tab4_10states_selected_continents_UI"),
                     width = 5)
            ),
            bsCollapsePanel(
              HTML(
                paste0(
                  '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                  "Additional Filters"
                )
              ),
              fluidRow(
                column(
                  # uiOutput("tab4_10states_selected_continents_UI"),
                  uiOutput("tab4_10states_selected_countries_UI"),
                  uiOutput("tab4_10states_citation_selectize_UI"),
                  width = 6
                ),
                column(
                  sliderInput(
                    "tab4_10states_incentive_range",
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
        highchartOutput("tab4_10states_line_hc")
      )

    ),
    # tabPanel(
    #   "Distribution of reports by incentive level",
    #   fluidPage(
    #     highchartOutput("figA2_hc", height = "500px")
    #   )
    # ),
    tabPanel("About",
             fluidPage(includeMarkdown(
               knitr::knit("tab_about.Rmd")
             )))
  )
)