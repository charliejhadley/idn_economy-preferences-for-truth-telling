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
            fluidPage(
              column(
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
                uiOutput("tab1_6states_selected_countries_UI"),
                bsTooltip(
                  "tab1_6states_selected_countries_UI",
                  "Filter the experiments by continents by deleting/adding their names",
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
                uiOutput("tab1_6states_citation_selectize_UI"),
                bsTooltip(
                  "tab1_6states_citation_selectize_UI",
                  "Filter the experiments by citations by deleting/adding their names",
                  "bottom",
                  options = list(container = "body")
                ),
                radioButtons(
                  "tab1_6states_location",
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
                  "tab1_6states_controls_suggested",
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
                  "tab1_6states_draw_or_mind",
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
                  "tab1_6states_repeated_or_oneshot",
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
               fluidRow(
                 column(
                   actionButton("tab2_2states_reset", "Back to full sample"),
                   bsTooltip(
                     "tab2_2states_reset",
                     "Click here to return the visualisation to our defaults",
                     "bottom",
                     options = list(container = "body")
                   ),
                   width = 3
                 ),
                 div(
                   id = "tab2_2states_controls",
                   # div provides the target for the reset button,
                   fluidPage(
                     column(
                       radioButtons(
                         "tab2_2states_population_options",
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
                       uiOutput("tab2_2states_selected_countries_UI"),
                       bsTooltip(
                         "tab2_2states_selected_countries_UI",
                         "Filter the experiments by continents by deleting/adding their names",
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
                       uiOutput("tab2_2states_citation_selectize_UI"),
                       bsTooltip(
                         "tab2_2states_citation_selectize_UI",
                         "Filter the experiments by citations by deleting/adding their names",
                         "bottom",
                         options = list(container = "body")
                       ),
                       radioButtons(
                         "tab2_2states_location",
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
                         "tab2_2states_controls_suggested",
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
                         "tab2_2states_draw_or_mind",
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
                         "tab2_2states_repeated_or_oneshot",
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
               fluidRow(
                 column(
                   actionButton("tab3_3states_reset", "Back to full sample"),
                   bsTooltip(
                     "tab3_3states_reset",
                     "Click here to return the visualisation to our defaults",
                     "bottom",
                     options = list(container = "body")
                   ),
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
                       uiOutput("tab3_3states_selected_countries_UI"),
                       bsTooltip(
                         "tab3_3states_selected_countries_UI",
                         "Filter the experiments by continents by deleting/adding their names",
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
                       uiOutput("tab3_3states_citation_selectize_UI"),
                       bsTooltip(
                         "tab3_3states_citation_selectize_UI",
                         "Filter the experiments by citations by deleting/adding their names",
                         "bottom",
                         options = list(container = "body")
                       ),
                       radioButtons(
                         "tab3_3states_location",
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
                         "tab3_3states_controls_suggested",
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
                         "tab3_3states_draw_or_mind",
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
                         "tab3_3states_repeated_or_oneshot",
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
               fluidRow(
                 column(
                   actionButton("tab4_10states_reset", "Back to full sample"),
                   bsTooltip(
                     "tab4_10states_reset",
                     "Click here to return the visualisation to our defaults",
                     "bottom",
                     options = list(container = "body")
                   ),
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
                       uiOutput("tab4_10states_selected_countries_UI"),
                       bsTooltip(
                         "tab4_10states_selected_countries_UI",
                         "Filter the experiments by continents by deleting/adding their names",
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
                       uiOutput("tab4_10states_citation_selectize_UI"),
                       bsTooltip(
                         "tab4_10states_citation_selectize_UI",
                         "Filter the experiments by citations by deleting/adding their names",
                         "bottom",
                         options = list(container = "body")
                       ),
                       radioButtons(
                         "tab4_10states_location",
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
                         "tab4_10states_controls_suggested",
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
                         "tab4_10states_draw_or_mind",
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
                         "tab4_10states_repeated_or_oneshot",
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
    # tabPanel(
    #   "Distribution of reports by incentive level",
    #   fluidPage(
    #     highchartOutput("figA2_hc", height = "500px")
    #   )
    # ),
    tabPanel("About",
             fluidPage(includeMarkdown(
               knitr::knit("tab_about.Rmd")
             ))),
    collapsible = TRUE
  )
)