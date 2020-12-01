library(tidyverse)
library(dplyr)
library(sf)
library(readxl)
library(magrittr)
library(stringr)
wd <- "D:/R_projects/Nauka_R/"
setwd(wd)


dat1 <- readxl::read_excel(path = "covid.xlsx") %>%
  as.data.frame()

dat2 <- readxl::read_excel(path = "covid_2.xlsx") %>%
  as.data.frame() %>%
  dplyr::mutate(opstina = stringr::str_to_title(opstina))

unique(dat2$opstina)
# listCovid_date <- split(dat1, dat1$date) 

dat1 %<>% mutate(ind = row_number())
dat2 %<>% mutate(ind = dat1$ind[match(dat2$date, dat1$date)])


# dplyr::filter(dat2, ind == 45) %>% 
#   as.data.frame() %>% 
#   dplyr::group_by(opstina) %>%
#   dplyr::summarise(date = date[1], 
#                    polm = sum(pol == "MUŠKI"),
#                    polz = sum(pol == "ŽENSKI"),
#                    starost_mean = mean(starost))

# Grupisati i sumirati po opstinama za drugi element liste
# Dodeliti geometriju

Sys.setlocale(locale = 'Serbian (Latin)')
opstine <- st_read("gadm36_SRB_2.shp")
sf_opstine <- st_as_sf(opstine)

sf_opstine %<>% dplyr::select(NAME_1, NAME_2) %>%
  dplyr::rename(Okrug = NAME_1, Opstina = NAME_2)

listCovid_date <- list()
for(i in 1:dim(dat1)[1]){
  listCovid_date[[i]] <- list()
  listCovid_date[[i]][[1]] <- dat1[i, ] %>% as.data.frame()
  listCovid_date[[i]][[2]] <- dplyr::filter(dat2, ind == i) %>% 
    as.data.frame() %>% 
    dplyr::group_by(opstina) %>%
    dplyr::summarise(date = date[1], 
                     polm = sum(pol == "MUŠKI"),
                     polz = sum(pol == "ŽENSKI"),
                     starost_mean = mean(starost)) %>%
    as.data.frame()
  listCovid_date[[i]][[3]] <- sf_opstine %>% 
    dplyr::mutate(date = listCovid_date[[i]][[2]]$date[match(sf_opstine$Opstina, listCovid_date[[i]][[2]]$opstina)],
                  polm = listCovid_date[[i]][[2]]$polm[match(sf_opstine$Opstina, listCovid_date[[i]][[2]]$opstina)],
                  polz = listCovid_date[[i]][[2]]$polz[match(sf_opstine$Opstina, listCovid_date[[i]][[2]]$opstina)],
                  starost_mean = listCovid_date[[i]][[2]]$starost_mean[match(sf_opstine$Opstina, listCovid_date[[i]][[2]]$opstina)]) %>% 
    st_transform(crs = "+init=epsg:32634") %>% 
  mutate(starost_mean = case_when(is.na(starost_mean) ~ 0, !is.na(starost_mean) ~ starost_mean))
}

unique(dat2$ind)
listCovid_date[[42]]


library(mapview)
mapview(listCovid_date[[42]][[3]], zcol = "starost_mean", layer.name = "Prosecan broj godina starosti: ")

# ::::::::::::::::::::::::::::::::::::::
### Vizuelizacija
# ::::::::::::::::::::::::::::::::::::::

