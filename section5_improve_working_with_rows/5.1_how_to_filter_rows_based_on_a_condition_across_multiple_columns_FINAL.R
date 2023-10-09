df <- tibble(
  a = c(NA, 2, 3),
  b = c(NA, 4, 8),
  c = c(1, NA, 1)
)

df |> 
  filter(a >= 2 & is.na(c))


# if_any/if_all 💚 filter -------------------------------------------------

# <DFRAME> |> 
#   filter(
#     if_any(
#       .cols = <SELECTION OF COLUMNS>,
#       .fns  = <BEDINGUNG FUER JEDE SPALTE>
#     )
#   )

billboard |> 
  filter(
    if_any(
      .cols = contains("wk"),
      .fns  = \(x) x == 1
    )
  )

billboard |> 
  filter(
    if_all(
      .cols = contains("wk"),
      .fns  = \(x) x == 1
    )
  )

billboard |> 
  filter(
    if_all(
      .cols = matches("wk[1-5]$"),
      .fns = \(x) x <= 50
    )
  )

df <- tibble(
  item_name = c("a", "a", "b", "b"),
  group = c(1, NA, 1, 2),
  value1 = c(1, NA, 3, 4),
  value2 = c(4, NA, NA, 7)
)

df |> 
  filter(
    if_all(
      .cols = where(is.numeric),
      .fns = \(x) !is.na(x)
    )
  )


# if_any/if_all 💚 mutate -------------------------------------------------

billboard |> 
  mutate(
    top_song = case_when(
      if_any(
        .cols = contains("wk"),
        .fns = \(x) x == 1
      ) ~ "top song",
      TRUE ~ "no top song"
      )
    ) |> 
  select(artist, track, top_song)