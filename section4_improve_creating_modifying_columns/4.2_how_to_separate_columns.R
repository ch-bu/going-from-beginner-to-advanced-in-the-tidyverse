

# Separate by Delimiter ---------------------------------------------------
tibble(
  variable = c("a-b", "a-d", "b-c", "d-e")
) %>%
  separate_wider_delim(
    cols = variable,
    delim = "-",
    names = c("a", "b"),
    cols_remove = FALSE
  )


# Separate by Position ----------------------------------------------------
tibble(
  variable = c("x1", "x2", "y1", "y2")
) %>%
  separate_wider_position(
    cols = variable,
    widths = c(first = 1, second = 1),
    cols_remove = FALSE
  )

tibble(
  variable = c("x_1", "x_2", "y-1", "y*2")
) %>%
  separate_wider_position(
    cols = variable,
    widths = c(first = 1, 1, second = 1),
    cols_remove = FALSE
  )


# Separate by Regex -------------------------------------------------------
tibble(
  variable = c("David Jude Heyworth Law", 
               "Elton Hercules John",
               "Angelina Jolie Voight", 
               "Jennifer Shrader Lawrence")
) |> 
  separate_wider_regex(
    cols = variable,
    patterns = c(first_name = "\\w+",
                 " .* ", 
                 last_name = "\\w+"),
    remove = FALSE
  )


tibble(
  variable = c("x -> 1",
               "y -> 2",
               "p-> 34")
) %>%
  extract(
    variable,
    into = c("letter", "number"),
    remove = FALSE,
    regex = "([a-z])(?: ?-> ?)(\\d+)?"
  )


df <- tibble(
  variable = c("x ->-> 1",
               "y -> 2",
               "p-> 34",
               "f 4")
)

df |> 
  extract(
  variable,
  into = c("letter", "number"),
  remove = FALSE,
  regex = "([a-z]) ?(?:->){0,} ?(\\d+)?"
)



df <- tibble(
  variable = c("x ->aslkdfj 1",
               "y-> 2",
               "p 34",
               "8")
)

df |> 
  extract(
    variable,
    into = c("letter", "number"),
    remove = FALSE,
    regex = "([a-z])? ?(?:->\\w*)? ?(\\d+)"
  )