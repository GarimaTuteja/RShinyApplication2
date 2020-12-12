server <- function(input, output) 
{
        
        output$BarGraph <-  renderPlot({
                newCounts <- crime %>% filter(crime$month == input$month)
                barplot(table(newCounts$`Primary Type`),
                        main = "Frequency Crime Type",
                        xlab = "Crime Type",
                        ylab = "Frequency", 
                        col=brewer.pal(n = 40, name = "RdBu"),
                        legend.text=TRUE,
                        args.legend = list(x ='topright', bty='n', inset=c(-0.58,0)))
        },height = 600, width = 850)
        
        
        output$HeatMap <- renderPlot ({ 
                heatmap_data <- crime %>% dplyr::select(`Primary Type`, hour) %>% 
                        mutate(hour = factor(format(strptime(hour, format='%H'), '%I%p'),
                                             levels = format(strptime(0:23, format='%H'), '%I%p'))) %>% 
                        table()
                
                heatmap(heatmap_data, 
                        Colv = NA, 
                        Rowv = NA, 
                        scale = "column")} ,height = 600, width = 850  
        )
        
        
        
        output$mymap <- renderLeaflet({
                
                df_filtered <- crime %>%filter(crime$date_ == input$date & crime$`Primary Type` == input$CrimeType)
                kable(head(df_filtered)) %>%
                        kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"))
                df_filtered %>%leaflet() %>%addTiles() %>%
                        addMarkers(clusterOptions = markerClusterOptions(),
                                   popup = paste(crime$Latitude,crime$Longitude))
                
                
        })
        
        # For tab4 we will be displaying the categorical varibales that will help in understanding how crime in chicago works
        
        output$tab4 <- renderPlot({
                
                cat_value_freq <-  crime %>% select_if(is.factor) %>% select_if(function(x) !is.ordered(x)) %>% 
                        gather("var", "value") %>% 
                        group_by(var) %>% 
                        count(var, value) %>%
                        mutate(prop = prop.table(n)) %>% 
                        filter(prop > .02)
                
                cat_plot1 <-
                        ggplot(data = cat_value_freq,
                               aes(x = reorder(stringr::str_wrap(value, 20), prop),
                                   y = prop)) +
                        geom_bar(stat = "identity", fill = "#92224E") +
                        coord_flip() +
                        facet_wrap(~var, ncol = 3, scales = "free") +
                        ggthemes::theme_fivethirtyeight()
                
                cat_plot1
        },height = 700, width = 1200)
        
        
        
        
        
        
}