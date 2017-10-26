processed_data <- data_tab1_scatter %>%
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
  filter(how.many > 1)

single_line_series <- function(hc, group){
  
  single_line <- processed_data %>%
    filter(new_col == group)
  
  single_color <<- single_line %>%
    ungroup() %>%
    select(colour) %>%
    unique() %>%
    .[[1]]
  print(single_color)
  hc %>%
    hc_add_series(
      data = single_line,
      type = "line",
           hcaes(
             x = round,
             y = standardized_report_per_round,
             # size = subjects,
             group = new_col,
             # color = colour
             color = single_color
           ))
}

highchart() %>%
  single_line_series("Germany WS ALIGNED")

my_hc <- highchart()

invisible(lapply(unique(processed_data$new_col),
       function(x){
         my_hc <<- my_hc %>%
           single_line_series(x)
       }))
my_hc


the_groups <- unique(processed_data$new_col)
the_groups

processed_data %>%
  filter(new_col == "Switzerland R CONTROL BELIEF") %>%
  ungroup() %>%
  select(colour) %>%
  unique() %>%
  .[[1]]

processed_data %>%
  filter(new_col == "Switzerland R CONTROL BELIEF") %>%
  hchart(type = "line",
         hcaes(
           x = round,
           y = standardized_report_per_round,
           # size = subjects,
           group = new_col
           # color = colour
           # color = "#000000"
         )) %>%
  hc_plotOptions(series = list(color = "#E6AB02"))

