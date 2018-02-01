# File: POS_feb.R
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

#load dataset from ATM_feb.xlsx
ATM_feb <- read_xlsx("ATM_feb.xlsx")
index <- complete.cases(ATM_feb)
ATM_feb <- as.data.frame(ATM_feb[index, ])

#subset data to features we wish to keep/use and rename the same.
POS_feb <- ATM_feb[, c(2,5,6,9,11,14,16)]
col_names <- c("Bank_name", "POS_online", "POS_offline", "NO_of.trans.credit", "amount_transc.credit", "NO_of.transc.debit", "amount.transc.debit")
colnames(POS_feb) <- col_names
POS_feb <- POS_feb %>% mutate(month = "feb") # adding new column "month".

#convert character to #1 integer and #2 double.
int_col <- c(2,3,4,6)
double_col <- c(5,7)
POS_feb[, int_col] <- lapply(POS_feb[, int_col], as.integer)
POS_feb[, double_col] <- lapply(POS_feb[, double_col], as.double)


