
fitted_models <- diamonds |> 
  nest(.by = cut) |> 
  mutate(
    fitted_model = map(
      .x = data,
      .f = \(data) {
        lm(price ~ carat, data = data)
      }
    ),
    r_squared = map_dbl(
      .x = fitted_model,
      .f = \(model) {
        summary(model)$r.squared
      }
    )
  )


# p-hacking ---------------------------------------------------------------
# https://colinfay.me/purrr-statistics/

midwest_numeric <- midwest |> 
  select(where(is.numeric), -PID)

library(tidystringdist)

combinations <- tidy_comb_all(names(midwest_numeric))

significant <- combinations |> 
  mutate(
    cor_test = pmap(
      .l = list(V1, V2),
      .f = \(v1, v2) {
        cor.test(midwest_numeric[[v1]],
                 midwest_numeric[[v2]])
      }
    ),
    p_value = map_dbl(
      .x = cor_test,
      .f = \(correlation) {
        correlation$p.value
      }
    )
  ) |> 
  dplyr::filter(p_value < .05)
