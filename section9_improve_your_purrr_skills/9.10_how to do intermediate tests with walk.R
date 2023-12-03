histograms_per_year <- gss_cat |>
  nest(data = -c(marital, year)) |>
  mutate(
    histogram = pmap(
      .l = list(marital, data, year),
      .f = \(marital, data, year) {
        ggplot(data, aes(x = tvhours)) +
          geom_histogram(binwidth = 1) +
          labs(
            title = marital,
            subtitle = year
          )
      } )
  )
