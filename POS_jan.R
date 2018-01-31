# File: POS_jan.R
# Author : Jignesh Patel
# Desription: This code is written to clean the messy dataset from https://rbi.org.in/Scripts/ATMView.aspx
# about POS transcation details which will be used for further analysis.
#=========================================================================================================

#install and load required packages.
install.packages(c("dplyr", "stringr", "tidyr", "readxl"))
library(dplyr) 
library(stringr)
library(tidyr)
library(readxl)

#load dataset from ATM_jan.xls
ATM_jan <- read_xls("ATM_jan.xls")
index <- complete.cases(ATM_jan)
ATM_jan <- ATM_jan[index, ]

#subset data to features we wish to keep/use and rename the same.
POS_jan <- ATM_jan[, c(2,5,6,9,11,14,16)]
col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of.trans.credit", "amount_transc.credit", "NO_of.transc.debit", "amount.transc.debit")
colnames(POS_jan) <- col_names
POS_jan <- POS_jan %>% mutate(month = "jan") # adding new variable "month".

#convert character to #1 integer and #2 double.
int_col <- c(2,3,4,6)
double_col <- c(5,7)
POS_jan[, int_col] <- lapply(POS_jan[, int_col], as.integer)
POS_jan[, double_col] <- lapply(POS_jan[, double_col], as.double)


