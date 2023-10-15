# How to use ‘pivot_wider ́  ----------------------------------------------

fish_encounters |> 
  pivot_wider(
    id_cols = fish,
    names_from = station,
    values_from = seen,
    # names_prefix = "station_",
    names_glue = "station_{station}"
  )

# How to use pivot_wider to calculate ratios/percentages ------------------

us_rent_income |> 
  select(-moe) |> 
  mutate(
    estimate = case_when(
      variable == "income" ~ estimate,
      variable == "rent" ~ estimate * 12
    ),
    lead_estimate = lead(estimate),
    rent_percentage = (lead_estimate / estimate) * 100
  )

us_rent_income |> 
  pivot_wider(
    id_cols = c(GEOID, NAME),
    names_from = variable,
    values_from = "estimate"
  ) |> 
  mutate(
    rent = rent * 12,
    percentage_of_rent = (rent / income) * 100
  )

# How to use pivot_wider to create tables of summary statistics  ----------

means_diamonds <- diamonds |> 
  group_by(cut, color) |> 
  summarise(mean = mean(price)) |> 
  ungroup()

means_diamonds |> 
  pivot_wider(
    id_cols = cut,
    names_from = color,
    values_from = mean,
    names_prefix = "mean_"
  )

# How to make data frames wider for use in other software tools -----------

runners_data <- tibble(
  id   = as.numeric(gl(6, 2)),
  group = c(rep("treatment", 6), rep("control", 6)),
  measurement = c(rep(c("pre", "post"), 6)),
  speed = rnorm(12, mean = 12, sd = 0.5),
  cadence = rnorm(12, mean = 160, 3)
)

runners_data |> 
  pivot_wider(
    id_cols = c(id, group),
    names_from = measurement,
    values_from = c(speed, cadence)
  )

# How to use pivot_wider to one-hot encode a factor -----------------------

sugar_in_fruits_per_100g <- tribble(
  ~id,  ~fruit,  ~sugar_level,
  1,    "pineapple", 10,
  2,    "watermelon", 6,
  3,    "banana", 12,
  4,    "grape", 16
)

sugar_in_fruits_per_100g |> 
  pivot_wider(
    names_from = fruit,
    values_from = fruit,
    values_fn = \(x) as.numeric(!is.na(x)),
    values_fill = 0
  )



# How to deal with multiple variable names stored in a column -------------

overnight_stays <- read_csv("data/etrm_03h_2.csv")

overnight_stays |> 
  pivot_longer(
    cols = matches("\\d{4}-\\d{2,}"),
    names_to = "date",
    values_to = "value"
  ) |> 
  pivot_wider(
    names_from = variable,
    values_from = value
  ) |> 
  mutate(
    date = ym(date)
  ) |> 
  ggplot(aes(x = date, y = Pernoctaciones)) +
  geom_line()

# How to pivot_wider without an id column ---------------------------------

contacts <- tribble(
  ~field, ~value,
  "name", "Jiena McLellan",
  "company", "Toyota",
  "name", "John Smith",
  "company", "google",
  "email", "john@google.com",
  "name", "Huxley Ratcliffe"
)

contacts |> 
  mutate(
    id = cumsum(field == "name")
  ) |> 
  pivot_wider(
    id_cols = id,
    names_from = field,
    values_from = value
  )

