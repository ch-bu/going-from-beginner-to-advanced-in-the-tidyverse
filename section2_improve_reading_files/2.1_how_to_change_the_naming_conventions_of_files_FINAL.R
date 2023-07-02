library(janitor)


# Solution ----------------------------------------------------------------
mpg_new <- read_csv("data/mpg_uppercase.csv",
                    name_repair = \(col) make_clean_names(
                      col, case = "upper_camel"
                    )) 

# Worked Example ----------------------------------------------------------
read_csv("data/mpg_uppercase.csv") |> 
  clean_names() |> 
  glimpse()

read_csv("data/mpg_uppercase.csv",
         name_repair = \(col) make_clean_names(
           col, case = "big_camel"
         )) |> 
  glimpse()

c("A1", "B2", "MY-HOUSE") |> make_clean_names()