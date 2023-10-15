filter_larger_than <- function(data,
                               column,
                               value) {
  data |> 
    filter({{column}} > value)
}

filter_larger_than(mpg, displ, 4)

mpg |> 
  filter(displ > 4)

# tidy evaluation

plot_histogram <- function(data, 
                           column) {
  data |> 
    ggplot(aes(x = {{column}})) + 
    geom_histogram()
}

plot_histogram(mpg, displ)