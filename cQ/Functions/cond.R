
cond <- function(data) {
  ggplot(data %>% drop_na(sp.cond), aes(date, sp.cond)) +
    geom_line() +
    labs(y = bquote("Specific Conductivity"~(mu~S~cm^-1)~"@ 25"*~degree*C~"\n"), 
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
