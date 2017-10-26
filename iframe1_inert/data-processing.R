fs_deposit_id <- 4981589
deposit_details <- fs_details(fs_deposit_id)

deposit_details <- unlist(deposit_details$files)
deposit_details <-
  data.frame(split(deposit_details, names(deposit_details)), stringsAsFactors = F) %>%
  as_tibble()

data_tab1_bubblechart <-
  deposit_details %>%
  filter(name == "data_iframe_1a.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv()

colnames(data_tab1_bubblechart) <-
  make.names(tolower(colnames(data_tab1_bubblechart)))
## Kill na country
data_tab1_bubblechart <- data_tab1_bubblechart %>%
  filter(!is.na(country)) %>%
  mutate(standardized_report_per_round = as.numeric(standardized_report_per_round))




data_tab2_linechart <- deposit_details %>%
  filter(name == "data_iframe_1b.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv()

colnames(data_tab2_linechart) <-
  make.names(trimws(tolower(colnames(
    data_tab2_linechart
  ))))


qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))


citation_colors <- data_frame(
  citation = unique(data_tab1_bubblechart$citation),
  color = sample(unique(col_vector),
                 length(unique(
                   data_tab1_bubblechart$citation
                 )), replace = TRUE)
)


data_tab1_bubblechart <- data_tab1_bubblechart %>%
  mutate(
    color = plyr::mapvalues(
      data_tab1_bubblechart$citation,
      from = unique(data_tab1_bubblechart$citation),
      to = citation_colors$color
    )
  )
