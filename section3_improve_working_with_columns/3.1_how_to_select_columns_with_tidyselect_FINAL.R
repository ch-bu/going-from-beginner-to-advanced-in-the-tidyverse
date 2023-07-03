# Solution ----------------------------------------------------------------

mpg |> 
  select(cyl, hwy, everything()) |> 
  glimpse()

mpg |> 
  select(!last_col(2)) |> 
  glimpse()

mpg |> 
  select(ends_with(c("l", "r"))) |> 
  glimpse()

billboard |> 
  select(starts_with("wk")) |> 
  glimpse()

mpg |> 
  select(contains("t")) |> 
  glimpse()

mpg |> 
  rename(Manufacturer = manufacturer) |> 
  select(contains("m", ignore.case = FALSE)) |> 
  glimpse()

billboard |> 
  select(num_range("wk", 1:15)) |> 
  glimpse()

anscombe |> 
  select(num_range("x", 1:2)) |> 
  glimpse()

billboard |> 
  select(where(is.character)) |> 
  glimpse()

billboard |> 
  select(where(is.character) & contains("k"))
