

load_behavioural_data <- function(

    pattern    = "*.csv",
    subdir      = "raw_data",
    package     = c("readr", "base", "dplyr")
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
  
}




load_behavioural_data_2 <- function(pattern="\\.csv$") {
  
  path = "C:/Users/steph/Documents/Documents/PhD SCSD/THESIS/Behavioural_data_scanner/data_files/complete_datafiles/Matched_subjects_TONE"
  
  file_names <- list.files(
    path       = path,
    pattern    = pattern,
    full.names = TRUE,    # Critical: full paths for reading
    recursive  = FALSE    # Usually not needed for flat folders
  )
  
  # read all file content
  all_content <- file_names %>%
    lapply(read.table, header = T, sep = ",") #faster than read_csv
  
  # shorten file path to file name, then convert object to list
  all_filenames <- file_names %>%
    basename() %>%
    as.list()
  
  df <- mapply(c, all_content, all_filenames, SIMPLIFY = FALSE) %>% 
    rbindlist(., fill = T) 
  
  return(df)
}