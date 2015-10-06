library(shiny)

ui <- fluidPage(
  sliderInput("num_rows",label = "number of rows", min = 1, max = 10, value = 5),
  tableOutput('table1')
)

server <- function(input, output, session) {
  
  #### only for initialization on first run ---
  rdsData <- NULL
  if (is.null(rdsData)) {
    #give some initial data to plot out in case none available
    rdsData <- Theoph
    if(!file.exists('data.rds')) {
      saveRDS(Theoph, 'data.rds')
    }
  }
  
  rdsData <- reactiveFileReader(1000, session, 'data.rds', readRDS)

  output$table1 <- renderTable({head(rdsData(), n = input$num_rows)})
}

shinyApp(ui = ui, server = server)

