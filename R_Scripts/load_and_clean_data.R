# Install all required packages and load them into the environment
install.packages("dplyr")
library(dplyr)
library(readr)
install.packages("tidyverse")
library(tidyverse)
install.packages("data.table")
library(data.table)
library(filenamer)


load_behavioural_data <- function(

    pattern    = "*.csv",
    subdir      = "raw_data",
    package     = c("readr", "base", "dplyr", "data.table")
) {
 
  path <- here::here(subdir)
# read in file paths to get correct subject numbers/run numbers info
  file_names <- list.files(
    path = path,
    pattern = pattern,
    full.names = FALSE,
    recursive = TRUE
  )

  if (!file.exists(path)) {
    stop("Files not found at: ", path)
  }

else {
   # read all file content
  all_content <- file_names %>%
    lapply(read.table, header = T, sep = ",")
  
  # combine file content list and file name list
  all_lists <- mapply(c, all_content, file_names, SIMPLIFY = FALSE)
  
  # unlist all lists and change column name
  df <- rbindlist(all_lists, fill = T)
  }
  df
}

data <- load_behavioural_data()





load_behavioural_data_2 <- function(
  pattern    = "\\.csv$",
  subdir     = "raw_data"
) {
  path <- here::here(subdir)  # Standardize to data/raw_data
  
  file_names <- list.files(
    path       = path,
    pattern    = pattern,
    full.names = TRUE,    # Critical: full paths for reading
    recursive  = FALSE    # Usually not needed for flat folders
  )
  
  if (length(file_names) == 0) {
    stop("No CSV files found in: ", path)
  }
  
  # Read all and bind with source file column (tidyverse or data.table)
  df <- purrr::map_dfr(
    file_names,
    readr::read_csv,
    show_col_types = FALSE,
    .id = "source_file"   # Automatically adds file column
  )
  
  df
}

data_2 <- load_behavioural_data_2()











# read file paths
file.names <-list.files(path, pattern = ".csv", full.names = T, recursive = T)

# read all file content
all_content <- file.names %>%
  lapply(read.table, header = T, sep = ",")

# shorten file path to file name, then convert object to list
all_filenames <- file.names %>%
  basename() %>%
  as.list()

# combine file content list and file name list
all_lists <- mapply(c, all_content, all_filenames, SIMPLIFY = FALSE)

# unlist all lists and change column name
all_result <- rbindlist(all_lists, fill = T) 