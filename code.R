library('tidyverse')
library('lubridate')
library('RColorBrewer')

theme <- theme_get()

theme$text$family <- "PingFang SC"
theme_set(theme)

dates <- read_csv('seasons.csv')

dates <- dates %>% mutate(start = mdy(start),
                          end = mdy(end))

dates$name.f <- factor(dates$name, levels = c('立春 / Spring',
                                              '立夏 / Summer',
                                              '立秋 / Autumn',
                                              '立冬 / Winter'))

start_date <- as.Date('2018-01-01')
end_date <- as.Date('2019-04-01')

ggplot(data = dates, aes(x = calendar, y = start, 
                         ymin = start, ymax = end, color=name.f)) +
  geom_linerange(size = 5)  + labs(x = '', y= '', color='节气 / Season') +
  scale_y_date(date_labels = "%b", date_breaks = '1 month',
               date_minor_breaks = "1 day",
               limits = c(start_date, end_date)) + coord_flip()+
  theme(panel.grid.major = element_blank(), 
        axis.text = element_text(size = 10),
        axis.line.x = element_line(color = 'black'),
        axis.ticks = element_blank()) +
  scale_color_brewer(palette = "Paired") 

ggsave('seasons.png', width = 10, height = 2)