library(shiny)
library(ggplot2)
library(DT)

data <- read.csv("all_data.csv", header=T, stringsAsFactors = F)

startTime <- min(data$Year)
endTime <- max(data$Year)
region <- unique(data$Region)


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  filterByYearEmissionData <- reactive({
    subset(data, Year==input$time)
    # data[data$Year==input$time,]
  })
  
  EmissionData <- reactive({
    subset(filterByYearEmissionData(), Region %in% input$region)
  })
  
  filterByYearUnitEmissionData <- reactive({
    data[data$Year==input$time,]
  })
  
  EmissionUnitData <- reactive({
    subset(filterByYearUnitEmissionData(), Region %in% input$region)
  })
  
  output$emission <- renderPlot({
    ggplot(data = EmissionData(), 
           aes(x=Region, y=Emissions, fill=factor(Region))) + 
      geom_bar(position = "dodge", stat = "identity") + ylab("Total Emissions") + 
      theme(legend.position="right" 
            ,plot.title = element_text(size=15, face="bold"),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) + 
      ggtitle("Total Emissions By Year") + labs(fill = "Region")
  })
  output$unitEmission <- renderPlot({
    ggplot(data = EmissionUnitData(), 
           aes(x=Region, y=EmissionsPer, fill=factor(Region))) + 
      geom_bar(position = "dodge", stat = "identity") + ylab("Emissions Per Capita") + 
      theme(legend.position="right" 
            ,plot.title = element_text(size=15, face="bold"),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) + 
      ggtitle("Emissions Per Capita By Year") + labs(fill = "Region")
  })
  
  
  
  output$scatter <- renderPlot({
    ggplot(data, aes(x = Emissions, y = EmissionsPer)) + geom_point(aes(colour = factor(Region),size=8,alpha = 0.05)) + 
    theme(legend.position="right" 
            ,plot.title = element_text(size=15, face="bold")) + 
    ggtitle("Scatter Graph")
  })
  
  output$table <- renderDT(
    subset(data, Year== input$time), options = list(
      pageLength = 10
    )
  )
}