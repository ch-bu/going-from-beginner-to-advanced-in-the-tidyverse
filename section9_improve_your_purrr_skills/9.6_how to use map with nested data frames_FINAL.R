
iris |> 
  as_tibble()


# Working with data frames ------------------------------------------------
iris |> 
  as_tibble() |> 
  mutate(
    new_column = map_dbl(
      .x = Sepal.Length,
      .f = \(x) {
        x^2
      }
    )
  ) |> glimpse()

iris |> 
  as_tibble() |> 
  mutate(
    new_column = pmap_chr(
      .l = list(
        a = Sepal.Length,
        b = Petal.Length
        ),
      .f = \(a, b) {
        mean(c(a, b))
        glue("Sepal Length liegt bei {a} und
             Petal Length liegt bei {b}")
      }
    )
  ) |> glimpse()

# Working with nested data frames -----------------------------------------

iris |> 
  as_tibble() |> 
  nest(.data = _,
       data = -Species) |> 
  mutate(
    filtered_sepal = map(
      .x = data,
      .f = \(x) {
        x |> 
          dplyr::filter(Sepal.Length < 6)
      }
    ),
    nrows = map_int(
      .x = filtered_sepal,
      .f = \(x) {
        nrow(x)
      }
    )
  )

iris |> 
  as_tibble() |> 
  nest(.data = _,
       sepal = contains("Sepal"),
       petal = contains("Petal")) |> 
  mutate(
    bigger_than = pmap_chr(
      .l = list(
        a = sepal,
        b = petal
      ),
      .f = \(a, b) {
        mean_sepal = mean(a$Sepal.Width)
        mean_petal = mean(b$Petal.Width)
        
        glue("Sepal Width {mean_sepal} ist größer als Petal Width {mean_petal}")
      }
    )
  )