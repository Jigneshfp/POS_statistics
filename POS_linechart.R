POS_summary <- POS_all %>% group_by(month) %>% summarize(average = mean(NO_of.trans.credit))
POS_summary$month <- factor(POS_summary$month, levels = c("jan", "feb", "march", "april", "may", "june", "july", "august", "sept", "oct", "nov"))
ggplot(POS_summary, aes(x = month, y = average)) + geom_point() + geom_line()
