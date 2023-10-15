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



# expand ------------------------------------------------------------------



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


# expand with nesting -----------------------------------------------------



# crossing ----------------------------------------------------------------

