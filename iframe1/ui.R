library(shiny)
library(highcharter)
library(shinyjs)
library(shinyBS)

shinyUI(navbarPage(
  "Experimental Economics",
  tabPanel(
    "Average report by incentive level",
    fluidPage(
      useShinyjs(),
      uiOutput("url_allow_popout_UI"),
      includeCSS("www/animate.min.css"),
      # provides pulsating effect
      includeCSS("www/loading-content.css"),
      fluidRow(
        column(
          actionButton("tab1_bubblechart_reset", "Back to full sample"),
          bsTooltip(
            "tab1_bubblechart_reset",
            "Click here to return the visualisation to our defaults",
            "bottom",
            options = list(container = "body")
          ),
          width = 3
        ),
        div(
          id = "tab1_bubblechart_controls",
          # div provides the target for the reset button,
          fluidPage(
            column(
              radioButtons(
                "tab1_bubblechart_population_options",
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
              uiOutput("tab1_bubblechart_selected_countries_UI"),
              bsTooltip(
                "tab1_bubblechart_selected_countries_UI",
                "Filter the experiments by continents by deleting/adding their names",
                "bottom",
                options = list(container = "body")
              ),
              width = 4
            )
          ),
          bsCollapsePanel(
            HTML(
              paste0(
                '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                "&nbsp;Click here for more filters &nbsp;&nbsp;&nbsp; (and click on a circle to open a study or draw a square to zoom)"
              )
            ),
            fluidRow(
              column(
                uiOutput("tab1_bubblechart_citation_selectize_UI"),
                bsTooltip(
                  "tab1_bubblechart_citation_selectize_UI",
                  "Filter the experiments by citations by deleting/adding their names",
                  "bottom",
                  options = list(container = "body")
                ),
                uiOutput("tab1_bubblechart_selected_true_distribution_UI"),
                bsTooltip(
                  "tab1_bubblechart_selected_true_distribution_UI",
                  "Filter the experiments by true distribution.",
                  "bottom",
                  options = list(container = "body")
                ),
                radioButtons(
                  "tab1_bubblechart_location",
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
                  "tab1_bubblechart_controls_suggested",
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
                  "tab1_bubblechart_draw_or_mind",
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
                  "tab1_bubblechart_repeated_or_oneshot",
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
            style = "primary"
          )
        )
      ),
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