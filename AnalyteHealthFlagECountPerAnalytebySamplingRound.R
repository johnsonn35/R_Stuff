library(tidyverse)

samples <- read_csv("C:\\Users\\JohnsonN35\\Downloads\\FIIP_CombinedLabsWorkbookTrimmed_to221110.csv", skip = 5)

analyte_health_flag_E <- filter(samples, AnalyteHealthFlag == 'HealthFlag-E')

sampling_round_levels <- c("1", "2", "3", "3.5", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14/QR0", "15/QR1", "16/QR2")

sampling_round_fac <- factor(analyte_health_flag_E$SamplingRound, levels = sampling_round_levels)

ggplot(data = analyte_health_flag_E) + 
  geom_bar(mapping = aes(y = analyte_name, fill = sampling_round_fac), position = position_stack(reverse = TRUE), color = "black") + 
  geom_text(mapping = aes(y = analyte_name, x = after_stat(count), label = sampling_round_fac, group = sampling_round_fac), stat = "count", hjust = 0.5, position = position_stack(vjust = 0.5, reverse = TRUE), check_overlap = TRUE) + 
  labs(y = "Analyte Name", x = "HealthFlag-E Count", title = "Analyte Health Flag 'HealthFlag-E' Count per Analyte by Sampling Round", fill = "Sampling Round\n(Labeled)")

ggsave(filename = "Analyte Health Flag HealthFlag-E Count per Analyte by Sampling Round.pdf", width = 14, height = 8.5, units = "in", dpi = 300)
write_csv(analyte_health_flag_E, "Analyte Health Flag HealthFlag-E Count per Analyte by Sampling Round.csv")