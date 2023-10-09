mpg |>
  group_by(manufacturer) |>
  summarise(
    mean_displ = mean(displ, na.rm = TRUE),
    mean_cty   = mean(cty, na.rm = TRUE),
  )



# Intro across ------------------------------------------------------------
# Replika
mpg |>
  group_by(manufacturer) |>
  summarise(
    across(
      .cols  = c("displ", "cty"),
      .fns   = \(x) mean(x, na.rm = TRUE),
      .names = "mean_{.col}"
    )
  )

# Mit einer Liste - mehr Variabilität
mpg |> 
  group_by(manufacturer) |>
  summarise(
    across(
      .cols  = c("displ", "cty"),
      .fns   = list(mean = mean, sd = sd),
      .names = "{.fn}_{.col}"
    )
  )

# Mit anonymer Funktion
mpg |> 
  group_by(manufacturer) |>
  summarise(
    across(
      .cols = c("displ", "cty"),
      .fns = list(
        mean = \(x) mean(x, na.rm = TRUE),
        sd   = \(x) var(x, na.rm = TRUE)
      ),
      .names = "{.fn}_{.col}"
    )
  )

# Kombination mit tidyselect
mpg |>
  group_by(manufacturer) |> 
  summarise(
    across(
      .cols = where(is.numeric),
      .fns = list(
        mean = mean, 
        sd = sd,
        median = median
      ),
      .names = "{.fn}_{.col}"
    )
  ) |>
  glimpse()




# How to calculate the number of distinct values across many colum --------
# Rebecca Barter
mpg |>
  summarise(
    across(
      .cols = everything(),
      .fns  = n_distinct
    )
  )



# across and mutate -------------------------------------------------------
mpg |> 
  mutate(
    across(
      .cols = where(is.character),
      .fns  = as_factor
    )
  ) |>
  select(where(is.factor) | where(is.character)) |>
  glimpse()


# change names -> new columns created
mpg |>
  mutate(
    across(
      .cols = where(is.character),
      .fns = as_factor,
      .names = "{.col}_as_factor"
    )
  ) |> 
  select(where(is.factor) | where(is.character)) |>
  glimpse()


# How to round
mpg |> 
  mutate(
    across(
      .cols = where(is.numeric),
      .fns = \(x) round(x, digits = 0)
    )
  ) |> 
  glimpse()


# How to normalise columns
scaled_columns <- mpg |> 
  transmute(
    across(
      .cols = where(is.numeric),
      .fns  = scale,
    )
  )

scaled_columns <- mpg |> 
  transmute(
    across(
      .cols = where(is.numeric),
      .fns = ~ scale(.)[, 1],
      .unpack = TRUE
    )
  )


scaled_columns |> 
  summarise(
    across(
      .cols = everything(),
      .fns  = list(mean = mean, sd = sd)
    )
  ) |> 
  glimpse()


# How to impute values across many columns
(dframe <- tibble(
  group = c("a", "a", "a", "b", "b", "b"),
  x = c(3, 5, 4, NA, 4, 8),
  y = c(2, NA, 3, 1, 9, 7)
))

dframe |>
  mutate(
    across(
      .cols = c(x, y), # or everything()
      .fns = \(x) {
        ifelse(
          test = is.na(x),
          yes = mean(x, na.rm = TRUE),
          no = x
        )
      }
    )
  )

dframe |>
  group_by(group) |> 
  mutate(
    across(
      .cols = c(x, y), # or everything()
      .fns = \(x) 
      case_when(
        is.na(x) ~ mean(x, na.rm = TRUE),
        TRUE ~ x
      )
    )
  ) |> 
  ungroup()


# How to replace characters across many columns
typo_dframe <- tribble(
  ~pre_test, ~post_test,
  "goud", "good",
  "medium", "good",
  "metium", "metium",
  "bad", "goud"
)

(typo_corrected <- typo_dframe |>
    mutate(
      across(
        .cols = everything(),
        .fns = \(x) case_when(
          str_detect(x, "goud") ~ str_replace(x, "goud", "good"),
          str_detect(x, "metium") ~ str_replace(x, "metium", "medium"),
          TRUE ~ x
        )
      )
    ))