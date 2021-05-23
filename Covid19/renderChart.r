# CREATING A TIMELINE GRAPHIC USING R AND GGPLOT2
# https://benalexkeen.com/creating-a-timeline-graphic-using-r-and-ggplot2/
#
library(ggplot2)
library(scales)
library(lubridate)

events <- data.frame(
        year        = c(2021, 2021, 2021),
        month       = c(1, 3, 4),
        event       = c("Riapertura scuole (Inizio Zona Gialla)", "Chiusura scuole (Inizio Zona Rossa)", "Riapertura scuole (Inizio Zona Arancione)"), 
        restriction = c("Zona Gialla", "Zona Rossa", "Zona Arancione")
    )

# Add date column
events$date <- with(events, ymd(sprintf('%04d%02d%02d', year, month, 1)))
events <- events[with(events, order(date)), ]

# convert the status to an ordinal categorical variable, in order of criticality ranging from “Complete” to “Critical”. 
# We’ll also define some hexadecimal colour values to associate with these statuses.
restriction_levels <- c("Zona Rossa", "Zona Arancione", "Zona Gialla")
restriction_colors <- c("#C00000", "#f5a905", "#FFC000")

events$restriction <- factor(events$restriction, levels=restriction_levels, ordered = TRUE)

positions <- c(-0.5, 1.0, 0.5)
directions <- c(1, -1)

line_pos <- data.frame(
    "date" = unique(df$date),
    "position" = rep(positions, length.out=length(unique(df$date))),
    "direction" = rep(directions, length.out=length(unique(df$date)))
)

events <- merge(x = events, y = line_pos, by="date", all = TRUE)
events <- events[with(df, order(date, restriction)), ]

text_offset <- 0.05
events$text_position <- (events$month_count * text_offset * events$direction) # events$position * text_offset)

# Because we want to display all months on our timelines, not just the months we have events for, we’ll create a data frame containing all of our months.
month_buffer <- 2
month_date_range <- seq(min(events$date) - months(month_buffer), max(events$date) + months(month_buffer), by='month')
month_format <- format(month_date_range, '%b')
month_df <- data.frame(month_date_range, month_format)

# #### PLOT ####
timeline_plot <- ggplot(events, aes(x = date, y = 0, col = restriction, label = event))
timeline_plot <- timeline_plot + labs(col="event")
timeline_plot <- timeline_plot + scale_color_manual(values = restriction_colors, labels = restriction_levels, drop = FALSE)
timeline_plot <- timeline_plot + theme_classic()

# # Plot horizontal black line for timeline
timeline_plot <- timeline_plot + geom_hline(yintercept=0, color = "black", size=0.3)

# # Plot vertical segment lines for milestones
# timeline_plot <- timeline_plot + geom_segment(data = events[events$position == 1,], aes(y = 1, yend = 0, xend = date), color='black', size=0.2)
timeline_plot <- timeline_plot + geom_segment(data = events[events$position == 1,], aes(y = position, yend = 0, xend = date), color='black', size=0.2)
# Plot scatter points at zero and date
timeline_plot <- timeline_plot + geom_point(aes(y = 0), size = 3)

# Don't show axes, appropriately position legend
timeline_plot <- timeline_plot + theme(axis.line.y=element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank(),    
    axis.ticks.x =element_blank(),
    axis.line.x = element_blank(),
    legend.position = "bottom"
)

# Show text for each month
timeline_plot <- timeline_plot + geom_text(data = month_df, aes(x = month_date_range, y=-0.1, label=month_format), size=2.5, vjust=0.5, color='black', angle=90)

# Show text for each milestone
timeline_plot <- timeline_plot + geom_text(aes(y = text_position, label = event), size=2.5)

## End! 
print(timeline_plot)

# ##### RENDER DAILY CHART #####
# 
# https://www.datanovia.com/en/blog/how-to-create-a-ggplot-with-multiple-lines/
# https://www.r-graph-gallery.com/279-plotting-time-series-with-ggplot2.html
# 

# library(ggplot2)
# library(hrbrthemes)
# aggregateData <- read.csv(file = '/Users/andrea/Documents/Works/GitHub/RExercises/Covid19/aggregate.csv') 

ggplot(aggregateData, aes(x = as.Date(date))) +
    scale_colour_manual(name='', values=c("Numero positivi" = "darkgray", "Positivi su 1000 abitanti (Comune di Minerbe)" = "steelblue", "Positivi su 1000 abitanti (Provincia di Verona)" = "#69b3a2", "Contatti scolastici" = "coral2")) +
    geom_line(aes(y = casiPostivi, color="Numero positivi"), size = 1) + 
    geom_point(aes(y = casiPostivi, color="Numero positivi"), shape=21, fill="#69b3a2", size = 2) + 
    # stat_smooth(aes(y = casiPostivi), method = "lm", formula = y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5), se = FALSE, color = "lightred", size = 0.7) +   
    stat_smooth(aes(x = as.Date(date), y = casiPostivi), formula = y ~ x, inherit.aes = FALSE, se = FALSE, color = "darkorange2", size = 0.2) +
    # geom_smooth(aes(y = casiPostivi), method = "lm", formula = y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5), color = "black", fill = "firebrick")  +
    # geom_line(aes(y = maxSuPopolazione, color="Max Positivi su 1000 abitanti (Provincia)")) +
    geom_line(aes(y = scolastici, color="Contatti scolastici")) +
    geom_line(aes(y = meanSuPopolazione, color="Positivi su 1000 abitanti (Provincia di Verona)"), size = 1) +
    geom_line(aes(y = positiviSuMille, color = "Positivi su 1000 abitanti (Comune di Minerbe)"), size = 1) +
    scale_x_date(date_breaks = "4 day", date_labels = "%d-%m") +
    theme_ipsum(plot_margin = margin(30, 30, 30, 30)) +
    labs(x = "Linea temporale - Anno 2021", y = "Numero casi", title = "Evoluzione contagi COVID19", subtitle = "Comune di Minerbe", caption = "Data source: ULSS9 Scaligera") +
    theme(
        axis.text.x = element_text(angle=45, hjust=1, face=3, color="black"), 
        axis.text.y = element_text(color="black"), 
        # legend.position=c(-.8500,-.10), 
        legend.position='top', 
        legend.justification='left',
        legend.direction='horizontal',
        panel.background = element_rect(colour = "black", size = 0.2)        
    ) +
    geom_vline(xintercept = as.Date('2021-01-31'), color="yellow", size=0.5) + geom_label(aes(as.Date('2021-01-31'), 25), label = "Riapertura scuole (Inizio Zona Gialla)", show.legend = FALSE) +
    geom_vline(xintercept = as.Date('2021-03-15'), color="darkred", size=0.5) + geom_label(aes(as.Date('2021-03-15'), 28), label = "Chiusura scuole (Inizio Zona Rossa)", show.legend = FALSE) +
    geom_vline(xintercept = as.Date('2021-04-07'), color="darkorange", size=0.5) + geom_label(aes(as.Date('2021-04-07'), 25), label = "Riapertura scuole (Inizio Zona Arancione)", show.legend = FALSE) +
    geom_vline(xintercept = as.Date('2021-04-26'), color="yellow", size=0.5) + geom_label(aes(as.Date('2021-04-26'), 27), label = "Riapertura scuole 70 % (Inizio Zona Gialla)", show.legend = FALSE)
    

