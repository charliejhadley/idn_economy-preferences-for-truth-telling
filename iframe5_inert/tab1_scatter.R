# observeEvent(input$tab1_scatter_reset, {
#   shinyjs::reset("tab1_scatter_controls")
# })
# 
# output$tab1_scatter_total_reports_UI <- renderUI({
#   
#   the_total_reports <- data_tab1_scatter %>%
#     select(total_reports) %>%
#     unique() %>%
#     .[[1]] %>%
#     sort()
#   
#   selectInput(
#     "tab1_scatter_total_reports",
#     label = "Total reports",
#     choices = the_total_reports,
#     multiple = TRUE
#   )
#   
# })
# 
# output$tab1_scatter_number_of_rounds_UI <- renderUI({
#   
#   no_rounds <- sort(unique(data_tab1_scatter$total_reports))
#   
#   selectInput(
#     "tab1_scatter_number_of_rounds",
#     "Number of rounds",
#     choices = no_rounds,
#     selected = no_rounds,
#     multiple = TRUE,
#     width = "100%"
#   )
#   
# })
# 
# output$tab1_scatter_selected_countries_UI <- renderUI({
#   
#   available_countries <- data_tab1_scatter %>%
#     select(country) %>%
#     .[[1]] %>%
#     unique()
#   
#   
#   selectInput(
#     "tab1_scatter_selected_countries",
#     label = "Countries to show",
#     choices = sort(available_countries),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# output$tab1_scatter_citation_selectize_UI <- renderUI({
#   
#   if (is.null(input$tab1_scatter_selected_countries)) {
#     available_citations <- data_tab1_scatter %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   } else {
#     available_citations <- data_tab1_scatter %>%
#       filter(country %in% input$tab1_scatter_selected_countries) %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   }
#   
#   selectInput(
#     "tab1_scatter_citation_selectize",
#     label = "Studies to show",
#     choices = sort(available_citations),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# data_tab1_scatter_hc <-
#   eventReactive(
#     c(
#       input$tab1_scatter_population_options,
#       input$tab1_scatter_citation_selectize,
#       input$tab1_scatter_location,
#       input$tab1_scatter_controls_suggested,
#       input$tab1_scatter_draw_or_mind,
#       input$tab1_scatter_selected_countries,
#       input$tab1_scatter_total_reports,
#       input$tab1_scatter_number_of_rounds
#     ),
#     {
#       
#       filtered_data_tab1_scatter <- data_tab1_scatter
#     
#     if(is.null(input$tab1_scatter_selected_countries)){
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#     } else {
# 
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#         filter(country %in% input$tab1_scatter_selected_countries)
#     }
#     print("point of failure")
#     if(is.null(input$tab1_scatter_number_of_rounds)){
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#     } else {
# 
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#         filter(total_reports %in% input$tab1_scatter_number_of_rounds)
#     }
#     
#     
#     if(is.null(input$tab1_scatter_total_reports)){
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#     } else {
#       filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#         filter(total_reports %in% input$tab1_scatter_total_reports)
#     }
#     
#     
#     switch(
#       input$tab1_scatter_population_options,
#       "0" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(student == 0)
#       },
#       "1" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(student == 1)
#       },
#       "both" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#       }
#     )
#     
#     switch(
#       input$tab1_scatter_location,
#       "0" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(remote == 0)
#       },
#       "1" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(remote == 1)
#       },
#       "both" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#       }
#     )
#     
#     switch(
#       input$tab1_scatter_controls_suggested,
#       "0" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(control_rolls == 0)
#       },
#       "1" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(control_rolls == 1)
#       },
#       "both" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#       }
#     )
#     
#     switch(
#       input$tab1_scatter_draw_or_mind,
#       "0" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(internal_lying == 0)
#       },
#       "1" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(internal_lying == 1)
#       },
#       "both" = {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter
#       }
#     )
#     
#     if (nrow(filtered_data_tab1_scatter) == 0) {
#       # no data
#       print("I claim to be empty")
#       return(data_frame())
#     } else {
#       if (!is.null(input$tab1_scatter_citation_selectize)) {
#         filtered_data_tab1_scatter <- filtered_data_tab1_scatter %>%
#           filter(citation %in% input$tab1_scatter_citation_selectize)
#       }
#     }
#     
#     filtered_data_tab1_scatter
#     
#     
#     },
#     ignoreNULL = TRUE
#   )



output$tab1_scatter_hc_UI <- renderUI({
  
  show("loading-tab1_scatter")
  if (is.null(highchartOutput("tab1_scatter_hc"))) {
    "empty"
  } else {
    highchartOutput("tab1_scatter_hc")
  }
  
})


output$tab1_scatter_hc <- renderHighchart({
  
  
  # data_tab1_scatter_hc <- data_tab1_scatter_hc()
  
  data_tab1_scatter_hc <- data_tab1_scatter
  
  print(paste0("nrow of chart data:", nrow(data_tab1_scatter_hc %>%
                                             select(standardized_report_per_round,
                                                    round,
                                                    treatment,
                                                    country,
                                                    colour,
                                                    subjects) %>%
                                             mutate(new_col = paste(country, treatment)) %>%
                                             group_by(new_col) %>%
                                             mutate(how.many = n()) )))
  
  ## Check if lines, if so generate them
  the_hc_line_data <- data_tab1_scatter_hc %>%
    select(standardized_report_per_round,
           round,
           treatment,
           country,
           colour,
           subjects,
           citation) %>%
    mutate(new_col = paste(country, treatment)) %>%
    group_by(new_col) %>%
    mutate(how.many = n()) %>%
    filter(how.many > 1)
  
  
  if(nrow(the_hc_line_data) == 0){
    the_hc <- data_tab1_scatter_hc %>%
      select(round,
             standardized_report_per_round,
             subjects,
             country,
             colour,
             citation,
             treatment) %>%
      hchart(
        type = "bubble",
        hcaes(
          x = round,
          y = standardized_report_per_round,
          size = subjects,
          group = country,
          color = colour,
          name = citation
        ),
        showInLegend = FALSE,
        enableMouseTracking = TRUE,
        states = list(hover = list(enabled = TRUE)),
        tooltip = list(
          enabled = FALSE
        )
      )
  } else {
    the_hc <- the_hc_line_data %>%
      hchart(
        type = "line",
        hcaes(
          x = round,
          y = standardized_report_per_round,
          # size = subjects,
          name = citation,
          group = new_col
          # color = colour
          # color = "#000000"
        ),
        states = list(hover = list(lineWidthPlus = 5,
                                   halo = list(
                                     size = 9
                                   ))),
        marker = list(enabled = FALSE,
                      radius = 0),
        showInLegend = FALSE
      ) %>%
      hc_plotOptions(series = list(color = "#bdbfc1")) %>%
      hc_add_series(
        data = data_tab1_scatter_hc %>%
          select(round,
                 standardized_report_per_round,
                 subjects,
                 country,
                 colour,
                 citation,
                 treatment),
        type = "bubble",
        hcaes(x = round,
              y = standardized_report_per_round,
              size = subjects,
              group = country,
              color = colour),
        showInLegend = FALSE)
  }
  
  the_hc <- the_hc %>%
    hc_xAxis(type = "logarithmic",
             title = list(text = "Round"),
             lineWidth = 1,
             lineColor = "black") %>%
    hc_yAxis(
      min = -1,
      max = 1,
      title = list(text = "Standardized Report"),
      lineWidth = 1,
      lineColor = "black",
      gridLines = FALSE,
      gridLineWidth = 0,
      plotLines = list(list(
        value = 0,
        width = 1,
        color = "black",
        dashStyle = "Dash"
      ))
    ) %>%
    hc_tooltip(
      formatter = JS(
        "function (){
        console.log(this);
        return '<b>Citation: </b>' + this.point.citation +
        '<br/>' +
        '<b>Country: </b>' + this.point.country +
        '<br/>' +
        '<b>Standardized Report: </b>' + Highcharts.numberFormat(this.point.standardized_report_per_round, 2) + '<br/>' +
        '<b>Round: </b>' + this.point.round;
}"
        )
      )  %>%
    hc_add_event_point(event = "click") %>%
    hc_chart(zoomType = "xy") 
  
  hide("loading-tab1_scatter")
  
  the_hc
  
  
})


observeEvent(input$tab1_scatter_hc_click,
             {
               toggleModal(session, "tab1_scatter_bubbleModal", toggle = "toggle")
             })

output$tab1_scatter_bubble_model_UI <- renderUI({
  
  # data_tab1_scatter_hc <- data_tab1_scatter_hc()
  
  data_tab1_scatter_hc <- data_tab1_scatter
  
  x_coord <- input$tab1_scatter_hc_click$x
  y_coord <- input$tab1_scatter_hc_click$y
  point_treatment <- input$tab1_scatter_hc_click$series
  point_country <- input$tab1_scatter_hc_click$name
  
  study <- data_tab1_scatter_hc %>%
    filter(round == x_coord) %>%
    filter(standardized_report_per_round == y_coord)
  
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



