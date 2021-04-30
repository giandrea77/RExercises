# CREATING A TIMELINE GRAPHIC USING R AND GGPLOT2
# https://www.themillerlab.io/post/timelines_in_r/
#
library(ggplot2)
library(scales)
library(lubridate)
library(knitr)

events <- data.frame(
  year        = c(2021, 2021, 2021),
  month       = c(1, 3, 4),
  day         = c(31, 9, 7),
  event       = c("Riapertura scuole", "Chiusura scuole", "Riapertura scuole"), 
  restriction = c("Zona Gialla", "Zona Rossa", "Zona Arancione")
)

events$date <- with(events, ymd(sprintf('%04d%02d%02d', year, month, day)))
events <- events[with(events, order(date)), ]

# Add a specified order to these event type labeles
restriction_levels <- c("Zona Rossa", "Zona Arancione", "Zona Gialla")

# Define the colors for the event types in the specified order. 
restriction_colors <- c("#ff0000", "#ffa500", "#ffea00")

# Set the heights we will use for our milestones.
positions <- c(-0.5, 1.0, 0.5) 

# Set the directions we will use for our milestone, for example above and below.
directions <- c(-1, 1) 

# Assign the positions & directions to each date from those set above.
line_pos <- data.frame(
    "date" = unique(events$date),
    "position" = rep(positions, length.out=length(unique(events$date))),
    "direction" = rep(directions, length.out=length(unique(events$date)))
)

# Create columns with the specified positions and directions for each milestone event
events <- merge(x = events, y = line_pos, by = "date", all = TRUE) 

# Let's view the new columns.
kable(head(events))

# Create a one month "buffer" at the start and end of the timeline
month_buffer <- 1
month_date_range <- seq(min(events$date) - months(month_buffer), max(events$date) + months(month_buffer), by='month')

# We are adding one month before and one month after the earliest and latest milestone in the clinical course.
## We want the format of the months to be in the 3 letter abbreviations of each month.
month_format <- format(month_date_range, '%b') 
month_df <- data.frame(month_date_range, month_format)

year_date_range <- seq(min(events$date) - months(month_buffer), max(events$date) + months(month_buffer), by='year')

# We will only show the years for which we have a december to january transition.
year_date_range <- as.Date(intersect(ceiling_date(year_date_range, unit="year"), floor_date(year_date_range, unit="year")), origin = "1970-01-01") 

# We want the format to be in the four digit format for years.
year_format <- format(year_date_range, '%Y') 
year_df <- data.frame(year_date_range, year_format)

# Create timeline coordinates with an x and y axis
timeline_plot <- ggplot(events, aes(x = date, y = position, col = restriction, label=events$event)) 

# Add the label Milestones
timeline_plot <- timeline_plot + labs(col="Milestones") 

# Assigning the colors and order to the milestones
timeline_plot <- timeline_plot + scale_color_manual(values = restriction_colors, labels=restriction_levels, drop = FALSE) 

# Using the classic theme to remove background gray
timeline_plot <- timeline_plot + theme_classic() 

# Plot a horizontal line at y=0 for the timeline
timeline_plot <- timeline_plot + geom_hline(yintercept = 0, color = "black", size = 0.3)

# Plot the vertical lines for our timeline's milestone events
timeline_plot <- timeline_plot + geom_segment(data = events, aes(y = events$position, yend=0, xend = events$date), color='black', size=0.2) 

# Now let's plot the scatter points at the tips of the vertical lines and date
timeline_plot <- timeline_plot + geom_point(aes(y = events$position), size=3) 

# Let's remove the axis since this is a horizontal timeline and postion the legend to the bottom
timeline_plot<-timeline_plot+theme(axis.line.y=element_blank(),
  axis.text.y=element_blank(),
  axis.title.x=element_blank(),
  axis.title.y=element_blank(),
  axis.ticks.y=element_blank(),
  axis.text.x =element_blank(),
  axis.ticks.x =element_blank(),
  axis.line.x =element_blank(),
  legend.position = "bottom"
)

text_offset <- 0.2 
absolute_value<-(abs(events$position)) 
text_position<- absolute_value + text_offset

events$text_position<- text_position * events$direction 

timeline_plot <- timeline_plot + geom_text(aes(y = events$text_position, label = events$event),size=3.5, vjust=0.6)

print(timeline_plot)