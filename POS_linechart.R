library(tidyverse)
par(mfrow = c(2,2))
POS_summary1 <- POS_all %>% gather(POS_type, Total_POS, c(POS_online, POS_offline)) %>% 
  group_by(month, POS_type) %>% summarize(average = mean(Total_POS))
POS_summary2 <- POS_all %>% gather(Amount_type, Total_amount, c(amount.transc.debit, amount_transc.credit)) %>% 
  group_by(month, Amount_type) %>% summarize(avg_amount = mean(Total_amount))
POS_summary3 <- POS_all %>% gather(Transc_type, Total_no_transc, c(NO_of.transc.debit, NO_of.transc.credit)) %>%
  group_by(month, Transc_type) %>% summarize(avg_NO.of.transc = mean(Total_no_transc))

POS_summary1$month <- factor(POS_summary1$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov"))
POS_summary2$month <- factor(POS_summary2$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov"))
POS_summary3$month <- factor(POS_summary3$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov"))

ggplot(POS_summary1, aes(x = month, y = average, group = POS_type)) + geom_point() + geom_line()
ggplot(POS_summary2, aes(x = month, y = avg_amount, group = Amount_type)) + geom_point() + geom_line()
ggplot(POS_summary3, aes(x = month, y = avg_NO.of.transc, group = Transc_type)) + geom_point() + geom_line()

