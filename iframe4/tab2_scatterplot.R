observeEvent(input$tab2_scatterplot_reset, {
  shinyjs::reset("tab2_scatterplot_controls")
})

output$tab2_scatterplot_citation_selectize_UI <- renderUI({
  available_citations <- data_tab2_scatterplot %>%
    select(citation) %>%
    .[[1]] %>%
    unique()
  
  selectInput(
    "tab2_scatterplot_citation_selectize",
    label = "Studies to show",
    choices = sort(available_citations),
    selected = NULL,
    multiple = TRUE,
    width = "100%"
  )
})

data_tab2_scatterplot_hc <-
  eventReactive(
    c(
      input$tab2_scatterplot_population_options,
      input$tab2_scatterplot_citation_selectize,
      input$tab2_scatterplot_repeated_or_oneshot,
      input$tab2_scatterplot_location,
      input$tab2_scatterplot_controls_suggested,
      input$tab2_scatterplot_draw_or_mind
    ),
    {
      data_tab2_scatterplot <- data_tab2_scatterplot
      
      switch(
        input$tab2_scatterplot_population_options,
        "0" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(student == 0)
        },
        "1" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(student == 1)
        },
        "both" = {
          data_tab2_scatterplot <- data_tab2_scatterplot
        }
      )
      
      switch(
        input$tab2_scatterplot_repeated_or_oneshot,
        "0" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(repeated == 0)
        },
        "1" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(repeated == 1)
        },
        "both" = {
          data_tab2_scatterplot <- data_tab2_scatterplot
        }
      )
      
      switch(
        input$tab2_scatterplot_location,
        "0" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(remote == 0)
        },
        "1" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(remote == 1)
        },
        "both" = {
          data_tab2_scatterplot <- data_tab2_scatterplot
        }
      )
      
      switch(
        input$tab2_scatterplot_controls_suggested,
        "0" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(control_rolls == 0)
        },
        "1" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(control_rolls == 1)
        },
        "both" = {
          data_tab2_scatterplot <- data_tab2_scatterplot
        }
      )
      
      switch(
        input$tab2_scatterplot_draw_or_mind,
        "0" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(internal_lying == 0)
        },
        "1" = {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(internal_lying == 1)
        },
        "both" = {
          data_tab2_scatterplot <- data_tab2_scatterplot
        }
      )
      
      if (nrow(data_tab2_scatterplot) == 0) {
        # no data
        return(data_frame())
      } else {
        if (!is.null(input$tab2_scatterplot_citation_selectize)) {
          data_tab2_scatterplot <- data_tab2_scatterplot %>%
            filter(citation %in% input$tab2_scatterplot_citation_selectize)
        }
      }
      
      data_tab2_scatterplot
      
      
    },
    ignoreNULL = TRUE
  )


output$tab2_scatterplot_hc_UI <- renderUI({
  show("loading-tab2_scatterplot_hc")
  if (is.null(highchartOutput("tab2_scatterplot_hc"))) {
    "empty"
  } else {
    highchartOutput("tab2_scatterplot_hc")
  }
  
})

output$tab2_scatterplot_hc <- renderHighchart({
  data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc()
  
  if (nrow(data_tab2_scatterplot_hc) == 0) {
    highchart()
  } else {
    
  }
  
  if (nrow(data_tab2_scatterplot_hc) == 0) {
    hide("loading-tab2_scatterplot")
    hchart(
      type = "scatter",
      data = data_tab2_scatterplot %>%
        arrange(average_st_report_per_round),
      hcaes(x = country,
            y = average_st_report_per_round),
      color = "black",
      marker = list(symbol = "diamond")
    ) %>%
      hc_plotOptions(scatter = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Country:</b> {point.country}<br/>
          <b>Average standardized report per round:</b> {point.y}"
        )
        )) %>%
      hc_chart(zoomType = "xy") %>%
      hc_yAxis(
        title = list(text = "Standardized Report per Round"),
        lineWidth = 1,
        lineColor = "black"
      )
  } else {
    hc <- data_tab2_scatterplot %>%
      arrange(average_st_report_per_round) %>%
      select(country,
             average_st_report_per_round) %>%
      hchart(
        type = "scatter",
        hcaes(x = country,
              y = average_st_report_per_round),
        color = "black",
        marker = list(symbol = "diamond")
      ) %>%
      hc_plotOptions(scatter = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Country:</b> {point.country}<br/>
          <b>Average standardized report per round:</b> {point.y}",
          valueDecimals = 2
        )
        )) %>%
      hc_add_series(
        type = "bubble",
        data = data_tab2_scatterplot_hc %>%
          arrange(average_st_report_per_round) %>%
          select(
            country,
            standardized_report_per_round,
            subjects,
            colour,
            treatment
          ),
        hcaes(
          x = country,
          y = standardized_report_per_round,
          size = subjects,
          color = colour,
          group = treatment
        )
      ) %>%
      hc_plotOptions(bubble = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Citation:</b> {point.citation}<br/>
          <b>Treatment:</b> {point.treatment}<br/>
          <b>Country:</b> {point.country}<br/>
          <b>Standardized report per round:</b> {point.y}",
          valueDecimals = 2
        )
        )) %>%
      hc_chart(zoomType = "xy") %>%
      hc_xAxis(title = list(text = "Country"),
               labels = list(rotation = 90, step = 1),
               lineColor = "black"
               ) %>%
      hc_yAxis(
        gridLines = FALSE,
        gridLineWidth = 0,
        plotLines = list(list(
          value = 0,
          width = 1,
          color = "black",
          dashStyle = "Dash"
        )),
        title = list(text = "Standardized Report"),
        lineWidth = 1,
        lineColor = "black"
      ) %>%
      hc_add_event_point(event = "click")
    
    hide("loading-tab2_scatterplot")
    
    hc
    
  }
  
  
})



observeEvent(input$tab2_scatterplot_hc_click,
             {
               if (input$tab2_scatterplot_hc_click$series %in% data_tab2_scatterplot$treatment) {
                 toggleModal(session, "tab2_scatterplot_bubbleModal", toggle = "toggle")
               }
               
               
             })

output$tab2_scatterplot_bubble_model_UI <- renderUI({
  data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc()
  y_coord <- input$tab2_scatterplot_hc_click$y
  point_treatment <- input$tab2_scatterplot_hc_click$series
  point_country <- input$tab2_scatterplot_hc_click$name
  
  study <- data_tab2_scatterplot_hc %>%
    filter(standardized_report_per_round == y_coord) %>%
    filter(country == point_country) %>%
    filter(treatment == point_treatment)
  
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
