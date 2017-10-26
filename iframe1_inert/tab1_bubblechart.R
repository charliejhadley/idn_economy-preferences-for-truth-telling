output$tab1_bubblechart_hc_bubble_UI <- renderUI({

  show("loading-tab1_bubblechart")
  if (is.null(highchartOutput("tab1_bubblechart_hc_bubble"))) {
    "empty"
  } else {
    highchartOutput("tab1_bubblechart_hc_bubble")
  }
  
})

output$tab1_bubblechart_hc_bubble <- renderHighchart({
  
  data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart

  hc <- highchart() %>%
    hc_add_series(
      data = data_tab1_bubblechart_hc_bubble %>%
        select(payoff_mm, standardized_report_per_round, subjects, color, treatment, citation, country, paper_title),
      type = "bubble",
      hcaes(
        x = payoff_mm,
        y = standardized_report_per_round,
        size = subjects,
        color = color
      ),
      showInLegend = FALSE
    )
  
  hide("loading-tab1_bubblechart")
  
  hc %>% hc_yAxis(
    min = -1,
    max = 1,
    lineWidth = 1,
    lineColor = "black",
    gridLines = FALSE,
    gridLineWidth = 0,
    title = list(text = "Standardised Report"),
    plotLines = list(list(
      value = 0,
      width = 2,
      color = "black",
      dashStyle = "Dash"
    ))
  ) %>%
    hc_xAxis(
      max = 70,
      min = 0.03,
      lineColor = "black",
      type = "logarithmic",
      title = list(text = "Maximal payoff from misreporting (in 2015 USD)"),
      tickInterval = 0.4,
      minTickInterval = 0.4
    ) %>%
    hc_tooltip(
      formatter = JS(
        "function(){
        console.log(this);
        return '<b>Study: </b>' + this.point.citation + '<br/>' +
        '<b>Treatment: </b>' + this.point.treatment + '<br/>' +
        '<b>Country: </b>' + this.point.country + '<br/>' +
        '<b>Standardised Report: </b>' + Highcharts.numberFormat(this.point.y,2) + '<br/>';}"
        
      )
    ) %>%
    hc_chart(zoomType = "xy", pinchType = "xy") %>%
    hc_add_event_point(event = "click")
  
  })


observeEvent(input$tab1_bubblechart_hc_bubble_click,
             {
               toggleModal(session, "bubbleModal", toggle = "toggle")
             })

output$bubble_model_UI <- renderUI({
  # data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart_hc_bubble()
  
  data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart
  
  x_coord <- input$tab1_bubblechart_hc_bubble_click$x
  y_coord <- input$tab1_bubblechart_hc_bubble_click$y
  
  study <- data_tab1_bubblechart_hc_bubble %>%
    filter(
      standardized_report_per_round == input$tab1_bubblechart_hc_bubble_click$y &
        payoff_mm == input$tab1_bubblechart_hc_bubble_click$x
    )
  
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
