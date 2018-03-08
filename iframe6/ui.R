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
        fluidRow(
          column(
            actionButton("tab1_6states_reset", "Back to full sample"),
            bsTooltip(
              "tab1_6states_reset",
              "Click here to return the visualisation to our defaults",
              "bottom",
              options = list(container = "body")
            ),
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
              uiOutput("tab1_6states_number_of_reports_UI"),
              bsTooltip(
                "tab1_6states_number_of_reports_UI",
                "Filter the experiments by the number of rounds used.",
                "bottom",
                options = list(container = "body")
              ),
              width = 4
            )),
            bsCollapsePanel(HTML(
              paste0(
                '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>',
                "&nbsp;Click here for more filters &nbsp;&nbsp;&nbsp; (and click on a circle to open a study or draw a square to zoom)"
              )
            ),
            fluidRow(
              column(
                uiOutput("tab1_6states_citation_selectize_UI"),
                bsTooltip(
                  "tab1_6states_citation_selectize_UI",
                  "Filter the experiments by citations by deleting/adding their names",
                  "bottom",
                  options = list(container = "body")
                ),
                width = 12
              )
            ),
            style = "primary")
          )
        ),
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