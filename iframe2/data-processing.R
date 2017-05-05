##### ======= tab1
##### ============== 
data_tab1_6states <- read_csv("data/export_figure_2_6_states.csv")
colnames(data_tab1_6states) <- make.names(trimws(tolower(colnames(data_tab1_6states))))

data_6states <- read_csv("data/export_figure_2_6_states.csv")
# 
# 
# data_tab1_6states <- data_tab1_6states %>%
#   rename(standardized_report_per_round = X.standardized_report_per_round)

add.alpha <- function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  color <- apply(sapply(col, col2rgb)/255, 2, 
        function(x) 
          rgb(x[1], x[2], x[3], alpha=alpha))
  color[[1]]
}


qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

tab1_6states_country_colours <- data_frame(
  country = unique(data_tab1_6states$country),
  colour = col_vector[1:length(unique(data_tab1_6states$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab1_6states <- data_tab1_6states %>%
  mutate(colour = mapvalues(country, from = tab1_6states_country_colours$country, to = tab1_6states_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
         )

##### ======= tab2
##### ============== 
data_tab2_2states <- read_csv("data/data_iframe_2b.csv")
colnames(data_tab2_2states) <- make.names(trimws(tolower(colnames(data_tab2_2states))))


qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab2_2states_country_colours <- data_frame(
  country = unique(data_tab2_2states$country),
  colour = col_vector[1:length(unique(data_tab2_2states$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab2_2states <- data_tab2_2states %>%
  mutate(colour = mapvalues(country, from = data_tab2_2states_country_colours$country, to = data_tab2_2states_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )

##### ======= tab3
##### ============== 
data_tab3_3states <- read_csv("data/data_iframe_2c.csv")
colnames(data_tab3_3states) <- make.names(trimws(tolower(colnames(data_tab3_3states))))


qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab3_3states_country_colours <- data_frame(
  country = unique(data_tab3_3states$country),
  colour = col_vector[1:length(unique(data_tab3_3states$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab3_3states <- data_tab3_3states %>%
  mutate(colour = mapvalues(country, from = data_tab3_3states_country_colours$country, to = data_tab3_3states_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )

##### ======= tab4
##### ============== 
data_tab4_10states <- read_csv("data/data_iframe_2d.csv")
colnames(data_tab4_10states) <- make.names(trimws(tolower(colnames(data_tab4_10states))))


qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

data_tab4_10states_country_colours <- data_frame(
  country = unique(data_tab4_10states$country),
  colour = col_vector[1:length(unique(data_tab4_10states$country))]
  # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
  # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
  # hover.colour = rgb(1, 1, 1, 0.8)
)

data_tab4_10states <- data_tab4_10states %>%
  mutate(colour = mapvalues(country, from = data_tab4_10states_country_colours$country, to = data_tab4_10states_country_colours$colour)
         # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
  )


