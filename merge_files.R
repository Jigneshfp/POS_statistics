# list of all files
library(tidyverse)

filenames <- c("POS_jan.R", "POS_feb.R", "POS_march.R", "POS_april.R", "POS_may.R"
              , "POS_june.R", "POS_july.R", "POS_august.R", "POS_sept.R", "POS_oct.R", "POS_nov.R")

all_file <- lapply(filenames, source)

# making a list of dataframes.
all_dataframe <- list(POS_jan, POS_feb, POS_march, POS_april, POS_may, POS_june, POS_july, POS_august, POS_sept, POS_oct, POS_nov)

POS_all <- bind_rows(all_dataframe) # binds multiple data frames together by row.

