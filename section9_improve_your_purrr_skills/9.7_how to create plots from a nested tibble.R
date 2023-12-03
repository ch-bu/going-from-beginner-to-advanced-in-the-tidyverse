
gss_cat |> 
  ggplot(aes(x = tvhours)) +
  geom_histogram() +
  facet_wrap(vars(marital))

# Nested example ----------------------------------------------------------

# Patchwork plots ---------------------------------------------------------

# patchworked plots within a nested data frame ----------------------------
