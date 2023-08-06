msleep_factor <- msleep %>%
  filter(name %in% c("Cow", "Dog", "Tiger", 
                     "Chimpanzee")) |> 
  mutate(
    name = as.factor(name)
  )

msleep_factor |> 
  ggplot(aes(x = name, y = sleep_total)) +
  geom_col()



# fct_relevel --------------------------------------------------------------
msleep_factor |> 
  mutate(
    name = fct_relevel(
      .f = name,
      "Tiger", "Cow",
      after = 1
    )
  ) |>
  ggplot(aes(x = name, y = sleep_total)) +
  geom_col()


# fct_infreq --------------------------------------------------------------

msleep_factor |> 
  count(name)

mpg |> 
  count(manufacturer, sort = TRUE)

mpg |> 
  mutate(
    manufacturer = as.factor(manufacturer) |>
      fct_infreq() |> fct_rev()
  ) |>
  ggplot(aes(x = manufacturer)) +
  geom_bar() +
  scale_x_discrete(guide = guide_axis(
    n.dodge = 2
  ))



# fct_reorder -------------------------------------------------------------

msleep_factor |> 
  select(name, sleep_total) |> 
  mutate(
    name = as.factor(name) |> 
      fct_reorder(.x = sleep_total,
                  .desc = TRUE)
  ) |> 
  ggplot(aes(x = name, y = sleep_total)) +
  geom_col()

mpg |> 
  mutate(
    manufacturer = fct_reorder(
      .f = manufacturer,
      .x = displ,
      .fun = \(x) max(x) - min(x)
    )
  ) |> 
  ggplot(aes(x = displ, y = manufacturer)) +
  geom_boxplot() #+
  # stat_summary(geom = "point", fun = "mean", color = "blue") +
  # stat_summary(geom = "line", fun = "mean", color = "blue", group = 1)



# fct_reorder2 ------------------------------------------------------------
marital_status_per_age <- gss_cat |> 
  count(age, marital) |> 
  group_by(age) |> 
  mutate(
    prop = n / sum(n)
  ) |> 
  ungroup() |> 
  drop_na(age)

marital_status_per_age |> 
  mutate(
    marital = fct_reorder2(
      .f = marital,
      .x = age,
      .y = prop,
      .fun = first2
    )
  ) |> 
  ggplot(aes(x = age, y = prop,
             color = marital)) + 
  stat_summary(geom = "line", fun = mean)


marital_status_per_age |> 
  group_by(marital) |> 
  slice_max(age) |> 
  ungroup() 