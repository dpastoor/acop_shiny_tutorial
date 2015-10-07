library(shiny)
library(DT)

ui <- fluidPage(
  fluidRow(
    column(2,
           wellPanel(
             checkboxGroupInput('show_vars', 
                                'Columns in data set to show:',
                                choices = NULL, selected = NULL)
            )
    ),
    column(10, 
         dataTableOutput('table1')
        )
  )
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
  
  observe({
    col_names <- names(rdsData())
    updateCheckboxGroupInput(session, 'show_vars', 'Columns in data set to show:',
                             choices =  col_names, 
                             selected =  col_names)
  })
  
  output$table1 <- renderDataTable({
    data <- rdsData()
    data[, input$show_vars, drop = FALSE]
    }, options = list(orderClasses = TRUE, 
                      lengthMenu = c(10, 30, 50), 
                      pageLength = 15
                      )
    )
}

shinyApp(ui = ui, server = server)

