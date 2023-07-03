
# Age, Item 1, Item 2, $dollars, Where do you come from?
#  23,      4,      8,       45,               "Germany"

the_date_frame |> 
  rename(
    age = Age,
    item_1 = `Item 1`
  )

mpg |> 
  rename_with(
    .fn = \(col) toupper(col),
    .cols = contains("m")
  ) |> 
  glimpse()

iris |> 
  rename_with(
    .fn = \(col) janitor::make_clean_names(col,
                                           case = "snake"),
    .cols = starts_with("s")
  ) |> 
  glimpse()

mpg |> 
  rename_with(
    .fn = \(col) gsub("e", "_", col)
  ) |> 
  glimpse()

anscombe |> 
  rename_with(
    .fn = \(col) str_replace(
      col,
      pattern = "(\\d+)",
      replacement = "_\\1"
    )
  ) |> 
  glimpse()

anscombe |> 
  rename_with(
    .fn = \(col) str_replace(
      col,
      pattern = "(y)([12])",
      replacement = "\\1psilon\\2_"
    )
  ) |> 
  glimpse()

iris |> 
  rename_with(
    .fn = \(col) str_replace(
      col,
      "\\.",
      "_"
    ),
    .cols = matches("[Ww]idth$")
  ) |> 
  glimpse()