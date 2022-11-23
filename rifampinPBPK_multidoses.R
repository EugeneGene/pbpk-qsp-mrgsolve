rif <- mutate(rif, ii = 24, addl = 9)
rif

out <- 
  mod %>%
  ev(rif) %>% 
  mrgsim(end = 240)

plot(out, Ccentral ~ time)

## Need to install PKPDmisc before using below:
aucs <- 
  out %>% 
  mutate(DAY = 1+floor(time/24)) %>%
  group_by(DAY) %>% 
  summarise(AUC = auc_partial(time,Ccentral)) %>% 
  ungroup %>% 
  mutate(pAUC = 100*AUC/first(AUC)) %>%
  filter(DAY < 10)

ggplot(aucs, aes(factor(DAY),pAUC)) + 
  geom_col(alpha = 0.6) + 
  geom_hline(yintercept = 70, lty = 2, col = "firebrick") + 
  scale_y_continuous(breaks = seq(0,100,10)) + 
  ggtitle("Auto-induction of rifampicin metabolism")