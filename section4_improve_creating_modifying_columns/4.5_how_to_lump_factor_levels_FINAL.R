billboard %>%
  mutate(
    artist = fct_lump(f = artist, n = 10)
  ) |> 
  dplyr::filter(artist != "Other") |> 
  ggplot(aes(y = artist)) +
  geom_bar()


# fct_lump_min ---------------------------------------------------------
gss_cat |> 
  mutate(
    rincome = fct_lump_min(
      f = rincome,
      min = 1000
    )
  ) |> 
  ggplot(aes(y = rincome)) +
  geom_bar()


billboard |> 
  mutate(
    artist = fct_lump_min(
      f = artist,
      min = 3
    )
  )|> 
  dplyr::filter(artist != "Other") |> 
  ggplot(aes(y = artist)) +
  geom_bar()


# fct_lump_n --------------------------------------------------------------
gss_cat |> 
  mutate(
    rincome = fct_lump_n(
      f = rincome,
      n = 5
    )
  ) |> 
  ggplot(aes(y = rincome)) +
  geom_bar()


billboard |> 
  mutate(
    artist = fct_lump_n(
      f = artist,
      n = 4,
      ties.method = "max"
    )
  )|> 
  dplyr::filter(artist != "Other") |> 
  ggplot(aes(y = artist)) +
  geom_bar()

# fct_lump_prop -----------------------------------------------------------

# Sum: 21483
# Single value: 1283

gss_cat |> 
  mutate(
    rincome = fct_lump_prop(
      f = rincome,
      prop = .05
    )
  ) |> 
  ggplot(aes(y = rincome)) +
  geom_bar()

billboard |> 
  mutate(
    artist = fct_lump_prop(
      f = artist,
      prop = .01
    )
  )|> 
  dplyr::filter(artist != "Other") |> 
  ggplot(aes(y = artist)) +
  geom_bar()

# fct_lump_lowfreq --------------------------------------------------------

gss_cat |> 
  mutate(
    rincome = fct_lump_lowfreq(
      f = rincome
    )
  ) |> 
  ggplot(aes(y = fct_infreq(rincome))) +
  geom_bar()