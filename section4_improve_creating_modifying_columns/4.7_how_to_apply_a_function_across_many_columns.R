mpg |>
  group_by(manufacturer) |>
  summarise(
    mean_displ = mean(displ, na.rm = TRUE),
    mean_cty   = mean(cty, na.rm = TRUE)
    # mean_hwy   = mean(hwy, na.rm = TRUE),
  )

billboard |> 
  group_by(artist) |> 
  summarise(
    mean_wk1 = mean(wk1, na.rm = TRUE),
    mean_wk2 = mean(wk2, na.rm = TRUE)
  )


# across + summarise ------------------------------------------------------



# across + mutate ---------------------------------------------------------
