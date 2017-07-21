observeEvent(input$tab2_linechart_reset, {
  shinyjs::reset("tab2_linechart_controls")
})

output$tab2_linechart_selected_countries_UI <- renderUI({
  available_countries <- data_tab2_linechart %>%
    select(country) %>%
    .[[1]] %>%
    unique()
  
  
  selectInput(
    "tab2_linechart_selected_countries",
    label = "Countries to show",
    choices = sort(available_countries),
    selected = NULL,
    multiple = TRUE,
    width = "100%"
  )
})

output$tab2_linechart_citation_selectize_UI <- renderUI({
  if (is.null(input$tab2_linechart_selected_countries)) {
    available_citations <- data_tab2_linechart %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  } else {
    available_citations <- data_tab2_linechart %>%
      filter(country %in% input$tab2_linechart_selected_countries) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  }
  
  selectInput(
    "tab2_linechart_citation_selectize",
    label = "Studies to show",
    choices = sort(available_citations),
    selected = NULL,
    multiple = TRUE,
    width = "100%"
  )
})

data_tab2_linechart_hc <-
  eventReactive(
    c(
      input$tab2_linechart_population_options,
      input$tab2_linechart_citation_selectize,
      input$tab2_linechart_repeated_or_oneshot,
      input$tab2_linechart_location,
      input$tab2_linechart_controls_suggested,
      input$tab2_linechart_draw_or_mind,
      input$tab2_linechart_selected_countries
    ),
    {
      if (is.null(input$tab2_linechart_selected_countries)) {
        data_tab2_linechart <- data_tab2_linechart
      } else {
        data_tab2_linechart <- data_tab2_linechart %>%
          filter(country %in% input$tab2_linechart_selected_countries)
      }
      
      switch(
        input$tab2_linechart_population_options,
        "0" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(student.male == 0) %>%
            filter(student.female == 0)
        },
        "1" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(student.male == 1) %>%
            filter(student.female == 1)
        },
        "both" = {
          data_tab2_linechart <- data_tab2_linechart
        }
      )
      
      switch(
        input$tab2_linechart_repeated_or_oneshot,
        "0" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(repeated.female == 0) %>%
            filter(repeated.male == 0)
        },
        "1" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(repeated.female == 1) %>%
            filter(repeated.male == 1)
        },
        "both" = {
          data_tab2_linechart <- data_tab2_linechart
        }
      )
      
      switch(
        input$tab2_linechart_location,
        "0" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(remote.female == 0) %>%
            filter(remote.male == 0)
        },
        "1" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(remote.female == 1) %>%
            filter(remote.male == 1)
        },
        "both" = {
          data_tab2_linechart <- data_tab2_linechart
        }
      )
      
      switch(
        input$tab2_linechart_controls_suggested,
        "0" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(control_rolls.male == 0) %>%
            filter(control_rolls.female == 0)
        },
        "1" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(control_rolls.female == 1) %>%
            filter(control_rolls.male == 1)
        },
        "both" = {
          data_tab2_linechart <- data_tab2_linechart
        }
      )
      
      switch(
        input$tab2_linechart_draw_or_mind,
        "0" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(internal_lying.male == 0) %>%
            filter(internal_lying.female == 0)
        },
        "1" = {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(internal_lying.male == 1) %>%
            filter(internal_lying.female == 1)
        },
        "both" = {
          data_tab2_linechart <- data_tab2_linechart
        }
      )
      
      if (nrow(data_tab2_linechart) == 0) {
        # no data
        return(data_frame())
      } else {
        if (!is.null(input$tab2_linechart_citation_selectize)) {
          data_tab2_linechart <- data_tab2_linechart %>%
            filter(citation %in% input$tab2_linechart_citation_selectize)
        }
      }
      
      data_tab2_linechart
      
      
    },
    ignoreNULL = TRUE
  )



output$tab2_linechart_hc_UI <- renderUI({
  show("loading-tab2_linechart")
  if (is.null(highchartOutput("tab2_linechart_hc"))) {
    "empty"
  } else {
    highchartOutput("tab2_linechart_hc")
  }
  
})


output$tab2_linechart_hc <- renderHighchart({
  
  data_tab2_linechart_hc <- data_tab2_linechart_hc()
  
  if (nrow(data_tab2_linechart_hc) == 0) {
    highchart()
  } else {
    
    female_linechart <- data_tab2_linechart_hc %>%
      group_by(female_standardized_report_per_round) %>%
      summarise(females.in.round = sum(subjects.female)) %>%
      na.omit()
    
    female_linechart <- female_linechart %>%
      mutate(percent = 100 * females.in.round / sum(females.in.round)) %>%
      select(female_standardized_report_per_round, percent) %>%
      rename(standardized_report_per_round = female_standardized_report_per_round)
    
    male_linechart <- data_tab2_linechart_hc %>%
      group_by(male_standardized_report_per_round) %>%
      summarise(males.in.round = sum(subjects.male)) %>%
      na.omit()
    
    male_linechart <- male_linechart %>%
      mutate(percent = 100 * males.in.round / sum(males.in.round)) %>%
      select(male_standardized_report_per_round, percent) %>%
      rename(standardized_report_per_round = male_standardized_report_per_round)
    
    print("male linechart:")
    print(male_linechart)
    
    
    hc <- female_linechart %>%
      hchart(
        type = "line",
        hcaes(x = standardized_report_per_round,
              y = percent),
        name = "female",
        marker = list(enabled = TRUE),
        showInLegend = TRUE
      ) %>%
      hc_add_series(
        data = male_linechart,
        type = "line",
        hcaes(x = standardized_report_per_round,
              y = percent),
        marker = list(enabled = TRUE),
        name = "male",
        showInLegend = TRUE
      ) %>%
      hc_xAxis(title = list(text = "Report"),
               lineWidth = 1,
               lineColor = "black") %>%
      hc_yAxis(title = list(text = "Percent"),
               min = 0,
               gridLines = FALSE,
               gridLineWidth = 0,
               lineWidth = 1,
               lineColor = "black",
               plotLines = list(
                 list(
                   value = 16.7,
                   width = 2,
                   color = "black",
                   dashStyle = "Dash"
                 )
               )) %>%
      hc_tooltip(
        shared = TRUE,
        valueDecimals = 2,
        valueSuffix = "%",
        headerFormat = '<span style="font-size: 10px">Standardised Report per Round: {point.key}</span><br/>'
      )
    
    hide("loading-tab2_linechart")
    
    hc
    
  }
  
})


observeEvent(input$tab2_linechart_hc_click,
             {
               toggleModal(session, "tab2_linechart_bubbleModal", toggle = "toggle")
             })

output$tab2_linechart_bubble_model_UI <- renderUI({
  data_tab2_linechart_hc <- data_tab2_linechart_hc()
  x_coord <- input$tab2_linechart_hc_click$x
  y_coord <- input$tab2_linechart_hc_click$y
  point_treatment <- input$tab2_linechart_hc_click$series
  point_country <- input$tab2_linechart_hc_click$name
  
  print(
    data_tab2_linechart_hc %>%
      filter(male_standardized_report_per_round == x_coord) %>%
      filter(female_standardized_report_per_round == y_coord)
  )
  
  study <- data_tab2_linechart_hc %>%
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
  
  fluidPage(
    p(strong("Citation: "), study[["citation"]]),
    p(strong("Title: "), study[["paper_title"]]),
    p(strong("Country: "), study[["country"]]),
    p(strong("Number of subjects: "), study[["subjects"]]),
    weblink
  )
  
})
