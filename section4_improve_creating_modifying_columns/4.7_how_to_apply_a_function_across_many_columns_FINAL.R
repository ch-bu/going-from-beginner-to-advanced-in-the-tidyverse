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
mpg |> 
  group_by(manufacturer) |> 
  summarise(
    across(
      .cols = c("displ", "cty"),
      .fns = \(x) mean(x, na.rm = TRUE),
      .names = "mean_{.col}"
    )
  )

mpg |> 
  group_by(manufacturer) |> 
  summarise(
    across(
      .cols = c(displ, cty),
      .fns = list(
          mean = \(x) mean(x, na.rm = TRUE), 
          sd = \(x) sd(x, na.rm = TRUE)
        ),
      .names = "{.fn}_{.col}"
    )
  )

# tidyselect
mpg |> 
  group_by(manufacturer) |> 
  summarise(
    across(
      .cols = where(is.numeric),
      .fns = list(
        mean = \(x) mean(x, na.rm = TRUE), 
        sd = \(x) sd(x, na.rm = TRUE)
      ),
      .names = "{.fn}_{.col}"
    )
  )

# Rebecca Barter
mpg |> 
  summarise(
    across(
      .cols = everything(),
      .fns = \(x) n_distinct(x)
    )
  )


# across + mutate ---------------------------------------------------------

# Datentypen ändern
mpg |> 
  mutate(
    across(
      .cols = where(is.character),
      .fns = \(x) as.factor(x),
      .names = "{.col}_factor"
    )
  ) |> 
  select(where(is.factor) | where(is.character)) |> 
  glimpse()

# Runden
mpg |> 
  mutate(
    across(
      .cols = where(is.numeric),
      .fns = \(x) round(x)
    )
  ) |> 
  glimpse()

# Normalisierung
scaled_data <- mpg |> 
  transmute(
    across(
      .cols = where(is.numeric),
      .fns = \(x) scale(x)[,1]
    )
  )

# Imputierung
(dframe <- tibble(
  group = c("a", "a", "a", "b", "b", "b"),
  x = c(3, 5, 4, NA, 4, 8),
  y = c(2, NA, 3, 1, 9, 7)
))

dframe |> 
  mutate(
    across(
      .cols = c(x, y),
      .fns = \(x) ifelse(
        test = is.na(x),
        yes = mean(x, na.rm = TRUE),
        no = x
      )
    )
  )

dframe |> 
  mutate(
    across(
      .cols = c(x, y),
      .fns = \(x) case_when(
        is.na(x) ~ mean(x, na.rm = TRUE),
        TRUE ~ x
      )
    )
  )

# Typos korrigieren
typo_dframe <- tribble(
  ~pre_test, ~post_test,
  "goud", "good",
  "medium", "good",
  "metium", "metium",
  "bad", "goud"
)

typo_dframe |> 
  mutate(
    across(
      .cols = everything(),
      .fns = \(x) case_when(
        str_detect(x, "goud") ~ str_replace(x, "goud", "good"),
        str_detect(x, "metium") ~ str_replace(x, "metium", "medium"),
        TRUE ~ x
      )
    )
  )