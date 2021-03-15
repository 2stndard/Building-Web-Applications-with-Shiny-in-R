#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(babynames)
library(tidyverse)
top_trendy_names <- babynames %>% 
    filter(year > 1900) %>%
    group_by(name) %>%
    summarise(n1 = sum(n)) %>%
    arrange(desc(n1)) %>%
    head(30)

# Define UI for application that draws a histogram
ui <- fluidPage(
    selectInput('name', 'Select Name', top_trendy_names$name),
    # CODE BELOW: Add a plotly output named 'plot_trendy_names'
    plotly::plotlyOutput('plot_trendy_names')
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    plot_trends <- function(){
        babynames %>% 
            filter(name == input$name) %>% 
            ggplot(aes(x = year, y = n)) +
            geom_col()
    }
    # CODE BELOW: Render a plotly output named 'plot_trendy_names'
    output$plot_trendy_names <- plotly::renderPlotly({
        plot_trends()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
