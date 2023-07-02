library(janitor)


# Solution ----------------------------------------------------------------
mpg_samples <- map(1:40, \(id) slice_sample(mpg, n = 20))

# Create directories
dir_create(c("data/nested_folders",
             "data/nested_folders/first_nested_folder",
             "data/nested_folders/second_nested_folder"))
# First folder
iwalk(mpg_samples[1:20],
      \(x, i) write_csv(x,
                  paste0("data/nested_folders/first_nested_folder/", i, "_first.csv")))
# Second folder
iwalk(mpg_samples[21:40],
      \(x, i) write_csv(x,
                  paste0("data/nested_folders/second_nested_folder/", i, "_second.csv")))


# Get file paths
nested_csv_paths <- dir_ls(path = "data/nested_folders",
                           glob = "*.csv", type = "file",
                           recurse = TRUE)

# Read files
files_map_nested <- map(nested_csv_paths, \(file_path) 
                        read_csv(file_path,name_repair = tolower) |> 
                          mutate(file = file_path)) |> 
  list_rbind()


# Worked Example ----------------------------------------------------------

nested_csv_path <- dir_ls(
  path = "data/nested_folders",
  glob = "*.csv",
  type = "file",
  recurse = TRUE
)

file_map_nested <- map(
  .x = nested_csv_path,
  .f = \(file_path) read_csv(file_path) |> 
    mutate(file = file_path)
) |> 
  list_rbind()