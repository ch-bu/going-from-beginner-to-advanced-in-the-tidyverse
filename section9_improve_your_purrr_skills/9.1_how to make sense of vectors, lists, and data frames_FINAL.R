


# Vectors -----------------------------------------------------------------

# coercion
# logical < integer < numeric < complex < character < list

# Lists -------------------------------------------------------------------

my_list <- list(
  a = 3,
  b = "some text",
  c = list(
    x = c(4, 5, 6)
  ),
  c(TRUE, FALSE)
)

list(
  c = list(
    x = list(
      list(
        c(1, 2, 3)
      )
    )
  )
)

# Data Frames -------------------------------------------------------------

my_data_frame <- tibble(
  a = c(1, 3, 4),
  b = c("A", "few", "words"),
  c = list(a = 3, b = TRUE, c = c(3, 7))
)



# for loops ---------------------------------------------------------------

.input <- c(2, 4, 6)
output <- vector(mode = "numeric",
                 length = length(length(.input)))

for (i in seq_along(.input)) {
  output[[i]] <- .input[[i]]^2
}


map(.x = .input, .f = \(x) x^2)