library(tidyverse)
library(readxl)
ATM_files <- list.files(pattern = "\\.XLSX$", ignore.case = TRUE) # Lists all files with .XLSX extension.
ATM_df <- list()
months <- sapply(ATM_files, function(x) {substr(x, 5, nchar(x)-5)} ) # Reads name of files as a string and saves it as a month name

# A function to clean ATM data set.
clean_atm_data <- function(file_name) {
  month_year = substr(file_name, 5, nchar(file_name)-5)
  df = read_xlsx(file_name)
  index = complete.cases(df)
  df <- as.data.frame(df[index, ])
  
  #subsets variables of interest using column index and assigns column names.
  df <- df[, c(2,5,6,9,11,14,16)]
  col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of.transc.credit", "amount_transc.credit", "NO_of.transc.debit", "amount_transc.debit")
  colnames(df) <- col_names
  df <- df %>% mutate(month_year)
 
   #converts data type of columns appropriately.
  int_col <- c(2,3,4,6)
  double_col <- c(5,7)
  df[, int_col] <- lapply(df[, int_col], as.integer) # converts to integer.
  df[, double_col] <- lapply(df[, double_col], as.double) # converts to double.
  ATM_df[[paste0("POS_",month_year)]] <<- df
}

 #apply clean_ATM_data function to all excel files.
lapply(ATM_files, clean_atm_data) %>% invisible()
POS_all <- bind_rows(ATM_df) %>% data.frame()# binds multiple data frames together by row.
POS_all$month_year <- factor(POS_all$month_year, levels = paste0(month.abb, "_", rep(16:17, c(12,12)))) # converts to factor.

POS_all <- POS_all %>% arrange(month_year)

#This is temp script.
