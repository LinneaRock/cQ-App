
prcp <- function(data) {
  ggplot(data, aes(date, PRCP)) +
    geom_bar(stat = "identity") +
    labs(y = bquote("Precipitation"~(cm)~"\n"), 
         x = "") +
    theme(panel.background = element_rect(fill = "white", colour = "white",
                                          size = 2, linetype = "solid"),
          panel.grid.major = element_line(size = 0.25, linetype = 'solid',
                                          colour = "gray88"), 
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                          colour = "gray88"),
          axis.text = element_text(size =11),
          axis.title = element_text(size =11))  
}
