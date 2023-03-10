library(tidyverse)

# Assign sampling data to flint_samples
flint_samples <- read_csv("C:\\Users\\JohnsonN35\\Downloads\\FIIP_CombinedLabsWorkbookTrimmed_to221110.csv", skip = 5)

# Filter flint_samples to only records that have HealthFlag-E in AnalyteHealthFlag
analyte_health_flag_E <- filter(flint_samples, AnalyteHealthFlag == 'HealthFlag-E')

# Create a list of the valid sampling zone levels (otherwise zone 10 will follow 1 on chart)
sampling_zone_levels <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25")

# Create a factor from the sampling zone levels
sampling_zone_fac <- factor(analyte_health_flag_E$SamplingZone, levels = sampling_zone_levels)

# Create a plot
ggplot(data = analyte_health_flag_E) + 
  geom_bar(mapping = aes(y = analyte_name, fill = factor(SamplingZone, levels = sampling_zone_levels)), position = position_stack(reverse = TRUE), color = "black") + 
  geom_text(mapping = aes(y = analyte_name, x = after_stat(count), label = SamplingZone, group = SamplingZone), stat = "count", hjust = 0.5, position = position_stack(vjust = 0.5, reverse = TRUE)) +
  labs(y = "Analyte Name", x = "HealthFlag-E Count", title = "Analyte Health Flag 'HealthFlag-E' Count per Analyte by Sampling Zone", fill = "Sampling Zone\n(Labeled)")
