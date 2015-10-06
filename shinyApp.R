library(shiny)
library(ggplot2)

ui <- fluidPage(
  plotOutput('conctime'),
  tableOutput('table1')
)

server <- function(input, output) {
  output$table1 <- renderTable(Theoph)
  
  output$conctime <- renderPlot({
    ggplot(Theoph, aes(x = Time, y = conc, group = Subject)) +
    geom_line() + theme_bw()
    })
}

shinyApp(ui = ui, server = server)

