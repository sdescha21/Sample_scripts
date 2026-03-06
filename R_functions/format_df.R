fix_df_format <- function(df){
    new_data <- df %>%
    separate(V1, c('subj', 'subj_ID', 'run', 'task')) %>% 
    select(-c(subj, participant, Group_ID)) %>%
    new_data$Response.rt_ms <- new_data$Response.rt*1000

 
}