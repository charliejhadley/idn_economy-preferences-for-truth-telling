data_tab1_scatter %>%
  select(standardized_report_per_round,
         round,
         treatment,
         country,
         colour,
         subjects) %>%
  mutate(new_col = paste(country, treatment)) %>%
  group_by(new_col) %>%
  mutate(how.many = n()) %>%
  # filter(country == "Netherlands") %>%
  filter(how.many > 1) %>%
  select(round, standardized_report_per_round, new_col) %>%
  hchart(
    type = "line",
    hcaes(
      x = round,
      y = standardized_report_per_round,
      # size = subjects,
      group = new_col
      # color = colour
      # color = "#000000"
    ),
    states = list(hover = list(lineWidthPlus = 5,
                               halo = list(
                                 size = 9
                               ))),
    tooltip = list(
      enabled = FALSE
    ),
    showInLegend = FALSE
  ) %>%
  hc_plotOptions(series = list(color = "#bdbfc1")) %>%
  hc_add_series(
    data = data_tab1_scatter %>%
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