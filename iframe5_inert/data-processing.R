fs_deposit_id <- 4981589
deposit_details <- fs_details(fs_deposit_id)

deposit_details <- unlist(deposit_details$files)
deposit_details <-
  data.frame(split(deposit_details, names(deposit_details)), stringsAsFactors = F) %>% as_tibble()


## ==== Tab 1
## ==========
data_tab1_scatter <- deposit_details %>%
  filter(name == "data_iframe_5.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv() %>%
  mutate(standardized_report_per_round = as.numeric(standardized_report_per_round)) %>%
  mutate(round = as.numeric(round))


qual_col_pals <-
  brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <-
  unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab1_scatter_country_colours <-
  data_frame(country = unique(data_tab1_scatter$country),
             colour = col_vector[1:length(unique(data_tab1_scatter$country))])

data_tab1_scatter <- data_tab1_scatter %>%
  mutate(
    colour = mapvalues(country, from = data_tab1_scatter_country_colours$country, to = data_tab1_scatter_country_colours$colour)
  )
