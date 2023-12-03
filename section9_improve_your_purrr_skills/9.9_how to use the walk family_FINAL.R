# walk

map(
  .x = 1:3,
  .f = \(x) {
    print(x)
  }
)

my_variable <- 2

map(
  .x = 1:3,
  .f = \(x) {
    my_variable <<- x
  }
)

walk(
  .x = 1:3,
  .f = \(x) {
    file.create(paste0("data/trash/", x, ".csv"))
  }
)

# walk, walk2, pwalk,
# map,  map2,  pmap

# walk functions ----------------------------------------------------------

walk(
  .x = 1:3,
  .f = \(x) {
    print(x)
  }
)

walk2(
  .x = 1:3,
  .y = 4:6,
  .f = \(x, y) {
    print(x + y)
  }
)

pwalk(
  .l = list(a = 1:3, b = 4:6),
  .f = \(a, b) {
    print(a + b)
  }
)

# Saving plots to disk ----------------------------------------------------

histograms <- gss_cat |>
  nest(data = -marital) |>
  mutate(
    histogram = pmap(
      .l = list(marital, data),
      .f = \(marital, data) {
        ggplot(data, aes(x = tvhours)) +
          geom_histogram(binwidth = 1) +
          labs(
            title = marital
          )
      } )
  )

pwalk(
  .l = histograms,
  .f = \(histogram, marital, ...) {
    ggsave(
      filename = paste0("histograms/", marital, "_histogram.png"),
      plot = histogram,
      dpi = 300
    )
  }
)

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

library(fs)

walk(
  .x = unique(histograms_per_year$year),
  .f = \(year) {
    dir_create(paste0("histograms/", year))
  }
)

pwalk(
  .l = histograms_per_year,
  .f = \(year, marital, histogram, ...) {
    ggsave(
      filename = paste0("histograms/", year, "/", marital, "_histogram.png"),
      plot = histogram,
      dpi = 300
    )
  }
)


# creating folders based on information within a data frame ---------------

folder_information <- crossing(
  runner = c("Mike", "Natasha", "Leonie", "Sabrina"),
  competition = c("half-marathon", "marathon", "10km"),
  year = 2023:2026
)

pwalk(
  .l = folder_information,
  .f = \(runner, competition, year) {
    dir_create(
      path = paste0(
        "runners/",
        runner, "/",
        year, "/",
        competition
      )
    )
  }
)