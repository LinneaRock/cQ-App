library(tidyverse)
library(readxl)
library(dataRetrieval)
source("C:/Users/linne/Box Sync/CL_BUD/Functions/SC.R")
source("C:/Users/linne/Box Sync/CL_BUD/Functions/readSP.R")
source("C:/Users/linne/Box Sync/CL_BUD/Functions/readCL.R")

format <- function(d) {
  d %>%
    rename(discharge = X_00060_00000) %>%
    select(dateTime, discharge) %>%
    mutate(discharge = discharge * 0.028316847) %>%
    rename(date = dateTime)
}


loggerYN = readSP(c("C:/Users/linne/Box Sync/Chloride Research/Data/HOBO_Loggers/YN/Dec19_Feb4/20758343_YN.csv", "C:/Users/linne/Box Sync/Chloride Research/Data/HOBO_Loggers/YN/Feb4_Mar16/20758343_YN.csv"))%>%
  mutate(ID = "Yahara River at Highway 113")

d.YN <- readNWISuv("05427850", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format()
d.YN <- d.YN %>%
  mutate(ID = "Yahara River at Highway 113")

labYN <- readCL("YN") %>%
  mutate(ID = "Yahara River at Highway 113")

YN_cond <- left_join(loggerYN, d.YN, by = "date")
write_rds(YN_cond, "cQ/data/YN_cond.rds")
YN_cl <- left_join(labYN, d.YN, by = "date") %>%
  na.omit()
write_rds(YN_cl, "cQ/data/YN_cl.rds")



loggerYI <- readSP(c("C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/YI/Dec19_Feb4/20758347_YI.csv", "C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/YI/Feb4_Mar16/20758347_YI.csv")) %>%
  filter(date != "2020-02-04 14:30:00") %>%
  mutate(ID = "Yahara River at E. Main St.")

d.YI <- readNWISuv("05428500", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format() 

d.YI <- d.YI %>%
  mutate(ID = "Yahara River at E. Main St.")

labYI <- readCL("YI") %>%
  mutate(ID = "Yahara River at E. Main St.")

YI_cond <- left_join(loggerYI, d.YI, by = "date")
write_rds(YI_cond, "cQ/data/YI_cond.rds")
YI_cl <- left_join(labYI, d.YI, by = "date") %>%
  na.omit() %>%
  select(-actual_datetime)
write_rds(YI_cl, "cQ/data/YI_cl.rds")



fileNames = c("C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/6MC/Dec19_Feb4/20758342_6MC.csv", "C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/6MC/Feb4_Mar16/20758342_6MC.csv") 
logger6MC = readSP(fileNames)  %>%
  filter(date != "2020-03-16 10:00:00") %>%
  mutate(ID = "Sixmile Creek at Highway M")

d.6MC <- readNWISuv("05427910", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format() %>%
  mutate(ID = "Sixmile Creek at Highway M")

lab6MC <- readCL("6MC")%>%
  mutate(ID = "Sixmile Creek at Highway M")

SMC_cond <- left_join(logger6MC, d.6MC, by = "date")
write_rds(SMC_cond, "cQ/data/6MC_cond.rds")
SMC_cl <- left_join(lab6MC, d.6MC, by = "date") %>%
  na.omit()
write_rds(SMC_cl, "cQ/data/6MC_cl.rds")


loggerDC <- readSP(c("C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/DC/Dec19_Feb4/20758338_DC.csv", "C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/DC/Feb4_Mar16/20758338_DC.csv")) %>%
  mutate(ID = "Dorn Creek at Highway M")

d.DC <- readNWISuv("05427930", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format() %>%
  mutate(ID = "Dorn Creek at Highway M")

labDC <- readCL("DC")%>%
  mutate(ID = "Dorn Creek at Highway M")

DC_cond <- left_join(loggerDC, d.DC, by = "date")
write_rds(DC_cond, "cQ/data/DC_cond.rds")
DC_cl <- left_join(labDC, d.DC, by = "date") %>%
  na.omit()
write_rds(DC_cl, "cQ/data/DC_cl.rds")


loggerPBMS <- readSP(c("C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/PBMS/Dec19_Feb3/20758344_PBMS.csv", "C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/PBMS/Feb3_Mar16/20758344_PBMS.csv")) %>%
  mutate(ID = "Pheasant Branch Creek - Main Stem")

d.PBMS <- readNWISuv("05427948", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format() %>%
  mutate(ID = "Pheasant Branch Creek - Main Stem")

labPBMS <- readCL("PBMS")%>%
  mutate(ID = "Pheasant Branch Creek - Main Stem")

PBMS_cond <- left_join(loggerPBMS, d.PBMS, by = "date")
write_rds(PBMS_cond, "cQ/data/PBMS_cond.rds")
PBMS_cl <- left_join(labPBMS, d.PBMS, by = "date") %>%
  na.omit()
write_rds(PBMS_cl, "cQ/data/PBMS_cl.rds")



loggerPBSF <- readSP(c("C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/PBSF/Jan2_Jan15/20758339_PBSF.csv","C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/PBSF/Jan21_Feb4/20758339_PBSF.csv", "C:/Users/linne/Box Sync/CL_Bud/Data/HOBO_Loggers/PBSF/Feb4_Mar16/20758339_PBSF.csv" )) %>%
  mutate(ID = "Pheasant Branch Creek - South Fork")

d.PBSF <- readNWISuv("054279465", "00060", "2019-01-01", "", tz = "America/Chicago") %>%
  format() %>%
  mutate(ID = "Pheasant Branch Creek - South Fork")

labPBSF <- readCL("PBSF") %>%
  mutate(ID = "Pheasant Branch Creek - South Fork")

PBSF_cond <- left_join(loggerPBSF, d.PBSF, by = "date")
write_rds(PBSF_cond, "cQ/data/PBSF_cond.rds")
PBSF_cl <- left_join(labPBSF, d.PBSF, by = "date") %>%
  na.omit()
write_rds(PBSF_cl, "cQ/data/PBSF_cl.rds")


mastercond <- rbind(YN_cond, YI_cond, SMC_cond, DC_cond, PBMS_cond, PBSF_cond) %>%
  select(ID.x, date, sp.cond, discharge) %>%
  rename(site = ID.x)

write_rds(mastercond, "cQ/data/mastercond.rds")

mastercl <- rbind(YN_cl, YI_cl, SMC_cl, DC_cl, PBMS_cl, PBSF_cl) %>%
  select(ID.x, date, chloride_mgL, discharge) %>%
  rename(site = ID.x)

write_rds(mastercl, "cQ/data/mastercl.rds")


sites <- c("Yahara River at Highway 113","Yahara River at E. Main St.","Sixmile Creek at Highway M","Dorn Creek at Highway M","Pheasant Branch Creek - Main Stem","Pheasant Branch Creek - South Fork")
siteChoices <- as_tibble(sites) %>%
  rename(Site = value)
write_rds(siteChoices, "cQ/data/siteChoices.rds")
