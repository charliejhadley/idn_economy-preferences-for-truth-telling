observeEvent(input$tab1_scatter_reset, {
  shinyjs::reset("tab1_scatter_controls")
})

output$tab1_scatter_selected_countries_UI <- renderUI({
  
  available_countries <- data_tab1_scatter %>%
    select(country) %>%
    .[[1]] %>%
    unique()
  
  
  selectInput(
    "tab1_scatter_selected_countries",
    label = "Countries to show",
    choices = sort(available_countries),
    selected = NULL,
    multiple = TRUE,
    width = "100%"
  )
})

output$tab1_scatter_citation_selectize_UI <- renderUI({
  
  if (is.null(input$tab1_scatter_selected_countries)) {
    available_citations <- data_tab1_scatter %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  } else {
    available_citations <- data_tab1_scatter %>%
      filter(country %in% input$tab1_scatter_selected_countries) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  }
  
  selectInput(
    "tab1_scatter_citation_selectize",
    label = "Studies to show",
    choices = sort(available_citations),
    selected = NULL,
    multiple = TRUE,
    width = "100%"
  )
})

data_tab1_scatter_hc <-
  eventReactive(
    c(
      input$tab1_scatter_population_options,
      input$tab1_scatter_citation_selectize,
      input$tab1_scatter_repeated_or_oneshot,
      input$tab1_scatter_location,
      input$tab1_scatter_controls_suggested,
      input$tab1_scatter_draw_or_mind,
      input$tab1_scatter_selected_countries
    ),
    {
      
      if(is.null(input$tab1_scatter_selected_countries)){
        data_tab1_scatter <- data_tab1_scatter
      } else {
        data_tab1_scatter <- data_tab1_scatter %>%
          filter(country %in% input$tab1_scatter_selected_countries)
      }
      
      switch(
        input$tab1_scatter_population_options,
        "0" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(student == 0)
        },
        "1" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(student == 1)
        },
        "both" = {
          data_tab1_scatter <- data_tab1_scatter
        }
      )
      
      switch(
        input$tab1_scatter_repeated_or_oneshot,
        "0" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(repeated == 0)
        },
        "1" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(repeated == 1)
        },
        "both" = {
          data_tab1_scatter <- data_tab1_scatter
        }
      )
      
      switch(
        input$tab1_scatter_location,
        "0" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(remote == 0)
        },
        "1" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(remote == 1)
        },
        "both" = {
          data_tab1_scatter <- data_tab1_scatter
        }
      )
      
      switch(
        input$tab1_scatter_controls_suggested,
        "0" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(control_rolls == 0)
        },
        "1" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(control_rolls == 1)
        },
        "both" = {
          data_tab1_scatter <- data_tab1_scatter
        }
      )
      
      switch(
        input$tab1_scatter_draw_or_mind,
        "0" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(internal_lying == 0)
        },
        "1" = {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(internal_lying == 1)
        },
        "both" = {
          data_tab1_scatter <- data_tab1_scatter
        }
      )
      
      if (nrow(data_tab1_scatter) == 0) {
        # no data
        return(data_frame())
      } else {
        if (!is.null(input$tab1_scatter_citation_selectize)) {
          data_tab1_scatter <- data_tab1_scatter %>%
            filter(citation %in% input$tab1_scatter_citation_selectize)
        }
      }
      
      data_tab1_scatter
      
      
    },
    ignoreNULL = TRUE
  )



output$tab1_scatter_hc_UI <- renderUI({
  
  show("loading-tab1_scatter")
  if (is.null(highchartOutput("tab1_scatter_hc"))) {
    "empty"
  } else {
    highchartOutput("tab1_scatter_hc")
  }
  
})


output$tab1_scatter_hc <- renderHighchart({
  
  data_tab1_scatter_hc <- data_tab1_scatter_hc()
  
  if (nrow(data_tab1_scatter_hc) == 0) {
    highchart()
  } else {
  
  hc <- data_tab1_scatter_hc %>%
    select(
      male_standardized_report_per_round,
      female_standardized_report_per_round,
      subjects,
      colour,
      treatment,
      citation
    ) %>%
    hchart(
      type = "bubble",
      hcaes(x = male_standardized_report_per_round,
            y = female_standardized_report_per_round,
            size = subjects,
            color = colour,
            group = treatment),
      color = "black",
      marker = list(symbol = "diamond"),
      showInLegend = FALSE
    ) %>%
    hc_plotOptions(scatter = list(
      tooltip = list(
        headerFormat = "",
        pointFormat = "
        <b>Country:</b> {point.country}<br/>
        <b>Standardized report per round:</b> {point.y}",
        valueDecimals = 2
      )
    )) %>%
    hc_tooltip(
      formatter = JS(
        "function (){
        console.log(this);
        return '<b>Citation: </b>' + this.point.citation +
        '<br/>' +
        '<b>Treatment: </b>' + this.point.treatment +
        '<br/>' +
        '<b>Percent: </b>' + Highcharts.numberFormat(this.point.y, 2) + 
        '<br/>' +
        '<b>Average report (female): </b>' + Highcharts.numberFormat(this.point.female_standardized_report_per_round, 2) +
        '<br/>' +
        '<b>Average report (male): </b>' + Highcharts.numberFormat(this.point.male_standardized_report_per_round, 2);
}"
        )
      ) %>%
    hc_xAxis(
      min = -1,
      max = 1,
      title = list(text = "Average report (male)"),
      lineColor = "black",
      plotLines = list(list(
        value = 0,
        width = 1,
        color = "black",
        dashStyle = "Dash"
      ))) %>%
    hc_yAxis(
      min = -1,
      max = 1,
      title = list(text = "Average report (female)"),
      lineWidth = 1,
      lineColor = "black",
      gridLines = FALSE,
      gridLineWidth = 0,
      plotLines = list(list(
        value = 0,
        width = 1,
        color = "black",
        dashStyle = "Dash"
      ))
    )  %>%
    hc_add_event_point(event = "click") %>%
    hc_chart(zoomType = "xy") %>%
    hc_add_series(
      data = data_frame(x = c(-1, 1),
                        y = c(-1, 1)),
      type = "line",
      color = "black",
      marker = list(enabled = FALSE),
      lineWidth = 1,
      showInLegend = FALSE
    ) %>%
    hc_plotOptions(line = list(enableMouseTracking = FALSE, 
                               dashStyle = 'Dash'))
  
  hide("loading-tab1_scatter")
  
  hc
  
  }
  
})


observeEvent(input$tab1_scatter_hc_click,
             {
               toggleModal(session, "tab1_scatter_bubbleModal", toggle = "toggle")
             })

output$tab1_scatter_bubble_model_UI <- renderUI({
  
  data_tab1_scatter_hc <- data_tab1_scatter_hc()
  x_coord <- input$tab1_scatter_hc_click$x
  y_coord <- input$tab1_scatter_hc_click$y
  point_treatment <- input$tab1_scatter_hc_click$series
  point_country <- input$tab1_scatter_hc_click$name
  
  print(data_tab1_scatter_hc %>%
          filter(male_standardized_report_per_round == x_coord) %>%
          filter(female_standardized_report_per_round == y_coord))
  
  study <- data_tab1_scatter_hc %>%
    filter(male_standardized_report_per_round == x_coord) %>%
    filter(female_standardized_report_per_round == y_coord)
  
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



