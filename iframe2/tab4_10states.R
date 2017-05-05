observeEvent(input$tab4_10states_reset, {
  shinyjs::reset("tab4_10states_controls")
})


output$tab4_10states_selected_continents_UI <- renderUI({
  selectInput(
    "tab4_10states_selected_continents",
    label = "Selected Continents",
    choices = unique(data_tab4_10states$continent),
    selected = unique(data_tab4_10states$continent),
    multiple = TRUE
  )
})

output$tab4_10states_selected_countries_UI <- renderUI({
  if (is.null(input$tab4_10states_selected_continents)) {
    return()
  }
  
  available_countries <- data_tab4_10states %>%
    filter(continent %in% input$tab4_10states_selected_continents) %>%
    select(country) %>%
    .[[1]] %>%
    unique()
  
  
  selectInput(
    "tab4_10states_selected_countries",
    label = "Countries to show",
    choices = available_countries,
    selected = NULL,
    multiple = TRUE
  )
})



output$tab4_10states_citation_selectize_UI <- renderUI({
  if (is.null(input$tab4_10states_selected_continents)) {
    return()
  }
  
  if (is.null(input$tab4_10states_selected_countries)) {
    available_citations <- data_tab4_10states %>%
      filter(continent %in% input$tab4_10states_selected_continents) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  } else {
    available_citations <- data_tab4_10states %>%
      filter(country %in% input$tab4_10states_selected_countries) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  }
  
  selectInput(
    "tab4_10states_citation_selectize",
    label = "Studies to show",
    choices = available_citations,
    selected = NULL,
    multiple = TRUE
  )
  ## If nothing selected, don't use!
})

data_tab4_10states_line_hc <- eventReactive(
  c(
    input$tab4_10states_incentive_range,
    input$tab4_10states_population_options,
    input$tab4_10states_citation_selectize,
    input$tab4_10states_selected_countries,
    input$tab4_10states_selected_continents
  ),
  {
    data_tab4_10states <- data_tab4_10states %>%
      filter(
        payoff_mm >= as.numeric(input$tab4_10states_incentive_range[1]) &
          payoff_mm <= as.numeric(input$tab4_10states_incentive_range[2])
      )
    
    
    switch(
      input$tab4_10states_population_options,
      "0" = {
        data_tab4_10states <- data_tab4_10states %>%
          filter(student == 0)
      },
      "1" = {
        data_tab4_10states <- data_tab4_10states %>%
          filter(student == 1)
      },
      "2" = {
        data_tab4_10states <- data_tab4_10states
      }
    )
    
    if (!is.null(input$tab4_10states_citation_selectize)) {
      data_tab4_10states <- data_tab4_10states %>%
        filter(citation %in% input$tab4_10states_citation_selectize)
    }
    
    
    
    
    data_tab4_10states
    
  },
  ignoreInit = FALSE
)

output$tab4_10states_line_hc <- renderHighchart({
  if (is.null(input$tab4_10states_selected_continents)) {
    return()
  }
  
  
  data_tab4_10states_line_hc <- data_tab4_10states_line_hc()
  
  if(nrow(data_tab4_10states_line_hc) == 0){
    print("nrow == 0 ")
    highchart()
  } else {
    print("nrow =!= 0")
  }
  
  if (is.null(input$tab4_10states_selected_countries)) {
    selected_countries <- data_tab4_10states_line_hc %>%
      filter(continent %in% input$tab4_10states_selected_continents) %>%
      select(country) %>%
      .[[1]] %>%
      unique()
  } else {
    selected_countries <- data_tab4_10states_line_hc %>%
      filter(country %in% input$tab4_10states_selected_countries) %>%
      select(country) %>%
      .[[1]] %>%
      unique()
  }
  
  data_tab4_10states_line_hc <- data_tab4_10states_line_hc %>%
    filter(country %in% selected_countries)
  
  if(nrow(data_tab4_10states_line_hc) == 0){
    print("nrow == 0 here")
    highchart()
  } else {
    hchart(
      data_tab4_10states_line_hc,
      "line",
      hcaes(
        x = standardized_report_per_round,
        y = percent,
        group = treatment,
        color = colour,
        lineColor = colour,
        name = country
      ),
      lineWidth = 1,
      marker = list(enabled = FALSE,
                    radius = 0),
      showInLegend = FALSE,
      states = list(hover = list(lineWidthPlus = 4))
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
        ) %>%
      hc_add_series(
        data = data_tab4_10states_line_hc,
        type = "bubble",
        hcaes(
          x = standardized_report_per_round,
          y = percent,
          size = subjects,
          color = colour
        ),
        showInLegend = FALSE,
        enableMouseTracking = FALSE,
        states = list(hover = list(enabled = TRUE)),
        tooltip = list(
          enabled = FALSE
        )
        ## deactivate hover for the bubble
      ) %>%
      hc_xAxis(title = list(text = "Standardized Report (6 states)"),
               lineColor = "black") %>%
      hc_yAxis(
        min = 0,
        title = list(text = "Percent"),
        lineWidth = 1,
        lineColor = "black",
        gridLines = FALSE,
        gridLineWidth = 0,
        plotLines = list(list(
          value = 50,
          width = 2,
          color = "black",
          dashStyle = "Dash"
        ))
      )
}
  
  
  
  })
