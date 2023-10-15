running_races_anna <- tribble(
  ~year, ~race,              ~minutes,
  2010,   "half marathon",   110,
  2011,   "marathon",        230,
  2013,   "half marathon",   105,
  2016,   "10km",            50,
  2018,   "10km",            45,
  2018,   "half marathon",   100,
  2022,   "marathon",        210
)


# complete ----------------------------------------------------------------

running_races_anna |> 
  complete(year, race)

running_races_anna |> 
  complete(year = 2010:2022, race)

running_races_anna |> 
  complete(year = full_seq(year, 1), race)

running_races_anna |> 
  complete(
    year = full_seq(year, 1), 
    race = c(race, "ultra marathons")
  )

# expand ------------------------------------------------------------------

running_races_anna |> 
  expand(
    year = full_seq(year, 1), 
    race = c(race, "ultra marathons")
  )

# complete/expand with group_by -------------------------------------------

running_races_club <- tribble(
  ~year, ~runner,  ~race,             ~minutes,
  2012,  "Eva",     "half marathon",   109,
  2013,  "Eva",     "marathon",        260,
  2022,  "Eva",     "half marathon",   120,
  2018,  "John",    "10km",            51,
  2019,  "John",    "10km",            49,
  2020,  "John",    "10km",            50,
  2019,  "Leonie",  "half marathon",   45,
  2020,  "Leonie",  "10km",            45,
  2021,  "Leonie",  "half marathon",   102,
  2022,  "Leonie",  "marathon", 220
  )

running_races_club |> 
  group_by(runner) |> 
  complete(
    year = full_seq(year, 1), 
    race = c("10km", "half marathon", "marathon")) |> 
  ungroup()

# expand with nesting -----------------------------------------------------

running_races_club |> 
  expand(nesting(runner, race))


# crossing ----------------------------------------------------------------

crossing(
  year = 1905:2023,
  slams = c("Australien Open", "French Open",
            "Wimbledon", "US Open")
)


crossing(
  year = 2006:2023,
  races = c("Tokyo", "Boston", "Chicago",
            "London", "Berlin", "New York")
)