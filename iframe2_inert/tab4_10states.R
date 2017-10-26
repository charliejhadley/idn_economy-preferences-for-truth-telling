# observeEvent(input$tab4_10states_reset, {
#   shinyjs::reset("tab4_10states_controls")
# })
# 
# output$tab4_10states_selected_countries_UI <- renderUI({
#   
#   available_countries <- data_tab4_10states %>%
#     select(country) %>%
#     .[[1]] %>%
#     unique()
#   
#   
#   selectInput(
#     "tab4_10states_selected_countries",
#     label = "Countries to show",
#     choices = sort(available_countries),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# output$tab4_10states_citation_selectize_UI <- renderUI({
#   
#   if (is.null(input$tab4_10states_selected_countries)) {
#     available_citations <- data_tab4_10states %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   } else {
#     available_citations <- data_tab4_10states %>%
#       filter(country %in% input$tab4_10states_selected_countries) %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   }
#   
#   selectInput(
#     "tab4_10states_citation_selectize",
#     label = "Studies to show",
#     choices = sort(available_citations),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# data_tab4_10states_line_hc <-
#   eventReactive(
#     c(
#       input$tab4_10states_population_options,
#       input$tab4_10states_citation_selectize,
#       input$tab4_10states_repeated_or_oneshot,
#       input$tab4_10states_location,
#       input$tab4_10states_controls_suggested,
#       input$tab4_10states_draw_or_mind,
#       input$tab4_10states_selected_countries
#     ),
#     {
#       
#       if(is.null(input$tab4_10states_selected_countries)){
#         data_tab4_10states <- data_tab4_10states
#       } else {
#         data_tab4_10states <- data_tab4_10states %>%
#           filter(country %in% input$tab4_10states_selected_countries)
#       }
#       
#       switch(
#         input$tab4_10states_population_options,
#         "0" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(student == 0)
#         },
#         "1" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(student == 1)
#         },
#         "both" = {
#           data_tab4_10states <- data_tab4_10states
#         }
#       )
#       
#       switch(
#         input$tab4_10states_repeated_or_oneshot,
#         "0" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(repeated == 0)
#         },
#         "1" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(repeated == 1)
#         },
#         "both" = {
#           data_tab4_10states <- data_tab4_10states
#         }
#       )
#       
#       switch(
#         input$tab4_10states_location,
#         "0" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(remote == 0)
#         },
#         "1" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(remote == 1)
#         },
#         "both" = {
#           data_tab4_10states <- data_tab4_10states
#         }
#       )
#       
#       switch(
#         input$tab4_10states_controls_suggested,
#         "0" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(control_rolls == 0)
#         },
#         "1" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(control_rolls == 1)
#         },
#         "both" = {
#           data_tab4_10states <- data_tab4_10states
#         }
#       )
#       
#       switch(
#         input$tab4_10states_draw_or_mind,
#         "0" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(internal_lying == 0)
#         },
#         "1" = {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(internal_lying == 1)
#         },
#         "both" = {
#           data_tab4_10states <- data_tab4_10states
#         }
#       )
#       
#       if (nrow(data_tab4_10states) == 0) {
#         # no data
#         return(data_frame())
#       } else {
#         if (!is.null(input$tab4_10states_citation_selectize)) {
#           data_tab4_10states <- data_tab4_10states %>%
#             filter(citation %in% input$tab4_10states_citation_selectize)
#         }
#       }
#       
#       data_tab4_10states
#       
#       
#     },
#     ignoreNULL = TRUE
#   )
# 

output$tab4_10states_line_hc_UI <- renderUI({
  
  show("loading-tab1_bubblechart")
  if (is.null(highchartOutput("tab4_10states_line_hc"))) {
    "empty"
  } else {
    highchartOutput("tab4_10states_line_hc")
  }
  
})

output$tab4_10states_line_hc <- renderHighchart({
  
  # data_tab4_10states_line_hc <- data_tab4_10states_line_hc()
  
  data_tab4_10states_line_hc <- data_tab4_10states
  
  if(nrow(data_tab4_10states_line_hc) == 0){
    highchart()
  } 
  
  
  if(nrow(data_tab4_10states_line_hc) == 0){
    
    highchart()
  } else {
    hc <- hchart(
      data_tab4_10states_line_hc %>%
        select(standardized_report_per_round,
               percent,
               treatment,
               colour,
               citation,
               country),
      "line",
      hcaes(
        x = standardized_report_per_round,
        y = percent,
        group = treatment,
        color = colour,
        lineColor = colour,
        name = country
      ),
      lineWidth = 1,
      marker = list(enabled = FALSE,
                    radius = 0),
      showInLegend = FALSE,
      states = list(hover = list(lineWidthPlus = 4))
    ) %>%
      hc_plotOptions(
        line = list(
          marker = list(
            enabled = FALSE
          ),
          events = list(
            mouseOver = JS("function () {
                           console.log(this);
                           //this.series.toFront();
  }")
  )
            )
            ) %>%
      hc_tooltip(
        formatter = JS(
          "function (){
          console.log(this);
          return '<b>Citation: </b>' + this.point.citation +
          '<br/>' +
          '<b>Treatment: </b>' + this.point.treatment +
          '<br/>' +
          '<b>Percent: </b>' + Highcharts.numberFormat(this.point.y, 2);
  }"
        )
        ) 
    
    hc <- hc %>%
      hc_add_series(
        data = data_tab4_10states_line_hc %>%
          select(standardized_report_per_round,
                 percent,
                 subjects,
                 colour,
                 country,
                 treatment,
                 citation),
        type = "bubble",
        hcaes(
          x = standardized_report_per_round,
          y = percent,
          size = subjects,
          color = colour,
          name = country,
          group = treatment
        ),
        showInLegend = FALSE,
        enableMouseTracking = TRUE,
        states = list(hover = list(enabled = TRUE)),
        tooltip = list(
          enabled = FALSE
        )
        ## deactivate hover for the bubble
      ) %>%
      hc_xAxis(title = list(text = "Standardized Report (6 states)"),
               lineColor = "black") %>%
      hc_yAxis(
        min = 0,
        title = list(text = "Percent"),
        lineWidth = 1,
        lineColor = "black",
        gridLines = FALSE,
        gridLineWidth = 0,
        plotLines = list(list(
          value = 10,
          width = 2,
          color = "black",
          dashStyle = "Dash"
        ))
      )  %>%
      hc_add_event_point(event = "click")
    
    hide("loading-tab4_10states")
    
    hc
    
}
  
  
  
  })

observeEvent(input$tab4_10states_line_hc_click,
             {
               toggleModal(session, "tab4_10states_bubbleModal", toggle = "toggle")
             })

output$tab4_10states_bubble_model_UI <- renderUI({
  
  # data_tab4_10states_line_hc <- data_tab4_10states_line_hc()
  
  data_tab4_10states_line_hc <- data_tab4_10states
  
  x_coord <- input$tab4_10states_line_hc_click$x
  y_coord <- input$tab4_10states_line_hc_click$y
  point_treatment <- input$tab4_10states_line_hc_click$series
  point_country <- input$tab4_10states_line_hc_click$name
  
  study <- data_tab4_10states_line_hc %>%
    filter(standardized_report_per_round == x_coord) %>%
    filter(country == point_country) %>%
    filter(treatment == point_treatment)
  
  url <- study[["weblink"]]
  
  if (is.na(url)) {
    weblink <- p(strong("Weblink: "), "No link provided!")
  } else {
    weblink <-
      p(strong("Weblink: "),
        tags$a(href = url, url, target = "_blank"))
  }
  
  fluidPage(p(strong("Citation: "), study[["citation"]]),
            p(strong("Title: "), study[["paper_title"]]),
            p(strong("Country: "), study[["country"]]),
            p(strong("Number of subjects: "), study[["subjects"]]),
            weblink)
  
})

