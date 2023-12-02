
map(
  .x = c(1, 2, 3),
  .f = \(x) {
    print(x)
    x^2
  }
) 


# map data types ----------------------------------------------------------

c(1, 2, 3) |> 
  map(
    .x = _,
    .f = \(x) list(x^2)
  ) |> str()


c("HellO", "mY", "NAme", "IS") |> 
  map_chr(
    .f = \(my_character) {
      tolower(my_character)
    }
  )

# lists as input ----------------------------------------------------------

list(x = list(1),
     y = list(2),
     z = list(3)) |> 
  map_dbl(
    .x = _,
    .f = \(x) x[[1]]
  ) 


list(
  dframe1 = data.frame(
    id = c(1, 2, 3),
    value = c(4, 5, 6)
  ),
  dframe2 = data.frame(
    id = c(4, 5, 6),
    value = c(7, 8, 9)
  )
) |> map(
  .f = \(x) x$value
)

