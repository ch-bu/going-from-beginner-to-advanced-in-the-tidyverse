
map(
  .x = c(1, 2, 3),
  .f = \(x) {
    x^2
  }
) |> typeof()

# map data types ----------------------------------------------------------
map_dbl(
  .x = c(1, 2, 3),
  .f = \(x) x / 2
)

c(1, 0, 1) |> 
  map_lgl(
    .x = _,
    .f = \(x) x
  )

c(1, 2, 3) |> 
  map_dbl(
    .f = \(x) x + x
  )

# lists as input ----------------------------------------------------------

list(
  x = list(1), 
  y = list(2), 
  z = list(3)
) |> 
  map_dbl(
    .f = \(x) x[[1]]
  )

list(
  dframe1 = data.frame(id = c(1, 2, 3), value = c(4, 5, 6)),
  dframe2 = data.frame(id = c(1, 2, 3), value = c(8, 10, 33))
) |> 
  map(
    .f = \(x) x$value
  )
  