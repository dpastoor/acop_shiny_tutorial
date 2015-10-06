library(shiny)
library(DT)

ui <- fluidPage(
  dataTableOutput('table1')
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

  output$table1 <- renderDataTable({
    rdsData()
    }, options = list(orderClasses = TRUE, 
                      lengthMenu = c(10, 30, 50), 
                      pageLength = 15
                      )
    )
}

shinyApp(ui = ui, server = server)

