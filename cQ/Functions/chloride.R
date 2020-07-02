
chloride <- function(data) {
  ggplot(data %>% drop_na(chloride_mgL), aes(date, chloride_mgL)) +
    geom_point() +
    labs(y = bquote("Chloride Concentration"~(mg~L^-1)~"\n"), 
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
