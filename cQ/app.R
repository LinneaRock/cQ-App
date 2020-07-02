
library(tidyverse)
library(shiny)

setwd("C:/Users/linne/Box Sync/cQ-App")
source("cQ/Functions/qcl.R")
source("cQ/Functions/qsc.R")
source("cQ/Functions/chloride.R")
source("cQ/Functions/cond.R")
source("cQ/Functions/discharge.R")




siteChoices <- read_rds("cQ/data/siteChoices.rds")
siteChoices1 <- read_rds("cQ/data/siteChoices.rds")


ui <- shinyUI(navbarPage("Concentration-Discharge Trends in Yahara River Watershed", 
                         
                         #Page 1 with time series
                         tabPanel("Time series trends",
                                  sidebarLayout(
                                    sidebarPanel(
                                      h2("Welcome! Check out time series trends for several rivers in the Upper Yahara River Watershed. Start by selecting a site from teh drop-down menu."),
                                      br(), br(),
                                      
                                      selectInput("site", #make dropdown menu
                                                  "Choose a site to display the data",
                                                  choices = siteChoices,
                                                  selected = 1)
                                    ),
                                    
                                    mainPanel(
                                      h4("Precipitation"),
                                      plotOutput("precipPlot"),
                                      h4("Chloride"),
                                      plotOutput("chloridePlot"),
                                      h4("Specific Conductivity"),
                                      plotOutput("condPlot"),
                                      h4("Discharge"),
                                      plotOutput("disPlot")
                                    )
                                  )),
                         
                         #Page 2 with cQ graphs
                         tabPanel("Graphing cQ relationships",
                                  sidebarLayout(
                                    sidebarPanel(
                                      h2("Explore chloride and conductivity concentration vs. discharge data for several rivers in the Upper Yahara River Watershed. Start by selecting a site from the drop-down menu."),
                                      br(), br(),
                                      
                                      selectInput("site1", #make dropdown menu
                                                  "Choose a site to display the data",
                                                  choices = siteChoices1,
                                                  selected = 1)
                                    ),
                                    
                                    mainPanel(
                                      h4("Chloride vs. Discharge"),
                                      plotOutput("clPlot"),
                                      h4("Specific Conductivity vs. Discharge"), 
                                      plotOutput("scPlot")
                                    ))),
                         
                         #page 3 for citations 
                         tabPanel("Citations", 
                                  
                                  wellPanel("This app was created by Linnea Rock, a graduate student at the University of Wisconsin Center for Limnology. The data may have been summarized and aggregated for this app. The visualizaions contained in the app are therefore purely for educational purposes and do not represent any official finding or policy. Add USGS citation")
                                  )
                         ))


server <- shinyServer(function(input, output, session) {
  master<- read_rds("cQ/data/master.rds")
  

#Page 1 
siteSelection <- reactive ({
  site <- names(siteChoices)[as.numeric(input$site)]
})

data <- reactive({
  site <- siteSelection()
  
  siteDat <- master %>%
    dplyr::filter(sitename == site)
  
})

output$chloridePlot <- renderPlot({
  siteDat <- data()
  
  chloride(siteDat)
})

output$condPlot <- renderPlot({
  siteDat <- data()
  
  cond(siteDat)
})


output$disPlot <- renderPlot({
  siteDat <- data()
  
  discharge(siteDat)
})


#Page 2 
siteSelection1 <- reactive ({
  site <- names(siteChoices1)[as.numeric(input$site1)]
})


data2 <- reactive({
  site <- siteSelection1()
  
  siteDat2 <- master %>%
    dplyr::filter(sitename == site)
  
})


output$clPlot <- renderPlot({
  siteDat2 <- data2()
  
  qcl(siteDat2)
})

output$scPlot <- renderPlot({
  siteDat2 <- data2()
  
  qsc(siteDat2)
})





})

shinyApp(ui, server)
``
