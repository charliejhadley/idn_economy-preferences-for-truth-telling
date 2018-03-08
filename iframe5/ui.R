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
        fluidRow(
          column(
            actionButton("tab1_scatter_reset", "Back to full sample"),
            bsTooltip(
              "tab1_scatter_reset",
              "Click here to return the visualisation to our defaults",
              "bottom",
              options = list(container = "body")
            ),
            width = 3
          ),
          div(
            id = "tab1_scatter_controls",
            # div provides the target for the reset button,
            fluidPage(
              column(
                radioButtons(
                  "tab1_scatter_population_options",
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
              ),
              column(
                uiOutput("tab1_scatter_number_of_rounds_UI"),
                bsTooltip(
                  "tab1_scatter_number_of_rounds_UI",
                  "Filter the experiments by the number of rounds used.",
                  "bottom",
                  options = list(container = "body")
                ),
                width = 4
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
                uiOutput("tab1_scatter_selected_countries_UI"),
                bsTooltip(
                  "tab1_scatter_selected_countries_UI",
                  "Filter the experiments by countries by deleting/adding their names",
                  "bottom",
                  options = list(container = "body")
                ),
                uiOutput("tab1_scatter_citation_selectize_UI"),
                bsTooltip(
                  "tab1_scatter_citation_selectize_UI",
                  "Filter the experiments by citations by deleting/adding their names",
                  "bottom",
                  options = list(container = "body")
                ),
                width = 6
              ),
              column(
                radioButtons(
                  "tab1_scatter_location",
                  label = "Experiment location?",
                  choices = list(
                    "Both" = "both",
                    "Only lab" = 0,
                    "Only Online/Telephone" = 1
                  ),
                  selected = "both",
                  inline = TRUE
                ),
                radioButtons(
                  "tab1_scatter_controls_suggested",
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
                  "tab1_scatter_draw_or_mind",
                  label = "Was random draw or state of mind reported?",
                  choices = list(
                    "Both" = "both",
                    "Reporting random draw" = 0,
                    "Reporting State of Mind" = 1
                  ),
                  selected = "both",
                  inline = TRUE
                ),
                width = 6
              )

            ),
            style = "primary")
          ),
        div(
          id = "loading-tab1_scatter",
          class = "loading-content",
          h2(class = "animated infinite pulse", "Loading data...")
        ),
        # highchartOutput("tab1_scatter_hc_bubble")
        highchartOutput("tab1_scatter_hc"),
        # uiOutput("tab1_scatter_hc_UI"),
        bsModal(
          "tab1_scatter_bubbleModal",
          "Study Info",
          trigger = "tab1_scatter_hc_click",
          size = "large",
          uiOutput("tab1_scatter_bubble_model_UI")
        )
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