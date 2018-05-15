library(shiny)
library(ggplot2)
library(DT)

data <- read.csv("all_data.csv", header=T, stringsAsFactors = F)

startTime <- min(data$Year)
endTime <- max(data$Year)
region <- unique(data$Region)

ui <- fluidPage(
  
   tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
   ),
  
  titlePanel("CO2 Emission!"),

  sidebarLayout(
    

      sidebarPanel(
        
        sliderInput(inputId = "time",
                    label = "Year:",
                    min = startTime,
                    max = endTime,
                    step = 1,
                    value = 2000),
        
        tags$hr(),
        
        checkboxGroupInput(inputId = "region",
                           label="Region:",
                           choices = region,
                           selected = region
        )
      ),


    mainPanel(
      # ÿһ��������ŷ����� ��״ͼ
      plotOutput(outputId = "emission"),
      
      # ÿһ�������λ�ŷ� ��״ͼ
      plotOutput(outputId = "unitEmission"),
      
      # ��λ�ŷ� ���ŷ� ����ά�� ɢ��ͼ
      # ���������ʾ��ݡ����ҡ�����
      plotOutput(outputId = "scatter"),
      
      # չʾ����
      DTOutput("table")
      
    )
  )
)