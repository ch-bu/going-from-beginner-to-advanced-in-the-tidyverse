# map_vec · 1.0.0

# character, numeric, double
# boolean/logical

# factor, date, datetime

c(as.Date('2022-01-31'), 
  as.Date('2022-10-12')) |> 
  map_vec(
    .f = \(d) d %m+% months(1)
  ) 

1:100 |> 
  map_vec(
    .f = \(n) as.Date(ISOdate(n + 2023, 11, 12))
  )