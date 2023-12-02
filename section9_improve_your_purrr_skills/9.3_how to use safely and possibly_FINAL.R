

# safely ------------------------------------------------------------------
# create a version of .f that 
# returns a list
# - result
# - error

safe_log <- safely(log,
                   otherwise = NA)

log_res <- list(2, 3, "A") |> 
  map(
    .f = \(x) safe_log(x)
  )

log_res |> 
  map_dbl(
    .f = \(x) x$result
  )

# possibly ----------------------------------------------------------------
# modifies .f so that it returns
# a default value

log_possibly <- possibly(log,
                         otherwise = 99)

list(2, 3, "A") |> 
  map_dbl(
    .f = \(x) log_possibly(x)
  )
