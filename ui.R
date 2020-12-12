
ui <- fluidPage(
        titlePanel("Chicago Crime Analysis 2020 "),
        mainPanel(tabsetPanel(
                tabPanel("Crime Types by Month Frequency",h3("Frequency of Crimes Types by Month"), fluid = TRUE,
                         # Sidebar panel for Month
                         sidebarPanel(
                                 selectInput(
                                         inputId = "month",
                                         label = "Month : ",
                                         choices = unique(crime["month"]),
                                         multiple = FALSE,
                                         selected = "1"
                                 ),
                         ),
                         mainPanel(plotOutput("BarGraph"))
                ),
                tabPanel("Location Map",h3("Crime Locations"), fluid = TRUE,
                         sidebarPanel(
                                 selectInput(
                                         inputId = "date",
                                         label = "Date : ",
                                         choices = unique(crime["date_"]),
                                         multiple = FALSE,
                                         selected = "2020-01-01 CST"
                                 ),
                                 selectInput(
                                         inputId = "CrimeType",
                                         label = "Crime Type ",
                                         choices = unique(crime["Primary Type"]),
                                         multiple = FALSE,
                                         selected = "2020-01-01 CST"
                                 )
                         ),
                         mainPanel(leafletOutput("mymap"),height="600",width="1000")),
                
                tabPanel("Heat Map",h3("Crime Locations"), fluid = TRUE,
                         mainPanel(plotOutput("HeatMap"))),
                
                
                tabPanel("Chicago Crime Analysis", fluid = TRUE,
                         # Sidebar panel for Month
                         mainPanel(plotOutput("tab4")))
                
        )))
