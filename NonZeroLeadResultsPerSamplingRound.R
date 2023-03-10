library(tidyverse)

samples <- read_csv("C:\\Users\\JohnsonN35\\Downloads\\FIIP_CombinedLabsWorkbookTrimmed_to221110.csv", skip = 5)

non_zero_lead_results <- samples %>% filter(analyte_name == 'Lead, Total') %>% filter (DEH_ResultNum > 0)

sampling_round_levels <- c("1", "2", "3", "3.5", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14/QR0", "15/QR1", "16/QR2")

sampling_round_fac <- factor(non_zero_lead_results$SamplingRound, levels = sampling_round_levels)

ggplot(data = non_zero_lead_results) + 
  geom_point(mapping = aes(x = sampling_round_fac, y = DEH_ResultNum)) + 
  geom_hline(mapping = aes(yintercept = 0.015), color = "red", linewidth = 1, linetype = 2) + 
  labs(y = "Lead Results (mg/L) > 0, n = 47", x = "Sampling Round", title = "Non-Zero Lead Results in mg/L per Sampling Round") + 
  geom_text(mapping = aes(x = 1, y = 0.015, label = "0.015 MCL", hjust = 0, vjust = -1), color = "red") + 
  geom_text(data = subset(non_zero_lead_results, DEH_ResultNum >= 0.015), mapping = aes(x = SamplingRound, y = DEH_ResultNum, label = SampledAddress_USPS), hjust = 1, nudge_x = -.1)

ggsave(filename = "Non-Zero Lead Results in mgL per Sampling Round.pdf", width = 14, height = 8.5, units = "in", dpi = 300)
write_csv(non_zero_lead_results, "Non-Zero Lead Results in mgL per Sampling Round.csv")