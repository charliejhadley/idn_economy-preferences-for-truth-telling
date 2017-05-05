
output$tab2_scatterplot_selected_continents_UI <- renderUI({
  selectInput(
    "tab2_scatterplot_selected_continents",
    label = "Selected Continents",
    choices = unique(data_tab2_scatterplot$continent),
    selected = unique(data_tab2_scatterplot$continent),
    multiple = TRUE
  )
})

output$tab2_scatterplot_selected_countries_UI <- renderUI({
  if (is.null(input$tab2_scatterplot_selected_continents)) {
    return()
  }
  
  available_countries <- data_tab2_scatterplot %>%
    filter(continent %in% input$tab2_scatterplot_selected_continents) %>%
    select(country) %>%
    .[[1]] %>%
    unique()
  
  
  selectInput(
    "tab2_scatterplot_selected_countries",
    label = "Countries to show",
    choices = available_countries,
    selected = NULL,
    multiple = TRUE
  )
})



output$tab2_scatterplot_citation_selectize_UI <- renderUI({
  if (is.null(input$tab2_scatterplot_selected_continents)) {
    return()
  }
  
  if (is.null(input$tab2_scatterplot_selected_countries)) {
    available_citations <- data_tab2_scatterplot %>%
      filter(continent %in% input$tab2_scatterplot_selected_continents) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  } else {
    available_citations <- data_tab2_scatterplot %>%
      filter(country %in% input$tab2_scatterplot_selected_countries) %>%
      select(citation) %>%
      .[[1]] %>%
      unique()
  }
  
  selectInput(
    "tab2_scatterplot_citation_selectize",
    label = "Studies to show",
    choices = available_citations,
    selected = NULL,
    multiple = TRUE
  )
  ## If nothing selected, don't use!
})

data_tab2_scatterplot_hc <- eventReactive(
  c(
    input$tab2_scatterplot_incentive_range,
    input$tab2_scatterplot_population_options,
    input$tab2_scatterplot_citation_selectize,
    input$tab2_scatterplot_selected_countries,
    input$tab2_scatterplot_selected_continents
  ),
  {
    data_tab2_scatterplot <- data_tab2_scatterplot %>%
      filter(
        payoff_mm >= as.numeric(input$tab2_scatterplot_incentive_range[1]) &
          payoff_mm <= as.numeric(input$tab2_scatterplot_incentive_range[2])
      )
    
    
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
      "2" = {
        data_tab2_scatterplot <- data_tab2_scatterplot
      }
    )
    
    if (!is.null(input$tab2_scatterplot_citation_selectize)) {
      data_tab2_scatterplot <- data_tab2_scatterplot %>%
        filter(citation %in% input$tab2_scatterplot_citation_selectize)
    }
    
    
    
    
    data_tab2_scatterplot
    
  },
  ignoreInit = FALSE
)

output$tab2_scatterplot_hc <- renderHighchart({
  
  if (is.null(input$tab2_scatterplot_selected_continents)) {
    return()
  }
  
  
  data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc()
  
  if(nrow(data_tab2_scatterplot_hc) == 0){
    print("nrow == 0 ")
    highchart()
  } else {
    print("nrow =!= 0")
  }
  
  if (is.null(input$tab2_scatterplot_selected_countries)) {
    selected_countries <- data_tab2_scatterplot_hc %>%
      filter(continent %in% input$tab2_scatterplot_selected_continents) %>%
      select(country) %>%
      .[[1]] %>%
      unique()
  } else {
    selected_countries <- data_tab2_scatterplot_hc %>%
      filter(country %in% input$tab2_scatterplot_selected_countries) %>%
      select(country) %>%
      .[[1]] %>%
      unique()
  }
  
  data_tab2_scatterplot_hc <- data_tab2_scatterplot_hc %>%
    filter(country %in% selected_countries)
  
  if(nrow(data_tab2_scatterplot_hc) == 0){
    print("nrow == 0 here")
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
      hc_yAxis(title = list(text = "Standardized Report per Round"),
               lineWidth = 1,
               lineColor = "black")
  } else {
    
    data_tab2_scatterplot %>%
      arrange(average_st_report_per_round) %>%
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
          <b>Average standardized report per round:</b> {point.y}"
        )
        )) %>%
      hc_add_series(
        type = "bubble",
        data = data_tab2_scatterplot_hc %>%
          arrange(average_st_report_per_round),
        hcaes(
          x = country,
          y = standardized_report_per_round,
          size = subjects,
          color = colour
        )
      ) %>%
      hc_plotOptions(bubble = list(
        tooltip = list(
          headerFormat = "",
          pointFormat = "
          <b>Citation:</b> {point.citation}<br/>
          <b>Treatment:</b> {point.treatment}<br/>
          <b>Country:</b> {point.country}<br/>
          <b>Standardized report per round:</b> {point.y}"
        )
        )) %>%
      hc_chart(zoomType = "xy") %>%
      hc_yAxis(title = list(text = "Standardized Report per Round"),
               lineWidth = 1,
               lineColor = "black")
    
  }
  
  
  
})