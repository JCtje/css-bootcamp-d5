# fixed_pipeline.R
library(tidyverse)

# Load data
df <- swiss

# Isolate provinces with Catholic percentage > 50 and flag them
high_catholic <- df |>
  mutate(is_majority = Catholic > 50) |>
  filter(is_majority)

# Calculate summary stats
summary_stats <- high_catholic |>
  summarize(
    avg_fertility = mean(Fertility),
    avg_education = mean(Education, na.rm = TRUE),
    max_ag = max(Agriculture)
  )

# Plot the province-level results
p <- ggplot(high_catholic, aes(x = Fertility, y = Education)) +
  geom_point(color = "red") +
  theme_minimal() +
  labs(title = "Fertility vs Education in Majority Catholic Swiss Provinces")

# Create outputs/ if missing, then save
dir.create("outputs", showWarnings = FALSE)
ggsave("outputs/my_plot.png", p)
