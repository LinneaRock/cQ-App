
discharge <- function(X) {
  ggplot(X %>% filter(date <= "2020-06-18 00:00:00", date >= "2019-12-19 00:00:00"), aes(date, discharge)) +
    geom_line() +
    labs(y = bquote("Discharge"~(m^3~s^-1)~"\n"), 
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


