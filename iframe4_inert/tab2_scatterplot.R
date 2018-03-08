
output$tab2_scatterplot_hc_UI <- renderUI({
  show("loading-tab2_scatterplot_hc")
  if (is.null(highchartOutput("tab2_scatterplot_hc"))) {
    "empty"
  } else {
    highchartOutput("tab2_scatterplot_hc")
  }
  
})

output$tab2_scatterplot_hc <- renderHighchart({
  # data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc()
  
  data_tab2_scatterplot_hc <- data_tab2_scatterplot
  
  if (nrow(data_tab2_scatterplot_hc) == 0) {
    highchart()
  } else {
    
  }
  
  if (nrow(data_tab2_scatterplot_hc) == 0) {
    hide("loading-tab2_scatterplot")
    hchart(
      type = "scatter",
      data = data_tab2_scatterplot %>%
        arrange(average_st_report_per_round),
      hcaes(x = country,
            y = average_st_report_per_round),
      color = "black",
      marker = list(symbol = "diamond")
    ) %>%
      hc_plotOptions(scatter = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Country:</b> {point.country}<br/>
          <b>Average standardized report per round:</b> {point.y}"
        )
        )) %>%
      hc_chart(zoomType = "xy") %>%
      hc_yAxis(
        title = list(text = "Standardized Report per Round"),
        lineWidth = 1,
        lineColor = "black"
      )
  } else {
    hc <- data_tab2_scatterplot %>%
      arrange(average_st_report_per_round) %>%
      select(country,
             average_st_report_per_round) %>%
      hchart(
        type = "scatter",
        hcaes(x = country,
              y = average_st_report_per_round),
        color = "black",
        marker = list(symbol = "diamond")
      ) %>%
      hc_plotOptions(scatter = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Country:</b> {point.country}<br/>
          <b>Average standardized report per round:</b> {point.y}",
          valueDecimals = 2
        )
        )) %>%
      hc_add_series(
        type = "bubble",
        data = data_tab2_scatterplot_hc %>%
          arrange(average_st_report_per_round) %>%
          select(
            country,
            standardized_report_per_round,
            subjects,
            colour,
            treatment
          ),
        hcaes(
          x = country,
          y = standardized_report_per_round,
          size = subjects,
          color = colour,
          group = treatment
        )
      ) %>%
      hc_plotOptions(bubble = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Citation:</b> {point.citation}<br/>
          <b>Treatment:</b> {point.treatment}<br/>
          <b>Country:</b> {point.country}<br/>
          <b>Standardized report per round:</b> {point.y}",
          valueDecimals = 2
        )
        )) %>%
      hc_chart(zoomType = "xy") %>%
      hc_xAxis(title = list(text = "Country"),
               labels = list(rotation = 90, step = 1),
               lineColor = "black"
      ) %>%
      hc_yAxis(
        gridLines = FALSE,
        gridLineWidth = 0,
        plotLines = list(list(
          value = 0,
          width = 1,
          color = "black",
          dashStyle = "Dash"
        )),
        title = list(text = "Standardized Report"),
        lineWidth = 1,
        lineColor = "black"
      ) %>%
      hc_add_event_point(event = "click")
    
    hide("loading-tab2_scatterplot")
    
    hc
    
  }
  
  
})



observeEvent(input$tab2_scatterplot_hc_click,
             {
               if (input$tab2_scatterplot_hc_click$series %in% data_tab2_scatterplot$treatment) {
                 toggleModal(session, "tab2_scatterplot_bubbleModal", toggle = "toggle")
               }
               
               
             })

output$tab2_scatterplot_bubble_model_UI <- renderUI({
  # data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc()
  
  data_tab2_scatterplot_hc <- data_tab2_scatterplot
  
  y_coord <- input$tab2_scatterplot_hc_click$y
  point_treatment <- input$tab2_scatterplot_hc_click$series
  point_country <- input$tab2_scatterplot_hc_click$name
  
  study <- data_tab2_scatterplot_hc %>%
    filter(standardized_report_per_round == y_coord) %>%
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
  
  fluidPage(
    p(strong("Citation: "), study[["citation"]]),
    p(strong("Title: "), study[["paper_title"]]),
    p(strong("Country: "), study[["country"]]),
    p(strong("Number of subjects: "), study[["subjects"]]),
    weblink
  )
  
  
})
