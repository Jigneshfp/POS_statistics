# File: POS_dec.R
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

#load dataset from ATM_dec.xls
ATM_dec <- read_xlsx("ATM_dec.xlsx")
index <- complete.cases(ATM_dec)
ATM_dec <- ATM_dec[index, ]

#subset data to features we wish to keep/use and rename the same.
POS_dec <- ATM_dec[, c(2,5,6,9,11,14,16)]
col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of.trans.credit", "amount_transc.credit", "NO_of.transc.debit", "amount.transc.debit")
colnames(POS_dec) <- col_names
POS_dec <- POS_dec %>% mutate(month = "jan") # adding new variable "month".

#convert character to #1 integer and #2 double.
int_col <- c(2,3,4,6)
double_col <- c(5,7)
POS_dec[, int_col] <- lapply(POS_dec[, int_col], as.integer)
POS_dec[, double_col] <- lapply(POS_dec[, double_col], as.double)


