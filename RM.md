# Swiss Fertility Pipeline

## What this script does

The pipeline loads the built-in `swiss` dataset (socio-economic indicators for Swiss provinces), isolates provinces where the Catholic population is a majority (>50%), computes summary statistics (average fertility, average education, and max agriculture) for those provinces, and saves a scatter plot of fertility vs. education to `outputs/my_plot.png`.

- **Broken version:** `broken_pipeline.R`
- **Fixed version:** `fixed_pipeline.R`

## Changelog

Bugs fixed from the original `broken_pipeline.R`:

- **Removed `library(ggplot)`** — no CRAN package named `ggplot` exists; `tidyverse` already loads `ggplot2`.
- **Fixed typo `swis` → `swiss`** — the original referenced a non-existent object (`object 'swis' not found`).
- **Fixed `True` → `TRUE`** — R is case-sensitive; `True` throws `object 'True' not found`.
- **Fixed unbalanced parentheses in `summarize()`** — `mean(Education, na.rm = T,` was never closed, causing a fatal `unexpected end of input` parse error so nothing ran.
- **Replaced `|>` with `+` in the ggplot chain** — piping the ggplot object into `geom_point()` passed it as the `mapping` argument and errored; ggplot layers must be combined with `+`.
- **Connected `labs()` with `+`** — the missing operator meant the title expression was evaluated and discarded instead of being added to the plot.
- **Plot `high_catholic` instead of `summary_stats`** — the original plotted a single-row summary, producing a meaningless one-point chart instead of province-level data.
- **Moved the flag before the filter** — `mutate(is_majority = TRUE)` after `filter(Catholic > 50)` made the column constant `TRUE` and unused; now computed as `Catholic > 50` before filtering, and it's actually used by `filter()`.
- **Changed `na.rm = T` → `na.rm = TRUE`** — `T` can be reassigned by user code; `TRUE` is the safe literal.
- **Added `dir.create("outputs", showWarnings = FALSE)`** — the original called `ggsave("outputs/my_plot.png", ...)` but the `outputs/` directory did not exist, so saving failed.
- **Renamed `plot` → `p`** — avoids shadowing the base R `plot()` function.

## How to run

Requirements: [R](https://www.r-project.org/) (>= 4.1, for the native `|>` pipe) with the `tidyverse` package installed.

```r
install.packages("tidyverse")   # only needed once
```

From the repository root:

```bash
Rscript fixed_pipeline.R
```

Or interactively in R / RStudio:

```r
source("fixed_pipeline.R")
```

The script creates `outputs/` automatically if it is missing, then writes the chart to `outputs/my_plot.png`.
