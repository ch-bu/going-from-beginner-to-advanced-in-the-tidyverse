library(glue)

# map2 --------------------------------------------------------------------

map2_int(
  .x = c(1, 4),
  .y = c(4, 6),
  .f = \(x, z) {
    x + z
  }
)

map2_chr(
  .x = c(1, 4),
  .y = c(4, 6),
  .f = \(x, z) {
    glue("{x} plus {z} equals = {x + z}")
  }
)

map2_int(
  .x = c(1, 4),
  .y = c(4),
  .f = \(x, y) x + y
)

map2_int(
  .x = c(1, 4),
  .y = c(4, 3, 9),
  .f = \(x, y) x + y
)

map(
  .x = c(1, 2, 3),
  .f = \(zahl) {
    zahl + nrow(mpg)
  }
)


# pmap --------------------------------------------------------------------

pmap_int(
  .l = list(
    eins = c(1, 2), # x
    zwei = c(3, 4), # y
    drei = c(5, 6)  # z
  ),
  .f = \(eins, zwei, drei) {
    eins + zwei + drei
  }
)

dice_rolls <- crossing(
  size = c(5, 10, 100, 200, 500),
  min  = c(1, 2),
  max  = c(6)
)

pmap(
  .l = dice_rolls,
  .f = \(size, min , max) {
    sample(min:max, size, replace = TRUE)
  }
)


# dot dot dot -------------------------------------------------------------

mpg |> 
  select(manufacturer, model)

words <- tribble(
  ~id, ~w, ~x, ~y, ~z,
  1, "t", "w", "o", NULL,
  2, "t", "r", "e", "e",
  3, "p", "o", "t", NULL
)

pmap_chr(
  .l = words,
  .f = \(id, ...) {
    reduce(c(...), paste0)
  }
)

billboard |> 
  select(track, where(is.numeric)) |> 
  pmap_chr(
    .f = \(track, ...) {
      paste(
        track,
        "mean ranking:",
        round(mean(c(...), na.rm = TRUE), 2)
      )
    }
  )

pmap_int(
  .l = list(
    a = c(1, 3, 4), # ..1
    b = c(5, 6, 7), # ..2
    c = c(8, 9, 10) # ..3
  ),
  .f = \(...) {
    ..1 + ..3
  }
)
