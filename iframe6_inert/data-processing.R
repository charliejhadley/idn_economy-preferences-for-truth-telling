fs_deposit_id <- 4981589
deposit_details <- fs_details(fs_deposit_id)

deposit_details <- unlist(deposit_details$files)
deposit_details <- data.frame(split(deposit_details, names(deposit_details)),stringsAsFactors = F) %>% as_tibble()


##### ======= tab1
##### ============== 
data_tab1_6states <- deposit_details %>%
  filter(name == "data_iframe_6.csv") %>%
  select(download_url) %>%
  .[[1]] %>%
  read_csv()

colnames(data_tab1_6states) <- make.names(trimws(tolower(colnames(data_tab1_6states))))

# 
# 
# data_tab1_6states <- data_tab1_6states %>%
#   rename(standardized_report_per_round = X.standardized_report_per_round)

# add.alpha <- function(col, alpha=1){
#   if(missing(col))
#     stop("Please provide a vector of colours.")
#   color <- apply(sapply(col, col2rgb)/255, 2, 
#         function(x) 
#           rgb(x[1], x[2], x[3], alpha=alpha))
#   color[[1]]
# }
# 
# 
# qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual', ]
# col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
# 
# tab1_6states_country_colours <- data_frame(
#   country = unique(data_tab1_6states$country),
#   colour = col_vector[1:length(unique(data_tab1_6states$country))]
#   # colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 0.1)))
#   # hover.colour = unlist(lapply(col_vector[1:length(unique(data_tab1_6states$country))], function(x) add.alpha(x, 1)))
#   # hover.colour = rgb(1, 1, 1, 0.8)
# )

# data_tab1_6states <- data_tab1_6states %>%
#   mutate(colour = mapvalues(country, from = tab1_6states_country_colours$country, to = tab1_6states_country_colours$colour)
#          # hover.colour = mapvalues(country, from = country_colours$country, to = country_colours$hover.colour)
#          )

##### ======= tab2
##### ============== 