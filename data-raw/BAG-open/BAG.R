# data from 
# https://www.bag.admin.ch/bag/en/home/krankheiten/ausbrueche-epidemien-pandemien/aktuelle-ausbrueche-epidemien/novel-cov/situation-schweiz-und-international.html

library(readxl)
library(dplyr)
library(readr)

# #####################

download.file(url = 'https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-labortests.xlsx.download.xlsx/Dashboard_3_COVID19_labtests_positivity.xlsx',
              destfile = 'data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx',
              method = 'curl')

positivity <- read_xlsx("data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx", 
                        col_types = c("date", "date", "numeric", 
                                      "text"), 
                        na = "NA") %>% 
  select(-Replikation_dt) %>% 
  mutate(Datum = as.Date(Datum)) %>% 
  mutate(Week = as.integer(format(Datum, format = "%V"))) %>% 
  rename(Date = Datum)

write_rds(positivity, "data/BAG-open/positivity.rds")

# #####################

download.file(url = 'https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-fallzahlen.xlsx.download.xlsx/Dashboards_1&2_COVID19_swiss_data_pv.xlsx',
              destfile = 'data-raw/BAG-open/Dashboards_1&2_COVID19_swiss_data_pv.xlsx', 
              method = 'curl')

deaths_cases <- read_xlsx("data-raw/BAG-open/Dashboards_1&2_COVID19_swiss_data_pv.xlsx", 
                          col_types = c("date", "text", "text", 
                                        "text", "text", "text", "text", 
                                        "numeric", "text", "numeric"),
                          na = "NA") %>% 
  select(-replikation_dt, -Geschlecht, - Sexe) %>% 
  mutate(sex = factor(sex, labels = c("Men", "Women", "Unknown"))) %>% 
  mutate(akl = factor(akl)) %>% 
  mutate(fall_dt = as.Date(fall_dt), 
         pttoddat = as.Date(pttoddat)) %>% 
  rename(canton = ktn,
         age_group = akl,
         deaths = pttod_1, 
         cases = fallklasse_3) 

write_rds(deaths_cases, "data/BAG-open/deaths_cases.rds")

# #####################

download.file(url = 'https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-bevoelkerungszahlen.xlsx.download.xlsx/Population_Size_BFS.xlsx',
              destfile = 'data-raw/BAG-open/Population_Size_BFS.xlsx', 
              method = 'curl')

population <- read_excel("data-raw/BAG-open/Population_Size_BFS.xlsx") %>% 
  rename(canton = Kanton,
         age_group = Alterklasse,
         sex = Geschlecht) 

write_rds(population, "data/BAG-open/population.rds")
