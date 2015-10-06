library(shiny)

ui <- fluidPage(
  sliderInput("num_rows",label = "number of rows", min = 1, max = 10, value = 5),
  tableOutput('table1')
)

server <- function(input, output) {
  output$table1 <- renderTable(head(Theoph, n = input$num_rows))
}

shinyApp(ui = ui, server = server)

