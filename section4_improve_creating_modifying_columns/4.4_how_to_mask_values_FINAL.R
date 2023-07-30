ccards <- tibble(
  credit_numbers = c(
    36555224524299,
    36350489667466,
    36002887965170,
    5447552069207504,
    2221002654361034,
    5127699386148536)
)

# Masking beginning
ccards |> 
  mutate(
    credit_n_masked = str_replace(
      string = credit_numbers,
      pattern = "^\\d{10}",
      replacement = strrep("X", 10)
    )
  )

# Masking end
ccards |> 
  mutate(
    credit_n_masked = str_replace(
      string = credit_numbers,
      pattern = "\\d{10}$",
      replacement = strrep("X", 10)
    )
  )