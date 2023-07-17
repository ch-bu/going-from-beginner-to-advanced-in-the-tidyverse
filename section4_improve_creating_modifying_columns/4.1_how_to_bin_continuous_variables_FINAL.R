# Binning Continuous Variables ----------------------------------------------------------------
starwars |> 
  ggplot(aes(x = height)) +
  geom_histogram(
    color = "grey20",
    fill = "steelblue",
    binwidth = 20)

# How many characters appeared in which decade? ---------------------------




# How many characters have which height roughly? --------------------------
