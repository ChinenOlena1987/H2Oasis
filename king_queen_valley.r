#A waterpark that provides fun and exciting water activities for all ages and skill levels

# 1. Install necessary packages
library(shiny)
library(plotly)

# 2. Code UI
ui <- shinyUI(fluidPage(

titlePanel("Fun Waterpark Activities"),

sidebarLayout(

# 3. Sidebar 
sidebarPanel(

# 4. Inputs
selectInput('activity_type',
            label = 'Select an Activity Type',
            choices = c("lazy river", 
                        "waterslides",
                        "wave pool",
                        "lily pads",
                        "water playground")
            ),

# 5. Run App Button
actionButton('run', 'Run App')
),

# 6. Main Panel
mainPanel(
plotlyOutput('activitiesPlot')
))
))

# 7. Code Server 
server <- shinyServer(function(input, output, session) {

# 8. Reactive Expression
activity_type <- reactive({

req(input$run)

input$activity_type

})

# 9. Plot Output
output$activitiesPlot <- renderPlotly({

# 10. Filter Data
dat <- subsets[subsets$type == activity_type(),]

# 11. Plot 
p <- plot_ly(dat, x = ~activity, y = ~ time, 
             type = 'bar', text = ~time, 
             textposition = 'outside',
             hoverinfo = 'text',
             color = ~type,
             colors = c('lazy river' = 'blue',
                        'waterslides' = 'red',
                        'wave pool' = 'pink',
                        'lily pads' = 'green',
                        'water playground' = 'orange'))

# 12. Format Plot
p <- p %>% layout(title = 'Fun Waterpark Activities',
                  xaxis = list(title = 'Activity'),
                  yaxis = list(title = 'Time (minutes)'))

# 13. Return Plot
p

})

})

# 14. Run App
shinyApp(ui, server)