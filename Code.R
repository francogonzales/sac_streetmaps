setwd('/Users/franco/Documents/Projects/Map')

library(ggmap)
library(tidyverse)
library(osmdata)

sacramento = getbb("Sacramento California") %>%
  opq() %>%
  add_osm_feature(key = 'highway',
                  value = c('motorway', 'primary', 'secondary', 'tertiary')) %>%
  osmdata_sf()


ggplot() +
  geom_sf(data = sacramento$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
  coord_sf()

ggsave('1.jpg', width = 6, height = 6)

# At this point, I will "update" the map to make it more aesthetically pleasing.

ggplot() +
  geom_sf(data = sacramento$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          alpha = .7) +
  coord_sf(expand = FALSE,
           ylim = c(38.4, 38.72),
           xlim = c(-121.6, -121.34))

# Limited the coordinates here to remove the parts that weren't neccessary.
# Also changed the size of the lines to be less clunky.


ggsave('2.jpg', width = 6, height = 6)

streets = getbb('Sacramento California') %>%
  opq() %>%
  add_osm_feature(key = 'highway', 
                 value = c('residential', 'living_street',
                           'unclassified',
                           'service', 'footway', 'motorway_link', 
                           'trunk_link', 'primary_link', 'secondary_link', 'tertiary_link')) %>%
  osmdata_sf()

# This adds the rest of the roads. Connecting highways, mainstreets, alleys, etc.

water = getbb('Sacramento California')%>%
  opq()%>%
  add_osm_feature(key = 'waterway', value = 'river') %>%
  osmdata_sf()

# The Sacramento and American river will be shown here.

land = getbb('Sacramento California') %>%

# This adds the "scenery outside of the main roadways.
  opq%>%
  add_osm_feature(key = 'landuse', value = c('commercial', 'industrial', 'residential', 'retail') ) %>%
  osmdata_sf()

# This is where the actual filling in happens.

ggplot() +
  geom_sf(data = sacramento$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          alpha = .7) +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "grey20",
          size = .1,
          alpha = .6) +
  geom_sf(data = water$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .3,
          alpha = .5) +
  geom_sf(data = land$osm_lines) +
  coord_sf(expand = FALSE,
          ylim = c(38.4, 38.72),
          xlim = c(-121.6, -121.34)) 
  

# I added the smaller streets and water ways to the map. To be more specific, the residential portions
# outside of the main roads. Water ways are shown in blue.

ggsave('3.jpg', width = 6, height = 6)

ggplot() +
  geom_sf(data = sacramento$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .3,
          alpha = .9) +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "grey20",
          size = .1,
          alpha = .6) +
  geom_sf(data = water$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .3,
          alpha = .5) +
  geom_sf(data = land$osm_lines) +
  coord_sf(expand = FALSE,
           ylim = c(38.4, 38.72),
           xlim = c(-121.6, -121.34)) +
  theme_void()

# Removed grid background and axis labels.

ggsave('4.jpg', width = 6, height = 6)

ggplot() +
  geom_sf(data = sacramento$osm_lines,
          inherit.aes = FALSE,
          color = "#82b6f0",
          size = .3,
          alpha = .9) +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .1,
          alpha = .6) +
  geom_sf(data = water$osm_lines,
          inherit.aes = FALSE,
          color = "#09bdf1",
          size = .3,
          alpha = .5) +
  geom_sf(data = land$osm_lines) +
  coord_sf(expand = FALSE,
           ylim = c(38.4, 38.72),
           xlim = c(-121.6, -121.34)) +
  theme_void() + 
  theme(
    plot.background = element_rect(fill = "#282828"))

# Here I attempt to create a dark theme by using colors that I liked in hex colors.
# The codes correspond to a unique color.

ggsave('4-dark.jpg', width = 6, height = 6)

