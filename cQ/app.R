
library(tidyverse)
library(shiny)

simpleTheme <- theme_bw()+
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 20, color = "black"),
          axis.title = element_text(size = 24, color = "black"))
