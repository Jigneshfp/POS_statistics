
#load and install required packages.
library(tidyverse)

# summarising number of POS over months.
POS_summary1 <- POS_all %>% gather(POS_type, Total_POS, c(POS_online, POS_offline)) %>% 
  group_by(month, POS_type) %>% summarize(avg_POS = mean(Total_POS))

POS_summary1$month <- factor(POS_summary1$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov", "dec"))

# plot for average number of POS over months. 
g1 <- ggplot(POS_summary1, aes(x = month, y = avg_POS, col = POS_type, group = POS_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1)+
  labs(title = "Monthly average POS deployed", 
       subtitle = "Jan - Dec 2017", 
       x = "Month", 
       y = "Number of POS(avg.)", 
       caption = "RBI-database") + 
  scale_color_discrete(name = "Type of POS", 
                       labels = c("POS online","POS offline"), 
                       guide = guide_legend(reverse = TRUE)) +
  scale_y_continuous(breaks = seq(0, 60000, 10000), 
                     labels = function(x) paste0(x/1000, "K")) +
theme(plot.title = element_text(hjust = 0.5), 
      plot.subtitle = element_text(hjust = 0.5), 
      axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

g1 

#summarising avg. amount of credid/debit over months.
POS_summary2 <- POS_all %>% gather(Amount_type, Total_amount, c(amount_transc.debit, amount_transc.credit)) %>% 
  group_by(month, Amount_type) %>% summarize(avg_amount = mean(Total_amount))
POS_summary2$month <- factor(POS_summary2$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov", "dec"))

# plot for avg. amount of credi/debit-card transaction over months.
g2 <- ggplot(POS_summary2, aes(x = month, y = avg_amount, col = Amount_type, group = Amount_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1) +
  labs(title = "Monthly average amount of debit/credit", 
       subtitle = "Jan - Dec 2017",
       x = "Month",
       y = "credit/debit amount(avg.)", 
       caption = "RBI-database") +
  scale_y_continuous(breaks = seq(5000, 10000, 1000),labels =  function(x) {paste0(x/1000, "K")}) + 
  scale_color_discrete(name = "Type of amount",
                       labels = c("Debitcard amount", "Creditcard amount"), 
                       guide = guide_legend(reverse = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
g2

#summarizing avg. number of transaction using credit/debit-card over months.
POS_summary3 <- POS_all %>% gather(Transc_type, Total_no_transc, c(NO_of.transc.debit, NO_of.transc.credit)) %>%
  group_by(month, Transc_type) %>% summarize(avg_NO.of.transc = mean(Total_no_transc))
POS_summary3$month <- factor(POS_summary3$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov", "dec"))

# plot for avg. number of transction using credit/debit-card over months.
g3 <- ggplot(POS_summary3, aes(x = month, y = avg_NO.of.transc, col = Transc_type, group = Transc_type)) +
  geom_line(size = 1) + geom_point(size = 1, shape = 16, fill = 1, color = 1) +
  labs(title = "Monthly average number of debit/credit-card transction", 
       subtitle = "Jan - Dec 2017",
       x = "Month",
       y = "Number of transaction(avg)", 
       caption = "RBI-database") +
  scale_y_continuous(breaks = seq(5000, 10000, 1000),labels =  function(x) {paste0(x/1000, "K")}) + 
  scale_color_discrete(name = "Type of transaction",
                       labels = c("Debitcard transaction", "Creditcard transaction"), 
                       guide = guide_legend(reverse = TRUE)) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
g3

  

