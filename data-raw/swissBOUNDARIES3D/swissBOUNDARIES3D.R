library(tidyverse)
library(magrittr)
library(sf)

# #################################################
# boundaries 20
gem_20_raw <- st_read("data-raw/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_HOHEITSGEBIET.shp")
# bezirk_20_raw <- st_read("data-raw/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_BEZIRKSGEBIET.shp")
canton_20_1_raw <- st_read("data-raw/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")
# country_20_raw <- st_read("data-raw/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET.shp")

nrow(canton_20_1_raw)
length(unique(canton_20_1_raw$KANTONSNUM))

# View(st_drop_geometry(canton_20_1_raw))
# plot(st_geometry(canton_20_1_raw))

canton_20_1 <- canton_20_1_raw %>% 
  st_zm(drop = TRUE) %>% 
  select(KANTONSNUM, NAME, KT_TEIL)

any(is.na(st_dimension(canton_20_1)))
nrow(canton_20_1)
length(unique(canton_20_1$KANTONSNUM))

View(st_drop_geometry(canton_20_1))
plot(st_geometry(canton_20_1))

# multi polygon example
canton_20_1 %>% 
  filter(NAME == "Fribourg") %>% 
  select(KT_TEIL) %>% 
  plot()

# lakes
lac20 <- gem_20_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(BFS_NUMMER >= 9000) %>% 
  select(KANTONSNUM, NAME)

plot(st_geometry(lac20))
View(st_drop_geometry(lac20))

canton_20_1 %>% 
  select(-KT_TEIL) %>% 
  saveRDS("data/swissBOUNDARIES3D/canton_20_1.Rds", delete_dsn = TRUE)

# lac20 %>% 
#   select(-BFS_NUMMER) %>% 
#   st_write("data/swissBOUNDARIES3D/lac20.shp", delete_dsn = TRUE)

