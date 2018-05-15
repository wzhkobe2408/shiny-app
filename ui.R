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
      # 每一年地区总排放排名 柱状图
      plotOutput(outputId = "emission"),
      
      # 每一年地区单位排放 柱状图
      plotOutput(outputId = "unitEmission"),
      
      # 单位排放 总排放 两个维度 散点图
      # 鼠标悬浮显示年份、国家、数量
      plotOutput(outputId = "scatter"),
      
      # 展示数据
      DTOutput("table")
      
    )
  )
)