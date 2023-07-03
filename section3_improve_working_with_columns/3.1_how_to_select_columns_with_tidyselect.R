# Solution ----------------------------------------------------------------

billboard |> 
  select(matches("\\d")) |> 
  glimpse()

anscombe |> 
  select(matches("^x\\d")) |> 
  glimpse()

billboard |> 
  select(matches("^wk\\d{1}$")) |> 
  glimpse()

anscombe |> 
  select(matches("^[xy][1-3]")) |> 
  glimpse()