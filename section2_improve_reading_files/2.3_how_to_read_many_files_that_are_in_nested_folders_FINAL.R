library(janitor)


# Solution ----------------------------------------------------------------
library(fs) # install.packages("fs")

# Create dir
dir_create(c("data/many_files"))
mpg_samples <- map(1:25, \(x) slice_sample(mpg, n = 20))
iwalk(mpg_samples, \(f, i) write_csv(f, paste0("data/many_files/", i, ".csv")))

# Get access to the file paths
file_paths <- list.files(path = "data/many_files", pattern = "csv",
                         full.names = TRUE)

file_paths2 <- dir_ls(path = "data/many_files", glob = "*.csv",
                      type = "file")


# Read in all the files into R
my_csv_files <- read_csv(file_paths)

# Include file path information
files_map <- map(file_paths, \(file_path) read_csv(file_path) |> 
                   mutate(file = file_path)) |> 
  list_rbind()


# Worked Example ----------------------------------------------------------

file_paths2 <- dir_ls(path = "data/many_files", glob = "*.csv",
                      type = "file")

# Read in all the files into R
my_csv_files <- read_csv(file_paths)

# Include file path information
files_map <- map(file_paths, \(file_path) read_csv(file_path) |> 
                   mutate(file = file_path)) |> 
  list_rbind()
