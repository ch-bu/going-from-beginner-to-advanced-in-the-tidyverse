# Separate by Delimiter ---------------------------------------------------
tibble(
  variable = c("a_b", "a_d", "b_c", "d_e")
) 

# Separate by Position ----------------------------------------------------
tibble(
  variable = c("x1", "x2", "y1", "y2")
) 


tibble(
  variable = c("x_1", "x_2", "y-1", "y*2")
) 

# Separate by Regex -------------------------------------------------------
tibble(
  variable = c("x1", "x2", "y1", "y2")
) 


tibble(
  variable = c("x_1", "x_2", "y-1", "y*2")
) 

tibble(
  variable = c("David Jude Heyworth Law", 
               "Elton Hercules John",
               "Angelina Jolie Voight", 
               "Jennifer Shrader Lawrence")
) 


tibble(
  variable = c("x -> 1",
               "y -> 2",
               "p-> 34",
               "f 4")
) 



