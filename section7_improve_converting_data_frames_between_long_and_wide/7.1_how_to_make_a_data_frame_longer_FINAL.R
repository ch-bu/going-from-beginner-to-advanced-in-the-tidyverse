
running_data <- tribble(
  ~person, ~group,  ~`w-1`, ~`w-2`, ~`w-3`,
  "John",   "a",    4,       NA,       2,
  "Marie",  "a",    2,        7,       3,
  "Jane",   "b",    3,        8,       9,
  "Peter",  "b",    1,        3,       3
)

# Each variable forms a column
# Each observation forms a row
# Each type of observation unit is a table

# The physical layout is not linked to its semantics


# Column headers are values of one variable, not variable names -----------

running_data |> 
  pivot_longer(
    cols = `w-1`:`w-3`, 
    names_to = "week",
    values_to = "kilometer",
    names_prefix = "w-",
    names_transform = as.integer
  )

relig_income |> 
  pivot_longer(
    cols = "<$10k":"Don't know/refused",
    names_to = "income",
    values_to = "frequency"
  )

billboard |> 
  pivot_longer(
    cols = contains("wk"),
    names_to = "week",
    values_to = "position",
    names_prefix = "wk"
  )

# Multiple variables are stored in columns --------------------------------

anscombe |> 
  pivot_longer(
    cols = everything(),
    names_to = c(".value", "number"),
    names_pattern = "([xy])(\\d+)"
  ) |> 
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(vars(number))

# Multiple variables are stored in one column -----------------------------

who |> 
  pivot_longer(
    cols = "new_sp_m014":"newrel_f65",
    names_to = c("type", "gender", "age"),
    names_pattern = "new_?([a-z]{2,3})_([mf])(\\d+)"
  ) |> 
  mutate(
    age = case_when(
      str_length(age) == 2 ~ age,
      str_length(age) == 3 ~ str_replace(age, "(^.)", "\\1-"),
      str_length(age) == 4 ~ str_replace(age, "(^.{2})", "\\1-"),
      TRUE ~ age
    )
  )


# Variables are stored in both rows and columns ---------------------------


weather_data <- tribble(
  ~id,         ~year,   ~month,  ~element,  ~d1, ~d2,     ~d3, ~d4,   ~d5, ~d6,
  "MX17004",    2010,        1,   "tmax",   NA,   NA,      NA,  NA,    NA,  NA,
  "MX17004",    2010,        1,   "tmin",   NA,   NA,      NA,  NA,    NA,  NA,
  "MX17004",    2010,        2,   "tmax",   NA,   27.3,  24.1,  NA,    NA,  NA,
  "MX17004",    2010,        2,   "tmin",   NA,   14.4,  14.4,  NA,    NA,  NA,
  "MX17004",    2010,        3,   "tmax",   NA,   NA,      NA,  NA,  32.1,  NA,
  "MX17004",    2010,        3,   "tmin",   NA,   NA,      NA,  NA,  14.2,  NA,
  "MX17004",    2010,        4,   "tmax",   NA,   NA,      NA,  NA,    NA,  NA,
  "MX17004",    2010,        4,   "tmin",   NA,   NA,      NA,  NA,    NA,  NA,
  "MX17004",    2010,        5,   "tmax",   NA,   NA,      NA,  NA,    NA,  NA,
  "MX17004",    2010,        5,   "tmin",   NA,   NA,      NA,  NA,    NA,  NA,

)  %>%
  mutate(across(d1:d6, as.numeric))

weather_data |> 
  pivot_longer(
    cols = d1:d6,
    names_to = "day",
    values_to = "value",
    names_prefix = "d",
    names_transform = as.integer,
    values_drop_na = TRUE
  ) |>
  unite(
    col = date,
    year, month, day,
    sep = "-"
  ) |> 
  mutate(
    date = as.Date(date, format = "%Y-%m-%d")
  )