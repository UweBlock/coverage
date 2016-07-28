library(magrittr)
library(data.table)
library(ggplot2)
n <- 10
max_days <- 2
start_time <- as.POSIXct("2016-07-01", tz = "UTC")
set.seed(1234)
dt <- seq(from = start_time, to = start_time + lubridate::days(max_days), by = "5 min") %>% 
  sample(n, replace = TRUE) %>% 
  as.data.table() %>% setnames("start")
dt[, end := start + rpois(n, 10) %>% lubridate::hours()]

setkey(dt, start, end)

ggplot(dt, aes(x = 1:n, ymin = start, ymax = end)) + geom_linerange() + coord_flip()

library(IRanges)
ir <- IRanges::IRanges(start = as.integer(dt$start), end = as.integer(dt$end))
coverage(ir)

coverage.data.table