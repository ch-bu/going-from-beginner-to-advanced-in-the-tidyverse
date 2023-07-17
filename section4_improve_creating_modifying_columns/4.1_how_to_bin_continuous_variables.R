# Binning Continuous Variables ----------------------------------------------------------------
starwars |> 
  ggplot(aes(x = height)) +
  geom_histogram(
    color = "grey20",
    fill = "steelblue",
    binwidth = 20)

# How many characters appeared in which decade? ---------------------------
starwars |> 
  count(
    decade = (birth_year %/% 10) * 10
  )

# How many characters have which height roughly? --------------------------
starwars |> 
  count(
    height_intervals = cut_width(height, 10)
  ) |> 
  ggplot(aes(y = height_intervals, x = n)) +
  geom_col()