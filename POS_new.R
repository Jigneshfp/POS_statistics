#installs packages if not installed
install.packages("tidyverse")
install.packages("readxl")

# loads the packages
library(tidyverse)
library(readxl) 
ATM_files <- list.files(pattern = "\\.XLSX$", ignore.case = TRUE) # Lists all files with .XLSX/.xlsx extension.
ATM_df <- list()
months <- sapply(ATM_files, function(x) {substr(x, 5, nchar(x)-5)} ) 

# A function to clean ATM data set.
clean_atm_data <- function(file_name) {
  month_year = substr(file_name, 5, nchar(file_name)-5)
  df = read_xlsx(file_name) # Reads .xlsx/.XLSX file
  index = complete.cases(df) 
  df <- as.data.frame(df[index, ]) # keeps only complete rows
  
  #subsets variables of interest using column index and assigns column names.
  df <- df[, c(2,5,6,9,11,14,16)]
  col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of_transc_credit", 
                 "amount_transc_credit", "NO_of_transc_debit", "amount_transc_debit")
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
POS_all <- bind_rows(ATM_df) %>% data.frame()# binds(merges) multiple data frames together by row.
POS_all$month_year <- factor(POS_all$month_year, levels = paste0(month.abb, "_", rep(16:17, c(12,12)))) # converts to factor.

POS_all <- POS_all %>% arrange(month_year)

# summarising number of POS over months
POS_summary1 <- POS_all %>% gather(POS_type, Total_POS, c(POS_online, POS_offline)) %>% 
  group_by(month_year, POS_type) %>% summarize(avg_POS = mean(Total_POS))

# plot for average number of POS over months
g1 <- ggplot(POS_summary1, aes(x = month_year, y = avg_POS, col = POS_type, group = POS_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1)+
  labs(title = "Monthly average number of POS deployed", 
       subtitle = "2016 - 2017", 
       x = "Month_year", 
       y = "Avg. number of POS", 
       caption = "RBI-database") + 
  scale_color_discrete(name = "Type of POS", 
                       labels = c("Offline","Online"), 
                       guide = guide_legend(reverse = TRUE)) +
  scale_y_continuous(breaks = seq(0, 60000, 10000), 
                     labels = function(x) paste0(x/1000, "K")) +
  theme(plot.title = element_text(hjust = 0.5), 
        plot.subtitle = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))

#summarising avg. amount of credid/debit over months
POS_summary2 <- POS_all %>% gather(Amount_type, Total_amount, c(amount_transc_debit, amount_transc_credit)) %>% 
  group_by(month_year, Amount_type) %>% summarize(avg_amount = mean(Total_amount))

# plot for avg. amount of credi/debit-card transaction over months
g2 <- ggplot(POS_summary2, aes(x = month_year, y = avg_amount, col = Amount_type, group = Amount_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1) +
  labs(title = "Monthly average amount of transactions by debit/credit-card", 
       subtitle = "2016 - 2017",
       x = "Month_year",
       y = "Avg. amount of transaction(Rs. Milions)", 
       caption = "RBI-database") +
  scale_y_continuous(breaks = seq(5000, 10000, 1000),labels =  function(x) {paste0(x/1000, "K")}) + 
  scale_color_discrete(name = "Type of transaction",
                       labels = c("By creditcard", "By debitcard"), 
                       guide = guide_legend(reverse = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))

#summarizing avg. number of transaction using credit/debit-card over months
POS_summary3 <- POS_all %>% gather(Transc_type, Total_no_transc, c(NO_of_transc_debit, NO_of_transc_credit)) %>%
  group_by(month_year, Transc_type) %>% summarize(avg_NO_of_transc = mean(Total_no_transc))

# plot for avg. number of transction using credit/debit-card over months
g3 <- ggplot(POS_summary3, aes(x = month_year, y = avg_NO_of_transc, col = Transc_type, group = Transc_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1) +
  labs(title = "Monthly average number of transctions by credit/debit-card", 
       subtitle = "2016 - 2017",
       x = "Month_year",
       y = "Avg. number of transaction", 
       caption = "RBI-database") +
  scale_y_continuous(breaks = seq(1000000, 8000000, 1000000),labels =  function(x) {paste0(x/1000, "K")}) + 
  scale_color_discrete(name = "Type of transaction",
                       labels = c("By creditcard", "By debitcard"), 
                       guide = guide_legend(reverse = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))

g1 # line chart for monthly average number of POS deployed.
g2 # line chart for monthly average amount of transactions by debit/credit-card.
g3 # line chart for montly averarge nmber of transcations by debit/credit-card.
