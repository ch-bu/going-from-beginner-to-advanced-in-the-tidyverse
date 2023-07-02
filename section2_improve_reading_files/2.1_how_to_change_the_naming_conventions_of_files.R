library(janitor)


# Solution ----------------------------------------------------------------
mpg_new <- read_csv("data/mpg_uppercase.csv",
                    name_repair = \(col) make_clean_names(
                      col, case = "upper_camel"
                    )) 

# Worked Example ----------------------------------------------------------
