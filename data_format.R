library(tidyverse)
library(readxl)
library(dataRetrieval)
library(lubridate)

setwd("C:/Users/linne/Box Sync/CL_BUD")
source("C:/Users/linne/Box Sync/CL_BUD/datasets_asFunction.R")

d.YN <- d.YN %>%
  mutate(ID = "YN")

d.YI <- d.YI %>%
  mutate(ID = "YI")

d.6MC <- d.6MC %>%
  mutate(ID = "6MC")

d.DC <- d.DC %>%
  mutate(ID = "DC")

d.PBMS <- d.PBMS %>%
  mutate(ID = "PBMS")

d.PBSF <- d.PBSF %>%
  mutate(ID = "PBSF")

masterdischarge <- rbind(d.YN, d.YI, d.6MC, d.DC, d.PBMS, d.PBSF)
mastercond <- rbind(loggerYN, loggerYI, logger6MC, loggerDC, loggerPBMS, loggerPBSF)
mastercl <- rbind(labYN, labYI, lab6MC, labDC, labPBMS, labPBSF)

master <- masterdischarge %>% 
  left_join(mastercond, by = c("ID", "date")) %>%
  left_join(mastercl, by = c("ID", "date")) %>%
  distinct() %>%
  mutate(sitename = ifelse(ID == "YN", "Yahara River at Highway 113", NA),
         sitename = ifelse(ID == "YI", "Yahara River at E. Main St.", sitename),
         sitename = ifelse(ID == "6MC", "Sixmile Creek at Highway M", sitename),
         sitename = ifelse(ID == "DC", "Dorn Creek at Highway M", sitename),
         sitename = ifelse(ID == "PBMS", "Pheasant Branch Creek - Main Stem", sitename),
         sitename = ifelse(ID == "PBSF", "Pheasant Branch Creek - South Fork", sitename))


write_rds(master, "C:/Users/linne/Box Sync/cQ-App/cQ/data/master.rds")


master$sitename <- fct_relevel(master$sitename, "Yahara River at Highway 113")
siteChoices <- seq(1:length(levels(master$sitename)))
names(siteChoices) <- levels(master$sitename)

write_rds(siteChoices, "C:/Users/linne/Box Sync/cQ-App/cQ/data/siteChoices.rds")
