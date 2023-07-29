# Separate by Delimiter ---------------------------------------------------
tibble(
  variable = c("a_b", "a_d", "b_c", "d_e")
) |> 
  separate_wider_delim(
    cols = variable,
    delim = "_",
    names = c("x", "y"),
    cols_remove = FALSE
  )

# Separate by Position ----------------------------------------------------
tibble(
  variable = c("x1", "x2", "y1", "y2")
) |> 
  separate_wider_position(
    cols = variable,
    widths = c(erste_spalte = 1, 
               zweite_spalte = 1),
    cols_remove = FALSE
  )


tibble(
  variable = c("x_1", "x_2", "y-1", "y*2")
) |> 
  separate_wider_position(
    cols = variable,
    widths = c(erste_spalte = 1, 
               1,
               zweite_spalte = 1),
    cols_remove = FALSE
  )


# Separate by Regex -------------------------------------------------------
tibble(
  variable = c("x1", "x2", "y1", "y2")
) |> separate_wider_regex(
  cols = variable,
  patterns = c(erste_spalte = "[xy]{1}",
               zweite_spalte = "\\d{1}$"),
  cols_remove = FALSE
)


tibble(
  variable = c("x_____1", "x_2", "y-1", "y*2")
) |> separate_wider_regex(
  cols = variable,
  patterns = c(erste_spalte = "[xy]{1}",
               "[-_*]+",
               zweite_spalte = "\\d{1}$"),
  cols_remove = FALSE
)

tibble(
  variable = c("David Jude Heyworth Law", 
               "Elton Hercules John",
               "Angelina Jolie Voight", 
               "Jennifer Shrader Lawrence")
) |> separate_wider_regex(
  cols = variable,
  patterns = c(first_name = "\\w+",
               "\\s\\w+\\s?\\w+\\s",
               last_name = "\\w+$"),
  cols_remove = FALSE
)


tibble(
  variable = c("x -> 1",
               "y -> 2",
               "p-> 34",
               "f 4")
) |> separate_wider_regex(
  cols = variable,
  patterns = c(letter = "\\w{1}",
               "\\s?(?:->)?\\s",
               number = "\\d+$"),
  cols_remove = FALSE
)



