
output$tab2_scatter_hc_UI <- renderUI({
  
  show("loading-tab2_scatter")
  if (is.null(highchartOutput("tab2_scatter_hc"))) {
    "empty"
  } else {
    highchartOutput("tab2_scatter_hc")
  }
  
})


output$tab2_scatter_hc <- renderHighchart({
  
  # data_tab2_scatter_hc <- data_tab2_scatter_hc()
  
  data_tab2_scatter_hc <- data_tab2_scatter
  
  if (nrow(data_tab2_scatter_hc) == 0) {
    highchart()
  } else {
  
  hc <- data_tab2_scatter_hc %>%
    select(
      male_standardized_report_per_round,
      female_standardized_report_per_round,
      subjects,
      colour,
      treatment,
      citation
    ) %>%
    hchart(
      type = "bubble",
      hcaes(x = male_standardized_report_per_round,
            y = female_standardized_report_per_round,
            size = subjects,
            color = colour,
            group = treatment),
      color = "black",
      marker = list(symbol = "diamond"),
      showInLegend = FALSE
    ) %>%
    hc_plotOptions(scatter = list(
      tooltip = list(
        headerFormat = "",
        pointFormat = "
        <b>Country:</b> {point.country}<br/>
        <b>Standardized report per round:</b> {point.y}",
        valueDecimals = 2
      )
    )) %>%
    hc_tooltip(
      formatter = JS(
        "function (){
        console.log(this);
        return '<b>Citation: </b>' + this.point.citation +
        '<br/>' +
        '<b>Treatment: </b>' + this.point.treatment +
        '<br/>' +
        '<b>Percent: </b>' + Highcharts.numberFormat(this.point.y, 2) + 
        '<br/>' +
        '<b>Average report (female): </b>' + Highcharts.numberFormat(this.point.female_standardized_report_per_round, 2) +
        '<br/>' +
        '<b>Average report (male): </b>' + Highcharts.numberFormat(this.point.male_standardized_report_per_round, 2);
}"
        )
      ) %>%
    hc_xAxis(
      min = -1,
      max = 1,
      title = list(text = "Average report (male)"),
      lineColor = "black",
      plotLines = list(list(
        value = 0,
        width = 1,
        color = "black",
        dashStyle = "Dash"
      ))) %>%
    hc_yAxis(
      min = -1,
      max = 1,
      title = list(text = "Average report (female)"),
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
    )  %>%
    hc_add_event_point(event = "click") %>%
    hc_chart(zoomType = "xy") %>%
    hc_add_series(
      data = data_frame(x = c(-1, 1),
                        y = c(-1, 1)),
      type = "line",
      color = "black",
      marker = list(enabled = FALSE),
      lineWidth = 1,
      showInLegend = FALSE
    ) %>%
    hc_plotOptions(line = list(enableMouseTracking = FALSE, 
                               dashStyle = 'Dash'))
  
  hide("loading-tab2_scatter")
  
  hc
  
  }
  
})


observeEvent(input$tab2_scatter_hc_click,
             {
               toggleModal(session, "tab2_scatter_bubbleModal", toggle = "toggle")
             })

output$tab2_scatter_bubble_model_UI <- renderUI({
  
  # data_tab2_scatter_hc <- data_tab2_scatter_hc()
  
  data_tab2_scatter_hc <- data_tab2_scatter
  
  x_coord <- input$tab2_scatter_hc_click$x
  y_coord <- input$tab2_scatter_hc_click$y
  point_treatment <- input$tab2_scatter_hc_click$series
  point_country <- input$tab2_scatter_hc_click$name
  
  print(data_tab2_scatter_hc %>%
          filter(male_standardized_report_per_round == x_coord) %>%
          filter(female_standardized_report_per_round == y_coord))
  
  study <- data_tab2_scatter_hc %>%
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
  
  fluidPage(p(strong("Citation: "), study[["citation"]]),
            p(strong("Title: "), study[["paper_title"]]),
            p(strong("Country: "), study[["country"]]),
            p(strong("Number of subjects: "), study[["subjects"]]),
            weblink)
  
})



