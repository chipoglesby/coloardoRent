library(dplyr)
library(ggplot2)

if(dir.exists("images") == FALSE) {
  dir.create("images")
}
  for (i in unique(coloradoRent$subregion)) {
    ggsave(
      coloradoRent %>%
        group_by(apartmenttype, year) %>%
        filter(grepl(paste(i, sep =""), subregion, fixed = TRUE)) %>% 
        summarise(medianRent = median(averagerent)) %>% 
        ggplot(aes(year, medianRent)) +
        geom_line(aes(color = apartmenttype), size = 1.5) +
        ggtitle(paste(i,"Rent", sep = " ")) +
        xlab("Year") +
        ylab("Median Rent Price") + 
        theme(plot.title = 
                element_text(
                  family = "Trebuchet MS", 
                  color = "#666666", 
                  face = "bold",
                  size = 32,
                  hjust = 0.5)) +
        theme(axis.title = 
                element_text(
                  family = "Trebuchet MS",
                  color = "#666666",
                  face = "bold", 
                  size = 22,
                  hjust = 0.5)),
      file = 
        paste(gsub('[^0-9a-z]', '', tolower(i)), ".png", sep = ""), 
      path = "images", width = 17, height = 8.8, dpi = 72)
  }