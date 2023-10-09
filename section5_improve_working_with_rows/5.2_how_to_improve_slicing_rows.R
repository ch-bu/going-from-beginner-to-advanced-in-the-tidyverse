# slice logic -------------------------------------------------------------

economics |> 
  rownames_to_column(var = "row_number") |> 
  slice(40, 53, 3)

economics |> 
  rownames_to_column(var = "row_number") |> 
  slice(-nrow(economics))

# slice_head / slice_tail ----------------------------------------

survey_results <- tribble(
  ~id,   ~name,      ~pre,  ~post,
  1,     "Test",     4,     4,
  2,     "Test",     6,     8,
  3,     "Millner",  2,     9,
  4,     "Josh",     4,     7,
  5,     "Bob",      3,     4
)

survey_results |> 
  filter(name != "Test")

survey_results |> 
  slice_head(n = 2)

survey_results |> 
  slice_tail(n = 3)

survey_results |> 
  slice_tail(n = nrow(survey_results) - 2)

# slice_max / slice_min ---------------------------------------------------

economics |> 
  select(date, unemploy) |> 
  arrange(desc(unemploy)) |> 
  filter(unemploy > 14847)

economics |> 
  slice_min(
    order_by = unemploy,
    prop = .05
  ) |> 
  select(date, unemploy)

# slice and group_by ------------------------------------------------------

highest_unemploy_per_month <- economics |> 
  mutate(year = year(date), 
         month = month(date, label = TRUE)) |> 
  group_by(year) |> 
  slice_max(
    order_by = unemploy,
    n = 1
  ) |> 
  ungroup()

highest_unemploy_per_month |> 
  count(month) |> 
  ggplot(aes(x = month, y = n)) +
  geom_col()

# bootstrapping with slice ------------------------------------------------

economics |> 
  slice_sample(prop = 1, replace = TRUE) |> 
  janitor::get_dupes()


bootstraps <- map(
  .x = 1:10000,
  .f = \(x) slice_sample(economics, prop = 1, replace = TRUE)
)

means <- map_dbl(bootstraps, \(x) mean(x$unemploy))

ggplot(NULL, aes(x = means)) +
  geom_histogram(fill = "grey80", color = "black")