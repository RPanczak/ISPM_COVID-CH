# data from 
# https://www.bag.admin.ch/bag/en/home/krankheiten/ausbrueche-epidemien-pandemien/aktuelle-ausbrueche-epidemien/novel-cov/situation-schweiz-und-international.html
# updated
# 2022-02-09

set.seed(12345)
library(readxl)
library(dplyr)
library(readr)
library(lubridate)


# #####################

# alternative source for ind files
# https://opendata.swiss/en/dataset/covid-19-schweiz
download.file(url = "https://www.covid19.admin.ch/api/data/20220209-o60vrn5s/downloads/sources-csv.zip",
              destfile = "data-raw/BAG-open/sources-csv.zip",
              method = "curl")

unzip("data-raw/BAG-open/sources-csv.zip", junkpaths = TRUE,
      exdir = "data-raw/BAG-open/sources-csv")  

cases <- read_csv("data-raw/BAG-open/sources-csv/COVID19Cases_geoRegion.csv") %>% 
  select(geoRegion, datum, 
         pop, 
         entries, sumTotal,
         mean7d
  ) %>% 
  filter(datum < ymd("2022-02-09"))

write_rds(cases, "data/BAG-open/cases.Rds")

deaths <- read_csv("data-raw/BAG-open/sources-csv/COVID19Death_geoRegion.csv") %>% 
  select(geoRegion, datum, 
         pop, 
         entries, sumTotal,
         mean7d
  ) %>% 
  filter(datum < ymd("2022-02-09"))

write_rds(deaths, "data/BAG-open/deaths.Rds")

tests <- read_csv("data-raw/BAG-open/sources-csv/COVID19Test_geoRegion_all.csv") %>% 
  select(geoRegion, datum, 
         pop, 
         entries, entries_pos, entries_neg, 
         pos_anteil, pos_anteil_mean7d
  ) %>% 
  filter(datum < ymd("2022-02-09"))

write_rds(tests, "data/BAG-open/tests.Rds")

unlink("data-raw/BAG-open/sources-csv.zip")
unlink("data-raw/BAG-open/sources-csv", recursive = TRUE)

# COVID19Hosp_geoRegion.csv
# COVID19HospCapacity_geoRegion.csv

# COVID19VaccPersons_AKL10_w_v2.csv
# COVID19VaccPersons_sex_w_v2.csv

# # #####################
# 
# download.file(url = "https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-labortests.xlsx.download.xlsx/Dashboard_3_COVID19_labtests_positivity.xlsx",
#               destfile = "data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx",
#               method = "curl")
# 
# positivity <- read_xlsx("data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx", 
#                         col_types = c("date", "date", "numeric", 
#                                       "text"), 
#                         na = "NA") %>% 
#   select(-Replikation_dt) %>% 
#   mutate(Datum = as.Date(Datum)) %>% 
#   mutate(Week = as.integer(format(Datum, format = "%V"))) %>% 
#   rename(Date = Datum)
# 
# zip(zipfile = "data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity", 
#     files = "data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx")
# 
# file.remove("data-raw/BAG-open/Dashboard_3_COVID19_labtests_positivity.xlsx")
# 
# write_rds(positivity, "data/BAG-open/positivity.Rds")
# 
# # #####################
# 
# # download.file(url = "https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-fallzahlen.xlsx.download.xlsx/Dashboards_1&2_COVID19_swiss_data_pv.xlsx",
# #               destfile = "data-raw/BAG-open/Dashboards_1&2_COVID19_swiss_data_pv.xlsx", 
# #               method = "curl")
# 
# # deaths_cases <- read_xlsx("data-raw/BAG-open/Data on laboratory findings and deaths.csv", 
# #                           col_types = c("date", "text", "text", 
# #                                         "text", "text", "text", "text", 
# #                                         "numeric", "text", "numeric"),
# #                           na = "NA") %>% 
# #   select(-replikation_dt, -Geschlecht, - Sexe) %>% 
# #   mutate(sex = factor(sex, labels = c("Men", "Women", "Unknown"))) %>% 
# #   mutate(akl = factor(akl)) %>% 
# #   mutate(fall_dt = as.Date(fall_dt), 
# #          pttoddat = as.Date(pttoddat)) %>% 
# #   rename(canton = ktn,
# #          age_group = akl,
# #          deaths = pttod_1, 
# #          cases = fallklasse_3) 
# 
# download.file(url = "https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-fallzahlen.csv.download.csv/Data%20on%20laboratory%20findings%20and%20deaths.csv",
#               destfile = "data-raw/BAG-open/Data on laboratory findings and deaths.csv", 
#               method = "curl")
# 
# deaths_cases <- read_delim("data-raw/BAG-open/Data on laboratory findings and deaths.csv", 
#                            delim = ";",
#                            col_names = TRUE, 
#                            col_types = cols_only(
#                              fall_dt = col_date(),
#                              ktn = col_character(),
#                              akl = col_character(),
#                              sex = col_integer(),
#                              fallklasse_3 = col_integer(),
#                              pttoddat = col_date(),
#                              case_death_1 = col_integer())) %>% 
#   mutate(sex = factor(sex, labels = c("Men", "Women", "Unknown"))) %>% 
#   mutate(akl = factor(akl)) %>% 
#   rename(canton = ktn,
#          age_group = akl,
#          deaths = case_death_1, 
#          cases = fallklasse_3) 
# 
# write_rds(deaths_cases, "data/BAG-open/deaths_cases.Rds")
# 
# zip(zipfile = "data-raw/BAG-open/Data on laboratory findings and deaths", 
#     files = "data-raw/BAG-open/Data on laboratory findings and deaths.csv")
# 
# file.remove("data-raw/BAG-open/Data on laboratory findings and deaths.csv")
# 
# # #####################
# 
# download.file(url = "https://www.bag.admin.ch/dam/bag/en/dokumente/mt/k-und-i/aktuelle-ausbrueche-pandemien/2019-nCoV/covid-19-basisdaten-bevoelkerungszahlen.xlsx.download.xlsx/Population_Size_BFS.xlsx",
#               destfile = "data-raw/BAG-open/Population_Size_BFS.xlsx", 
#               method = "curl")
# 
# population <- read_xlsx("data-raw/BAG-open/Population_Size_BFS.xlsx",
#                         sheet = "Population nach AKL, sex, KTN") %>% 
#   rename(canton = Kanton,
#          age_group = Alterklasse,
#          sex = Geschlecht) 
# 
# write_rds(population, "data/BAG-open/population.Rds")
