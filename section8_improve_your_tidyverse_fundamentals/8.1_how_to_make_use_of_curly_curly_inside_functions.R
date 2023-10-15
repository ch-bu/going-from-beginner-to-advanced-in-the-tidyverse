filter_larger_than <- function(data,
                               column,
                               value) {
  data |> 
    filter(column > value)
}

filter_larger_than(mpg, displ, 4)
