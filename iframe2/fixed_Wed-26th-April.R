data_figure2A %>%
  hchart(
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
    ) %>%
  hc_add_series(
    data = data_figure2A,
    type = "bubble",
    hcaes(
      x = standardized_report_per_round,
      y = percent,
      size = subjects,
      color = colour
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
      value = 16.7,
      width = 2,
      color = "black",
      dashStyle = "Dash"
    ))
  )