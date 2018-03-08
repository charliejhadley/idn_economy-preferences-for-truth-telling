observeEvent(input$tab1_6states_reset, {
  shinyjs::reset("tab1_6states_controls")
})

# output$tab1_6states_selected_countries_UI <- renderUI({
#   
#   available_countries <- data_tab1_6states %>%
#     select(country) %>%
#     .[[1]] %>%
#     unique()
#   
#   
#   selectInput(
#     "tab1_6states_selected_countries",
#     label = "Countries to show",
#     choices = sort(available_countries),
#     selected = NULL,
#     multiple = TRUE,
#     width = "100%"
#   )
# })

output$tab1_6states_number_of_reports_UI <- renderUI({
  selectInput("tab1_6states_number_of_reports",
              "Total Number of Reports",
              choices = sort(unique(data_tab1_6states$total_reports)),
              selected = sort(unique(data_tab1_6states$total_reports)),
              multiple = TRUE,
              width = "100%")
})

output$tab1_6states_citation_selectize_UI <- renderUI({
  
  # if (is.null(input$tab1_6states_selected_countries)) {
  #   available_citations <- data_tab1_6states %>%
  #     select(citation) %>%
  #     .[[1]] %>%
  #     unique()
  # } else {
  #   available_citations <- data_tab1_6states %>%
  #     filter(country %in% input$tab1_6states_selected_countries) %>%
  #     select(citation) %>%
  #     .[[1]] %>%
  #     unique()
  # }

  selectInput(
    "tab1_6states_citation_selectize",
    label = "Studies to show",
    choices = sort(unique(data_tab1_6states$citation)),
    selected = sort(unique(data_tab1_6states$citation)),
    multiple = TRUE,
    width = "100%"
  )
})

data_tab1_6states_line_hc <-
  eventReactive(
    c(
      input$tab1_6states_citation_selectize,
      input$tab1_6states_number_of_reports
    ),
    {
      
      # if(is.null(input$tab1_6states_selected_countries)){
      #   data_tab1_6states <- data_tab1_6states
      # } else {
      #   data_tab1_6states <- data_tab1_6states %>%
      #     filter(country %in% input$tab1_6states_selected_countries)
      # }

      data_tab1_6states <- data_tab1_6states %>%
        filter(total_reports %in% input$tab1_6states_number_of_reports)
      
      
      if(is.null(input$tab1_6states_citation_selectize)){
        data_tab1_6states <- data_tab1_6states
      } else {
        data_tab1_6states <- data_tab1_6states %>%
          filter(citation %in% input$tab1_6states_citation_selectize)
      }
      

      if (nrow(data_tab1_6states) == 0) {
        # no data
        return(data_frame())
      } else {
        if (!is.null(input$tab1_6states_citation_selectize)) {
          data_tab1_6states <- data_tab1_6states %>%
            filter(citation %in% input$tab1_6states_citation_selectize)
        }
      }
      
      data_tab1_6states
      
      
    },
    ignoreNULL = TRUE
  )


output$tab1_6states_line_hc_UI <- renderUI({
  
  show("loading-tab1_bubblechart")
  if (is.null(highchartOutput("tab1_6states_line_hc"))) {
    "empty"
  } else {
    highchartOutput("tab1_6states_line_hc")
  }
  
})

output$tab1_6states_line_hc <- renderHighchart({

  data_tab1_6states_line_hc <- data_tab1_6states_line_hc()
  
  
  
  if(nrow(data_tab1_6states_line_hc) == 0){
    highchart()
  } 
  
  
  if(nrow(data_tab1_6states_line_hc) == 0){

    highchart()
  } else {
    hc <- hchart(
      data_tab1_6states_line_hc %>%
        select(percent_success,
               percent_diff,
               treatment,
               citation,
               legend_label,
               subjects),
      "line",
      hcaes(
        x = percent_success,
        y = percent_diff,
        group = treatment
        # color = colour,
        # lineColor = colour,
        # name = country
      ),
      lineWidth = 1,
      marker = list(enabled = FALSE,
                    radius = 0),
      showInLegend = FALSE,
      states = list(hover = list(lineWidthPlus = 5,
                                 halo = list(
                                   size = 9
                                 )))
    ) %>%
      hc_plotOptions(
        line = list(
          marker = list(
            enabled = FALSE
          ),
          events = list(
            mouseOver = JS("function () {
                           console.log(this);
                           //this.series.toFront();
  }")
  )
            )
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
    
    hc <- hc %>%
      hc_add_series(
        data = data_tab1_6states_line_hc %>%
          select(percent_success,
                 percent_diff,
                 treatment,
                 citation,
                 legend_label,
                 subjects),
        type = "bubble",
        hcaes(
          x = percent_success,
          y = percent_diff,
          group = treatment,
          z = subjects
          # color = colour,
          # lineColor = colour,
          # name = country
        ),
        showInLegend = FALSE,
        enableMouseTracking = TRUE,
        states = list(hover = list(enabled = TRUE)),
        tooltip = list(
          enabled = FALSE
        )
        ## deactivate hover for the bubble
      ) %>%
      hc_xAxis(title = list(text = "Share of high-payoff reports"),
               lineColor = "black") %>%
      hc_yAxis(
        title = list(text = "Difference between actual an truthful PDF"),
        lineWidth = 1,
        lineColor = "black",
        gridLines = FALSE,
        gridLineWidth = 0,
        max = 40,
        plotLines = list(list(
          value = 0,
          width = 2,
          color = "black",
          dashStyle = "Dash"
        ))
      ) %>%
      hc_add_event_point(event = "click") %>%
      hc_chart(zoomType = "xy")
    
    hide("loading-tab1_6states")
    
    hc
    
  }
  
  
  
  })


observeEvent(input$tab1_6states_line_hc_click,
             {
               toggleModal(session, "tab1_6states_bubbleModal", toggle = "toggle")
             })

output$tab1_6states_bubble_model_UI <- renderUI({
  
  data_tab1_6states_line_hc <- data_tab1_6states_line_hc()
  x_coord <- input$tab1_6states_line_hc_click$x
  y_coord <- input$tab1_6states_line_hc_click$y
  point_treatment <- input$tab1_6states_line_hc_click$series
  # point_country <- input$tab1_6states_line_hc_click$name

  
  # print(data_tab1_6states_line_hc %>%
  #         filter(percent_success == x_coord) %>%
  #         filter(treatment == point_treatment) %>%
  #         filter(percent_diff == y_coord))
  # 
  # 
  study <- data_tab1_6states_line_hc %>%
    filter(percent_success == x_coord) %>%
    filter(treatment == point_treatment) %>%
    filter(percent_diff == y_coord)

  # url <- study[["weblink"]]
  # 
  # if (is.na(url)) {
  #   weblink <- p(strong("Weblink: "), "No link provided!")
  # } else {
  #   weblink <-
  #     p(strong("Weblink: "),
  #       tags$a(href = url, url, target = "_blank"))
  # }

  print("the study")
  print(study)
  
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
            # weblink
            weblink
            )

})

