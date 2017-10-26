# observeEvent(input$tab1_bubblechart_reset, {
#   shinyjs::reset("tab1_bubblechart_controls")
# })
# 
# output$tab1_bubblechart_selected_countries_UI <- renderUI({
# 
#   available_countries <- data_tab1_bubblechart %>%
#     select(country) %>%
#     .[[1]] %>%
#     unique()
#   
#   
#   selectInput(
#     "tab1_bubblechart_selected_countries",
#     label = "Countries to show",
#     choices = sort(available_countries),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# output$tab1_bubblechart_citation_selectize_UI <- renderUI({
#   
#   if (is.null(input$tab1_bubblechart_selected_countries)) {
#     available_citations <- data_tab1_bubblechart %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   } else {
#     available_citations <- data_tab1_bubblechart %>%
#       filter(country %in% input$tab1_bubblechart_selected_countries) %>%
#       select(citation) %>%
#       .[[1]] %>%
#       unique()
#   }
#   
#   selectInput(
#     "tab1_bubblechart_citation_selectize",
#     label = "Studies to show",
#     choices = sort(available_citations),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# output$tab1_bubblechart_selected_true_distribution_UI <- renderUI({
#   selectInput(
#     "tab1_bubblechart_selected_true_distribution",
#     label = "Selected true distributions",
#     choices = sort(unique(data_tab1_bubblechart$true_distribution_text)),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })
# 
# data_tab1_bubblechart_hc_bubble <-
#   eventReactive(
#     c(
#       input$tab1_bubblechart_population_options,
#       input$tab1_bubblechart_citation_selectize,
#       input$tab1_bubblechart_repeated_or_oneshot,
#       input$tab1_bubblechart_location,
#       input$tab1_bubblechart_controls_suggested,
#       input$tab1_bubblechart_draw_or_mind,
#       input$tab1_bubblechart_selected_true_distribution,
#       input$tab1_bubblechart_selected_countries,
#       citation
#     ),
#     {
#       
#       if(is.null(input$tab1_bubblechart_selected_countries)){
#         data_tab1_bubblechart <- data_tab1_bubblechart
#       } else {
#         data_tab1_bubblechart <- data_tab1_bubblechart %>%
#           filter(country %in% input$tab1_bubblechart_selected_countries)
#       }
# 
#       switch(
#         input$tab1_bubblechart_population_options,
#         "0" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(student == 0)
#         },
#         "1" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(student == 1)
#         },
#         "both" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart
#         }
#       )
# 
#       switch(
#         input$tab1_bubblechart_repeated_or_oneshot,
#         "0" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(repeated == 0)
#         },
#         "1" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(repeated == 1)
#         },
#         "both" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart
#         }
#       )
# 
#       switch(
#         input$tab1_bubblechart_location,
#         "0" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(remote == 0)
#         },
#         "1" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(remote == 1)
#         },
#         "both" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart
#         }
#       )
# 
#       switch(
#         input$tab1_bubblechart_controls_suggested,
#         "0" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(control_rolls == 0)
#         },
#         "1" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(control_rolls == 1)
#         },
#         "both" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart
#         }
#       )
# 
#       switch(
#         input$tab1_bubblechart_draw_or_mind,
#         "0" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(internal_lying == 0)
#         },
#         "1" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(internal_lying == 1)
#         },
#         "both" = {
#           data_tab1_bubblechart <- data_tab1_bubblechart
#         }
#       )
#       
#       if (nrow(data_tab1_bubblechart) == 0) {
#         # no data
#         return(data_frame())
#       } else {
#         if (!is.null(input$tab1_bubblechart_citation_selectize)) {
#           data_tab1_bubblechart <- data_tab1_bubblechart %>%
#             filter(citation %in% input$tab1_bubblechart_citation_selectize)
#         }
#       }
#       
#       if (!is.null(input$tab1_bubblechart_selected_true_distribution)) {
#         data_tab1_bubblechart <- data_tab1_bubblechart %>%
#           filter(true_distribution_text %in% input$tab1_bubblechart_selected_true_distribution)
#       }
#       
#       data_tab1_bubblechart
#       
#       
#     },
#     ignoreNULL = TRUE
#   )

output$tab1_bubblechart_hc_bubble_UI <- renderUI({

  show("loading-tab1_bubblechart")
  if (is.null(highchartOutput("tab1_bubblechart_hc_bubble"))) {
    "empty"
  } else {
    highchartOutput("tab1_bubblechart_hc_bubble")
  }
  
})

output$tab1_bubblechart_hc_bubble <- renderHighchart({
  
  # if (nrow(data_tab1_bubblechart_hc_bubble()) == 0) {
  #   hide("loading-tab1_bubblechart")
  #   return(highchart())
  # }
  # 
  data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart
  
  ## ==== FIX ME
  
  # if (is.null(input$tab1_bubblechart_selected_countries)) {
  #   selected_citations <- data_tab1_bubblechart_hc_bubble %>%
  #     select(citation) %>%
  #     .[[1]] %>%
  #     unique()
  # } else {
  #   selected_citations <- data_tab1_bubblechart_hc_bubble %>%
  #     filter(country %in% input$tab1_bubblechart_selected_countries) %>%
  #     select(citation) %>%
  #     .[[1]] %>%
  #     unique()
  # }
  # 
  
  
  hc <- highchart() %>%
    hc_add_series(
      data = data_tab1_bubblechart_hc_bubble %>%
        select(payoff_mm, standardized_report_per_round, subjects, color, treatment, citation, country, paper_title),
      type = "bubble",
      hcaes(
        x = payoff_mm,
        y = standardized_report_per_round,
        size = subjects,
        color = color
      ),
      showInLegend = FALSE
    )
  
  hide("loading-tab1_bubblechart")
  
  hc %>% hc_yAxis(
    min = -1,
    max = 1,
    lineWidth = 1,
    lineColor = "black",
    gridLines = FALSE,
    gridLineWidth = 0,
    title = list(text = "Standardised Report"),
    plotLines = list(list(
      value = 0,
      width = 2,
      color = "black",
      dashStyle = "Dash"
    ))
  ) %>%
    hc_xAxis(
      max = 70,
      min = 0.03,
      lineColor = "black",
      type = "logarithmic",
      title = list(text = "Maximal payoff from misreporting (in 2015 USD)"),
      tickInterval = 0.4,
      minTickInterval = 0.4
    ) %>%
    hc_tooltip(
      formatter = JS(
        "function(){
        console.log(this);
        return '<b>Study: </b>' + this.point.citation + '<br/>' +
        '<b>Treatment: </b>' + this.point.treatment + '<br/>' +
        '<b>Country: </b>' + this.point.country + '<br/>' +
        '<b>Standardised Report: </b>' + Highcharts.numberFormat(this.point.y,2) + '<br/>';}"
        
      )
    ) %>%
    hc_chart(zoomType = "xy", pinchType = "xy") %>%
    hc_add_event_point(event = "click")
  
  })


observeEvent(input$tab1_bubblechart_hc_bubble_click,
             {
               toggleModal(session, "bubbleModal", toggle = "toggle")
             })

output$bubble_model_UI <- renderUI({
  # data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart_hc_bubble()
  
  data_tab1_bubblechart_hc_bubble <- data_tab1_bubblechart
  
  x_coord <- input$tab1_bubblechart_hc_bubble_click$x
  y_coord <- input$tab1_bubblechart_hc_bubble_click$y
  
  study <- data_tab1_bubblechart_hc_bubble %>%
    filter(
      standardized_report_per_round == input$tab1_bubblechart_hc_bubble_click$y &
        payoff_mm == input$tab1_bubblechart_hc_bubble_click$x
    )
  
  url <- study[["weblink"]]
  
  if (is.na(url)) {
    weblink <- p(strong("Weblink: "), "No link provided!")
  } else {
    weblink <-
      p(strong("Weblink: "),
        tags$a(href = url, url, target = "_blank"))
  }
  
  fluidPage(p(strong("Citation: "), study[["citation"]]),
            p(strong("Title: "), study[["paper_title"]]),
            p(strong("Country: "), study[["country"]]),
            p(strong("Number of subjects: "), study[["subjects"]]),
            weblink)
})
