

## ==== Tab 1
## ==========
data_tab1_world_map <- read_csv("data/data_iframe_3a.csv")

## Get participating countries
participating_countries <- data_tab1_world_map %>%
  filter(!is.na(standardized_report_per_round)) %>%
  select(country) %>%
  unique() %>%
  .[[1]]
data_tab1_world_map <- data_tab1_world_map %>%
  filter(country %in% participating_countries)
## oidnChaRts provides a useful global shapefile, filter it by participating countries
shapefiles_participating_countries <-
  data_world_shapefiles[data_world_shapefiles$name %in% participating_countries, ]

## Add preferences for truth data to the shapefiles

shapefiles_participating_countries@data <-
  as_data_frame(shapefiles_participating_countries@data) %>%
  rename(country = name) %>%
  full_join(data_tab1_world_map, by = "country") %>%
  as.data.frame(stringAsFactors = FALSE)


shapefiles_participating_countries$scaled_std_report_per_round <-
  rescale(shapefiles_participating_countries$standardized_report_per_round,
          to = c(1, 100))

## ==== Tab 2
## ==========
data_tab2_scatterplot <- read_csv("data/data_iframe_3b.csv")

## There's badly formatted entry here which I filter out:
data_tab2_scatterplot <- data_tab2_scatterplot %>%
  filter(standardized_report_per_round < 20)

## Calculate mean standardized report per round
data_tab2_scatterplot <- data_tab2_scatterplot %>%
  group_by(country) %>%
  mutate(average_st_report_per_round = mean(standardized_report_per_round)) %>%
  ungroup() %>%
  mutate(subjects = as.integer(subjects))

qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab2_scatterplot_country_colours <- data_frame(
  country = unique(data_tab2_scatterplot$country),
  colour = col_vector[1:length(unique(data_tab2_scatterplot$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab2_scatterplot <- data_tab2_scatterplot %>%
  mutate(colour = mapvalues(country, from = data_tab2_scatterplot_country_colours$country, to = data_tab2_scatterplot_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )

