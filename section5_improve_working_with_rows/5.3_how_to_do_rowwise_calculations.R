dframe <- tibble(
  name = c("Jakob", "Eliud", "Jamal", "Emily"),
  first = c(1, 4, 7, 10),
  second = c(2, 5, 8,11),
  third = c(3, 6, 9, 12)
)


# rowwise -----------------------------------------------------------------


# calculating proportions -------------------------------------------------

df <- tibble(
  name = c("Sabrina", "Robert", "Christina"),
  cookies_week1 = c(2, 1, 2),
  cookies_week2 = c(3, 2, 2),
  cookies_week3 = c(0, 2, 1)
)

# What if you care for speed ----------------------------------------------
