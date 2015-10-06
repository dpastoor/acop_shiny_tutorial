library(shiny)

ui <- fluidPage(
  tableOutput('table1')
)

server <- function(input, output) {
  output$table1 <- renderTable(Theoph)
}

shinyApp(ui = ui, server = server)
