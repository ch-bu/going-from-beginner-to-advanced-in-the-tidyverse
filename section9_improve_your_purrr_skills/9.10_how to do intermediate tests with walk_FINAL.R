histograms_per_year <- gss_cat |>
  nest(data = -c(marital, year)) |>
  pwalk(
    .f = \(data, marital, year) {
      ifelse(
        test = length(unique(data$tvhours)) < 5,
        yes = print(paste(
          "für",
          marital, "im Jahr", 
          year,
          "gibt es zu wenig Daten"
        )),
        no = NA
      )
    }
  ) |> 
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
