library(readr)
library(sf)

canton_20_raw <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1k20.shp")

nrow(canton_20_raw)
length(unique(canton_20_raw$KTNR))

# View(st_drop_geometry(canton_20_raw))
# plot(st_geometry(canton_20_raw))

write_rds("data/ag-b-00.03-875-gg20/canton_20_raw.Rds")

lake <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1s20.shp")

nrow(lake)
length(unique(lake$GMDNR))

# View(st_drop_geometry(lake))
# plot(st_geometry(lake))

write_rds("data/ag-b-00.03-875-gg20/lake.Rds")