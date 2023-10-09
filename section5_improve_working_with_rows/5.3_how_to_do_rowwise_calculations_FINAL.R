dframe <- tibble(
  name = c("Jakob", "Eliud", "Jamal", "Emily"),
  first = c(1, 4, 7, 10),
  second = c(2, 5, 8,11),
  third = c(3, 6, 9, 12)
)

dframe |> 
  mutate(
    mean = mean(c(first, second, third))
  )

mean(1:12)

dframe |> 
  mutate(
    mean = (first + second + third) / 3
  )

# rowwise -----------------------------------------------------------------
dframe |> 
  rowwise() |> 
  mutate(
    mean = mean(c(first, second, third)),
    sum = sum(c(first, second, third))
    # max, median
  ) |> 
  ungroup()



# tidyselect --------------------------------------------------------------
dframe |> 
  rowwise() |> 
  mutate(
    mean = mean(c_across(where(is.numeric))),
    sum  = sum(c_across(where(is.numeric)))
  ) |> 
  ungroup()

billboard |> 
  rowwise() |> 
  transmute(
    artist,
    track, 
    mean = mean(c_across(contains("wk")), na.rm = TRUE)
  ) |> 
  ungroup()


# calculating proportions -------------------------------------------------

df <- tibble(
  name = c("Sabrina", "Robert", "Christina"),
  cookies_week1 = c(2, 4, 2),
  cookies_week2 = c(3, 2, 2),
  cookies_week3 = c(6, 2, 1)
)

df |> 
  rowwise() |> 
  mutate(sum = sum(cookies_week1, 
                           cookies_week2, 
                           cookies_week3)) |> 
  ungroup() |> 
  transmute(
    name,
    sum,
    across(
      .cols = contains("cookies"),
      .fns = \(x) x / sum
    )
  )


# What if you care for speed ----------------------------------------------

dframe |> 
  mutate(
    max = pmax(first, second, third),
    min = pmin(first, second, third),
    sum = rowSums(matrix(c(first, second, third), ncol = 3)),
    sum2 = rowSums(across(first:third)),
    mean = rowMeans(across(first:third))
  )

