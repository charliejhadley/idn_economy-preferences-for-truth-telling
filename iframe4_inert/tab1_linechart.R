output$tab1_linechart_hc_UI <- renderUI({
  show("loading-tab1_linechart")
  if (is.null(highchartOutput("tab1_linechart_hc"))) {
    "empty"
  } else {
    highchartOutput("tab1_linechart_hc")
  }
  
})


output$tab1_linechart_hc <- renderHighchart({
  
  # data_tab1_linechart_hc <- data_tab1_linechart_hc()
  
  data_tab1_linechart_hc <- data_tab1_linechart
  
  if (nrow(data_tab1_linechart_hc) == 0) {
    highchart()
  } else {
    
    female_linechart <- data_tab1_linechart_hc %>%
      group_by(female_standardized_report_per_round) %>%
      summarise(females.in.round = sum(subjects.female)) %>%
      na.omit()
    
    female_linechart <- female_linechart %>%
      mutate(percent = 100 * females.in.round / sum(females.in.round)) %>%
      select(female_standardized_report_per_round, percent) %>%
      rename(standardized_report_per_round = female_standardized_report_per_round)
    
    male_linechart <- data_tab1_linechart_hc %>%
      group_by(male_standardized_report_per_round) %>%
      summarise(males.in.round = sum(subjects.male)) %>%
      na.omit()
    
    male_linechart <- male_linechart %>%
      mutate(percent = 100 * males.in.round / sum(males.in.round)) %>%
      select(male_standardized_report_per_round, percent) %>%
      rename(standardized_report_per_round = male_standardized_report_per_round)
    
    print("male linechart:")
    print(male_linechart)
    
    
    hc <- female_linechart %>%
      hchart(
        type = "line",
        hcaes(x = standardized_report_per_round,
              y = percent),
        name = "female",
        marker = list(enabled = TRUE),
        showInLegend = TRUE
      ) %>%
      hc_add_series(
        data = male_linechart,
        type = "line",
        hcaes(x = standardized_report_per_round,
              y = percent),
        marker = list(enabled = TRUE),
        name = "male",
        showInLegend = TRUE
      ) %>%
      hc_xAxis(title = list(text = "Report"),
               lineWidth = 1,
               lineColor = "black") %>%
      hc_yAxis(title = list(text = "Percent"),
               min = 0,
               gridLines = FALSE,
               gridLineWidth = 0,
               lineWidth = 1,
               lineColor = "black",
               plotLines = list(
                 list(
                   value = 16.7,
                   width = 2,
                   color = "black",
                   dashStyle = "Dash"
                 )
               )) %>%
      hc_tooltip(
        shared = TRUE,
        valueDecimals = 2,
        valueSuffix = "%",
        headerFormat = '<span style="font-size: 10px">Standardised Report per Round: {point.key}</span><br/>'
      )
    
    hide("loading-tab1_linechart")
    
    hc
    
  }
  
})


observeEvent(input$tab1_linechart_hc_click,
             {
               toggleModal(session, "tab1_linechart_bubbleModal", toggle = "toggle")
             })

output$tab1_linechart_bubble_model_UI <- renderUI({
  # data_tab1_linechart_hc <- data_tab1_linechart_hc()
  
  data_tab1_linechart_hc <- data_tab1_linechart
  
  x_coord <- input$tab1_linechart_hc_click$x
  y_coord <- input$tab1_linechart_hc_click$y
  point_treatment <- input$tab1_linechart_hc_click$series
  point_country <- input$tab1_linechart_hc_click$name
  
  print(
    data_tab1_linechart_hc %>%
      filter(male_standardized_report_per_round == x_coord) %>%
      filter(female_standardized_report_per_round == y_coord)
  )
  
  study <- data_tab1_linechart_hc %>%
    filter(male_standardized_report_per_round == x_coord) %>%
    filter(female_standardized_report_per_round == y_coord)
  
  url <- study[["weblink"]]
  
  if (is.na(url)) {
    weblink <- p(strong("Weblink: "), "No link provided!")
  } else {
    weblink <-
      p(strong("Weblink: "),
        tags$a(href = url, url, target = "_blank"))
  }
  
  fluidPage(
    p(strong("Citation: "), study[["citation"]]),
    p(strong("Title: "), study[["paper_title"]]),
    p(strong("Country: "), study[["country"]]),
    p(strong("Number of subjects: "), study[["subjects"]]),
    weblink
  )
  
})
