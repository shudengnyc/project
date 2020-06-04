nycounties <- rgdal::readOGR("http://data.beta.nyc//dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson")
nyc_neighborhoods_df <- broom::tidy(nycounties)
nyc_neighborhoods_df <- filter(nyc_neighborhoods_df,  long > -74.05)

p = ggplot() +
  geom_polygon(
    data = nyc_neighborhoods_df,
    aes(x = long, y = lat, group = group), alpha = 0.1,
    fill = "white",
    color = "black"
  ) +
  coord_map() + theme(
    axis.line = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",
    panel.background = element_blank(),
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.background = element_blank()
  )

nyc_map_polygon = ggplotly(p)




# nyc_map_polygon %>%
#   add_trace(
#     data = station_data_march_lite,
#     # data = station_data_2,
#     type = "scatter",
#     mode = "markers",
#     x = ~ station_longitude ,
#     y = ~ station_latitude,
#     marker = list(size = ~ log((total_flow) + 1)),
#     color = ~ in_out
#   ) 


## animation map
# set ggplot bar 
Noax <- list(
  title = "",
  zeroline = FALSE,
  showline = FALSE,
  showticklabels = FALSE,
  showgrid = FALSE
)

# p_2 =
#   nyc_map_polygon %>% 
#   add_trace(
#     data = station_data_march,
#     # data = station_data_2,
#     type = "scatter",
#     mode = "markers",
#     x = ~ station_longitude ,
#     y = ~ station_latitude,
#     marker = list(size = ~ log((total_flow) + 1)),
#     color = ~ in_out,
#     ids = ~ station_seq ,
#     frame = ~ timeCut
#   ) %>%
#   layout(xaxis = Noax, yaxis = Noax)
# 
# p_2 %>%
#   animation_slider(currentvalue = list(
#     prefix = "Time ",
#     font = list(color = "red"),
#     xanchor = "center"
#   ))



pal <- c("grey", "blue", "red")
nyc_map_polygon %>%
  add_trace(
    data = station_data_march,
    type = "scatter",
    mode = "markers",
    x = ~ station_longitude ,
    y = ~ station_latitude,
    marker = list(size = ~ log((total_flow) + 0.1)),
    color = ~ in_out,
    colors = ~ pal,
    ids = ~ station_seq ,
    frame = ~ timeCut
  ) %>%
  layout(xaxis = Noax, yaxis = Noax) %>%
  animation_slider(currentvalue = list(
    prefix = "Time ",
    font = list(color = "red"),
    xanchor = "center"
  ))


###---- 

# leaflet new york map 

library(leaflet)
leaflet() %>%
  addTiles() %>%
  setView(-74.00, 40.71, zoom = 11) %>%
  addProviderTiles("CartoDB.Positron")


