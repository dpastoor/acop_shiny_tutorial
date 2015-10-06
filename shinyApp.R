library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput('conctime'),
  sliderInput("num_rows",label = "number of rows", min = 1, max = 10, value = 5),
  tableOutput('table1')
)

server <- function(input, output) {
  output$table1 <- renderTable(head(Theoph, n = input$num_rows))
  
  output$conctime <- renderPlot({
    ggplot(Theoph, aes(x = Time, y = conc, group = Subject)) +
    geom_line() + theme_bw()
    })
}

shinyApp(ui = ui, server = server)

