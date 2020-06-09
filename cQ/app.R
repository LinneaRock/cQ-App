
library(tidyverse)
library(shiny)
source("cQ/Functions/qcl.R")
source("cQ/Functions/qsc.R")

simpleTheme <- theme_bw()+
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 20, color = "black"),
          axis.title = element_text(size = 24, color = "black"))


siteChoices <- read_rds("cQ/data/siteChoices.rds")


ui <- shinyUI(navbarPage("Concentration-Discharge Trends in Yahara River Watershed", 
                         tabPanel("Graphing cQ relationships",
                                  sidebarLayout(
                                    sidebarPanel(
                                      h2("Welcome! Explore chloride and conductivity concentration vs. discharge data for several rivers in the Upper Yahara River Watershed. Start by selecting a site from the drop-down menu."),
                                      br(), br(),
                                      
                                      selectInput("site", #make dropdown menu
                                                  "Choose a site to display the data",
                                                  choices = siteChoices,
                                                  selected = 1)
                                    ),
                                    
                                    mainPanel(
                                      plotOutput("clPlot"),
                                      plotOutput("scPlot")
                                    ))),
                         tabPanel("Citations", #second page with citations
                                  
                                  wellPanel("This app was created by Linnea Rock, a graduate student at the University of Wisconsin Center for Limnology. The data may have been summarized and aggregated for this app. The visualizaions contained in the app are therefore purely for educational purposes and do not represent any official finding or policy. Add USGS citation")
                                  )
                         ))


server <- shinyServer(function(input, output, session) {
  mastercond <- read_rds("cQ/data/mastercond.rds")
  mastercl <-read_rds("cQ/data/mastercl.rds")


siteSelection <- reactive ({
  site <- names(siteChoices)[as.numeric(input$site)]
})


data_cl <- reactive({
  site <- siteSelection()
  
  siteDat <- mastercl %>%
    dplyr::filter(sitename == site)
  
})

data_sc <- reactive({
  site <- siteSelection()
  
  siteDat2 <- mastercond %>%
    dplyr:: filter(sitename == site)
})

output$clPlot <- renderPlot({
  siteDat <- data_cl()
  
  qcl(siteDat)
})

output$scPlot <- renderPlot({
  siteDat2 <- data_sc()
  
  qsc(siteDat2)
})


})

shinyApp(ui, server)
