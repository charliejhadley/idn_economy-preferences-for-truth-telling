

output$tab1_6states_line_hc_UI <- renderUI({
  
  show("loading-tab1_bubblechart")
  if (is.null(highchartOutput("tab1_6states_line_hc"))) {
    "empty"
  } else {
    highchartOutput("tab1_6states_line_hc")
  }
  
})

output$tab1_6states_line_hc <- renderHighchart({

  data_tab1_6states_line_hc <- data_tab1_6states
  
  
  hc <- hchart(
    data_tab1_6states_line_hc %>%
      select(percent_success,
             percent_diff,
             treatment,
             citation,
             legend_label,
             subjects),
    "line",
    hcaes(
      x = percent_success,
      y = percent_diff,
      group = treatment
      # color = colour,
      # lineColor = colour,
      # name = country
    ),
    lineWidth = 1,
    marker = list(enabled = FALSE,
                  radius = 0),
    showInLegend = FALSE,
    states = list(hover = list(lineWidthPlus = 5,
                               halo = list(
                                 size = 9
                               )))
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
      data = data_tab1_6states_line_hc %>%
        select(percent_success,
               percent_diff,
               treatment,
               citation,
               legend_label,
               subjects),
      type = "bubble",
      hcaes(
        x = percent_success,
        y = percent_diff,
        group = treatment,
        z = subjects
        # color = colour,
        # lineColor = colour,
        # name = country
      ),
      showInLegend = FALSE,
      enableMouseTracking = TRUE,
      states = list(hover = list(enabled = TRUE)),
      tooltip = list(
        enabled = FALSE
      )
      ## deactivate hover for the bubble
    ) %>%
    hc_xAxis(title = list(text = "Share of high-payoff reports"),
             lineColor = "black") %>%
    hc_yAxis(
      title = list(text = "Difference between actual an truthful PDF"),
      lineWidth = 1,
      lineColor = "black",
      gridLines = FALSE,
      gridLineWidth = 0,
      max = 40,
      plotLines = list(list(
        value = 0,
        width = 2,
        color = "black",
        dashStyle = "Dash"
      ))
    ) %>%
    hc_add_event_point(event = "click") %>%
    hc_chart(zoomType = "xy")
  
  hide("loading-tab1_6states")
  
  hc
  
  
  
  
  })


observeEvent(input$tab1_6states_line_hc_click,
             {
               toggleModal(session, "tab1_6states_bubbleModal", toggle = "toggle")
             })

output$tab1_6states_bubble_model_UI <- renderUI({
  
  data_tab1_6states_line_hc <- data_tab1_6states
  
  x_coord <- input$tab1_6states_line_hc_click$x
  y_coord <- input$tab1_6states_line_hc_click$y
  point_treatment <- input$tab1_6states_line_hc_click$series
  # point_country <- input$tab1_6states_line_hc_click$name

  
  # print(data_tab1_6states_line_hc %>%
  #         filter(percent_success == x_coord) %>%
  #         filter(treatment == point_treatment) %>%
  #         filter(percent_diff == y_coord))
  # 
  # 
  study <- data_tab1_6states_line_hc %>%
    filter(percent_success == x_coord) %>%
    filter(treatment == point_treatment) %>%
    filter(percent_diff == y_coord)

  # url <- study[["weblink"]]
  # 
  # if (is.na(url)) {
  #   weblink <- p(strong("Weblink: "), "No link provided!")
  # } else {
  #   weblink <-
  #     p(strong("Weblink: "),
  #       tags$a(href = url, url, target = "_blank"))
  # }

  print("the study")
  print(study)
  
  # url <- study[["weblink"]]
  # 
  # if (is.na(url)) {
  #   weblink <- p(strong("Weblink: "), "No link provided!")
  # } else {
  #   weblink <-
  #     p(strong("Weblink: "),
  #       tags$a(href = url, url, target = "_blank"))
  # }
  
  fluidPage(p(strong("Citation: "), study[["citation"]]),
            p(strong("Title: "), study[["paper_title"]]),
            p(strong("Country: "), study[["country"]]),
            p(strong("Number of subjects: "), study[["subjects"]])
            # weblink
            )

})

