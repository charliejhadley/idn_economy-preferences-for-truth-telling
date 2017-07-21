data_tab1_scatter %>%
  select(standardized_report_per_round, round, treatment, country, colour, subjects) %>%
  hchart(type = "bubble",
         hcaes(x = round,
               y = standardized_report_per_round,
               size = subjects,
               group = country,
               color = colour),
         showInLegend = FALSE) %>%
  hc_xAxis(type = "logarithmic") %>%
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
  )
