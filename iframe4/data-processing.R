fs_deposit_id <- 4981589
deposit_details <- fs_details(fs_deposit_id)

deposit_details <- unlist(deposit_details$files)
deposit_details <- data.frame(split(deposit_details, names(deposit_details)),stringsAsFactors = F) %>% as_tibble()


## ==== Tab 1
## ==========
data_tab1_scatter <- deposit_details %>%
  filter(name == "data_iframe_4a.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv() %>%
  mutate(standardized_report_per_round = as.numeric(standardized_report_per_round))


qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab1_scatter_country_colours <- data_frame(
  country = unique(data_tab1_scatter$country),
  colour = col_vector[1:length(unique(data_tab1_scatter$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab1_scatter <- data_tab1_scatter %>%
  mutate(colour = mapvalues(country, from = data_tab1_scatter_country_colours$country, to = data_tab1_scatter_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )

female_data <- data_tab1_scatter %>%
  filter(female == 1) %>%
  select(-contains("male")) %>%
  rename(female_standardized_report_per_round = standardized_report_per_round)

male_data <- data_tab1_scatter %>%
  filter(female == 0) %>%
  select(-contains("male")) %>%
  rename(male_standardized_report_per_round = standardized_report_per_round)

data_tab1_scatter <- full_join(
  male_data,
  female_data
)


## ==== Tab 2
## ==========

data_tab2_linechart <- deposit_details %>%
  filter(name == "data_iframe_4b.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv()

data_tab2_linechart_country_colours <- data_frame(
  country = unique(data_tab2_linechart$country),
  colour = col_vector[1:length(unique(data_tab2_linechart$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab2_linechart <- data_tab2_linechart %>%
  mutate(colour = mapvalues(country, from = data_tab2_linechart_country_colours$country, to = data_tab2_linechart_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )

female_data <- data_tab2_linechart %>%
  filter(female == 1) %>%
  select(-contains("male")) %>%
  rename(female_standardized_report_per_round = standardized_report_per_round)

male_data <- data_tab2_linechart %>%
  filter(female == 0) %>%
  select(-contains("male")) %>%
  rename(male_standardized_report_per_round = standardized_report_per_round)

data_tab2_linechart <- full_join(
  male_data,
  female_data,
  by = c("citation", "country"),
  suffix = c(".male",".female")
)

