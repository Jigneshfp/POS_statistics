# Description: This code is written to clean all 10 datasets for each month
# and then saving them with appropiate names.

filename <- "POS_feb.R"
months <- c("march","april", "may", "june", "july", "august", "sept", "oct", "nov", "dec")  # will be used later to give names to files.
replace_month <- lapply(months, function(x) {a = readLines(filename) 
                                             z = gsub("feb", x, a )}) # read all lines from file "POS_feb.R".


for(i in 1:length(replace_month)) {
  write(replace_month[[i]], file = paste0("POS_", months[i], ".R"))  # write data from each character string.
  }


