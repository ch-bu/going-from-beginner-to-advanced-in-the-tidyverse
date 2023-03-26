library(tidyverse)
library(janitor)

mpg_new <- read_csv("data/mpg_uppercase.csv") |> 
  clean_names() |> 
  select(manufacturer, model)

read_csv("data/mpg_uppercase.csv",
         name_repair = \(column) make_clean_names(column, case = "snake"),
         col_select = c("manufacturer", "model")) |> 
  glimpse()

