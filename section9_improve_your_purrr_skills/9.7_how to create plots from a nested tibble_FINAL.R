
gss_cat |> 
  ggplot(aes(x = tvhours)) +
  geom_histogram() +
  facet_wrap(vars(marital))

# Nested example ----------------------------------------------------------

histograms <- gss_cat |> 
  nest(data = -marital) |> 
  mutate(
    histograms = pmap(
      .l = list(data, marital),
      .f = \(d, marital) {
        
        mean_tv = mean(d$tvhours, na.rm = TRUE)
        
        d |> 
          ggplot(aes(x = tvhours)) +
          geom_histogram() +
          labs(
            title = glue("{marital} · Mittelwert: {round(mean_tv, 2)}")
          )
      }
    )
  )

# Patchwork plots ---------------------------------------------------------

library(patchwork)

histograms$histograms |> 
  reduce(`+`)

histograms$histograms |> 
  wrap_plots(ncol = 4)


# patchworked plots within a nested data frame ----------------------------

plots <- gss_cat |> 
  nest(data = -marital) |> 
  mutate(
    histograms = pmap(
      .l = list(data, marital),
      .f = \(d, marital) {
        
        mean_tv = mean(d$tvhours, na.rm = TRUE)
        
        d |> 
          ggplot(aes(x = tvhours)) +
          geom_histogram() +
          labs(
            title = glue("{marital} · Mittelwert: {round(mean_tv, 2)}")
          )
      }
    ),
    scatterplot = pmap(
      .l = list(data, marital),
      .f = \(d, marital) {
        d |> 
          ggplot(aes(x = age, y = tvhours)) +
          geom_point() +
          labs(title = marital)
      }
    ),
    combined = pmap(
      .l = list(histograms, scatterplot),
      .f = \(hist, scatter) {
        list(hist, scatter) |> 
          wrap_plots(ncol = 2)
      }
    )
  )

plots$combined |> 
  wrap_plots(ncol = 1)