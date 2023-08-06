msleep %>%
  filter(name %in% c("Cow", "Dog", "Tiger", 
                     "Chimpanzee")) |> 
  ggplot(aes(x = name, y = sleep_total)) +
  geom_col()

