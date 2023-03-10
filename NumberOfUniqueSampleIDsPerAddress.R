library(tidyverse)

samples <- read_csv("C:\\Users\\JohnsonN35\\Downloads\\FIIP_CombinedLabsWorkbookTrimmed_to221110.csv", skip = 5)

samples_per_addr <- samples %>% 
  group_by(SampledAddress_USPS, lab_sample_id) %>% 
  summarize(lab_id_count = n()) %>% 
  summarize(unique_samples = n())

ggplot(samples_per_addr) + 
  geom_col(mapping = aes(x = unique_samples, y = reorder(SampledAddress_USPS, -unique_samples), fill = unique_samples), show.legend = FALSE) + 
  labs(x = "Number of Unique Sample IDs", y = "Address", title = "Number of Unique Sample IDs per Address") + theme(axis.text.y = element_text(size = 4)) + 
  geom_text(mapping = aes(x = unique_samples, y = reorder(SampledAddress_USPS, -unique_samples), label = unique_samples, color = unique_samples), size = 2, hjust = 0, vjust = 0.4, show.legend = FALSE)

ggsave(filename = "Number of Unique Sample IDs per Address.pdf", width = 14, height = 8.5, units = "in", dpi = 300)
write_csv(samples_per_addr, "Number of Unique Sample IDs per Address.csv")