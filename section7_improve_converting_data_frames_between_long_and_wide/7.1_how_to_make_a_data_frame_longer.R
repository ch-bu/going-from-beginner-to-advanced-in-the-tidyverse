
running_data <- tribble(
  ~person, ~group,  ~`w-1`, ~`w-2`, ~`w-3`,
  "John",   "a",    4,       NA,       2,
  "Marie",  "a",    2,        7,       3,
  "Jane",   "b",    3,        8,       9,
  "Peter",  "b",    1,        3,       3
)


# Column headers are values of one variable, not variable names -----------


# Multiple variables are stored in columns --------------------------------


# Multiple variables are stored in one column -----------------------------


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

