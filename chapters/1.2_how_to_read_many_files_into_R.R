library(tidyverse)
library(fs) # install.packages("fs")


# First example -----------------------------------------------------------
dir_create(c("data/many_files"))
mpg_samples <- map(1:25, ~ slice_sample(mpg, n = 20))
iwalk(mpg_samples, ~ write_csv(., paste0("data/many_files/", .y, ".csv")))

file_paths <- list.files(
  path = "data/many_files",
  pattern = "csv",
  full.names = TRUE
)

my_csv_files <- read_csv(file_paths)

files_map <- map(file_paths, \(file_path) read_csv(file_path) |> 
                   mutate(file = file_path)) |> 
  list_rbind()


# How to handle a messy data set ------------------------------------------
mpg_samples <- map(1:10, ~ slice_sample(mpg, n = 20))

inconsistent_dframes <- map(mpg_samples,
                            ~ janitor::clean_names(dat = .x, case = "random")) |> 
                        map(~ .x[sample(1:length(.x), sample(1:length(.x), 1))])

map(inconsistent_dframes, ~ colnames(.x)) %>%
  head

dir_create(c("data/messy_files"))
iwalk(inconsistent_dframes,
      ~ write_csv(.x, paste0("data/messy_files/", .y, ".csv")))

messy_csv_paths <- dir_ls(path = "data/messy_files",
                          glob = "*.csv", type = "file")

files_map_messy <- map(messy_csv_paths, \(file_path) read_csv(file_path,
                                                              name_repair = tolower) |> 
                         mutate(file = file_path)) |> 
  list_rbind()



# How to handle data sets that are stored in multiple folders -------------
mpg_samples <- map(1:40, ~ slice_sample(mpg, n = 20))
# Create directories
dir_create(c("data/nested_folders",
             "data/nested_folders/first_nested_folder",
             "data/nested_folders/second_nested_folder"))
# First folder
iwalk(mpg_samples[1:20],
      ~ write_csv(.x,
                  paste0("data/nested_folders/first_nested_folder/", .y, "_first.csv")))
# Second folder
iwalk(mpg_samples[21:40],
      ~ write_csv(.x,
                  paste0("data/nested_folders/second_nested_folder/", .y, "_second.csv")))


nested_csv_paths <- dir_ls(path = "data/nested_folders",
                          glob = "*.csv", type = "file",
                          recurse = TRUE)

files_map_nested <- map(nested_csv_paths, \(file_path) read_csv(file_path,
                                                              name_repair = tolower) |> 
                         mutate(file = file_path)) |> 
  list_rbind()