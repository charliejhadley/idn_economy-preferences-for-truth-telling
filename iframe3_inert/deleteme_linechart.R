female_linechart <- data_tab2_linechart_hc %>%
  group_by(female_standardized_report_per_round) %>%
  summarise(females.in.round = sum(subjects.female)) %>%
  na.omit()

female_linechart <- female_linechart %>%
  mutate(percent = 100 * females.in.round / sum(females.in.round)) %>%
  select(female_standardized_report_per_round, percent) %>%
  rename(standardized_report_per_round = female_standardized_report_per_round)

male_linechart <- data_tab2_linechart_hc %>%
  group_by(male_standardized_report_per_round) %>%
  summarise(males.in.round = sum(subjects.male)) %>%
  na.omit()

male_linechart <- male_linechart %>%
  mutate(percent = 100 * males.in.round / sum(males.in.round)) %>%
  select(male_standardized_report_per_round, percent) %>%
  rename(standardized_report_per_round = male_standardized_report_per_round)
  
female_linechart %>%
  hchart(type = "line",
         hcaes(x = standardized_report_per_round,
               y = percent),
         name = "female",
         marker = list(
           enabled = TRUE
         ),
         showInLegend = TRUE) %>%
  hc_add_series(
    data = male_linechart,
    type = "line",
    hcaes(x = standardized_report_per_round,
          y = percent),
    marker = list(
      enabled = TRUE
    ),
    name = "male",
    showInLegend = TRUE
  ) %>%
  hc_xAxis(
    title = list(
      text = "Report"
    )
  ) %>%
  hc_yAxis(
    title = list(
      text = "Percent"
    ),
    plotLines = list(list(
      value = 16.7,
      width = 2,
      color = "black",
      dashStyle = "Dash"
    ))
  ) %>%
  hc_tooltip(
    shared = TRUE,
    valueDecimals = 2,
    valueSuffix = "%",
    headerFormat = '<span style="font-size: 10px">Standardised Report per Round: {point.key}</span><br/>'
  )



