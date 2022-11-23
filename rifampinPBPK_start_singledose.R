install.packages("tidyverse")
install.packages("PKPDmisc")

library(tidyverse)
library(mrgsolve)
#library(PKPDmisc)
theme_set(theme_bw())
theme_update(legend.position = "top")

mod <- mread_cache("rifampicin_midazolam", "docs/models", delta = 0.1)
mod

param(mod)
init(mod)


rif <- ev(amt = 600)
rif

mod %>%
  ev(rif) %>% 
  Req(Ccentral) %>%
  mrgsim(end = 48) %>% 
  plot()