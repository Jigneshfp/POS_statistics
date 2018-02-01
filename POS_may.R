# File: POS_may.R
# Author : Jignesh Patel
# Desription: This code is written to clean the messy dataset from https://rbi.org.in/Scripts/ATMView.aspx
# about POS transcation details which will be used for further analysis.
#=========================================================================================================

#install and load required packages.
#install.packages(c("dplyr", "stringr", "tidyr", "readxl"))
library(dplyr) 
library(stringr)
library(tidyr)
library(readxl)

#load dataset from ATM_may.xlsx
ATM_may <- read_xlsx("ATM_may.xlsx")
index <- complete.cases(ATM_may)
ATM_may <- as.data.frame(ATM_may[index, ])

#subset data to features we wish to keep/use and rename the same.
POS_may <- ATM_may[, c(2,5,6,9,11,14,16)]
col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of.trans.credit", "amount_transc.credit", "NO_of.transc.debit", "amount.transc.debit")
colnames(POS_may) <- col_names
POS_may <- POS_may %>% mutate(month = "may") # adding new column "month".

#convert character to #1 integer and #2 double.
int_col <- c(2,3,4,6)
double_col <- c(5,7)
POS_may[, int_col] <- lapply(POS_may[, int_col], as.integer)
POS_may[, double_col] <- lapply(POS_may[, double_col], as.double)


