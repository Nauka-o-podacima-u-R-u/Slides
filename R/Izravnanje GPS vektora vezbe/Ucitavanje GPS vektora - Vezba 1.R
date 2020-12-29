library(Matrix)
library(tidyverse)
library(magrittr)
library(DT)
library(ggplot2)
library(remedy)
library(here)
library(ggplot2)
library(gridExtra)
library(ggpubr)
library(lattice)
library(plotly)
library(ggforce)
library(ggthemes)
library(readxl)
library(sf)
library(sp)
library(rgdal)
library(here)


wdir <- "D:/R_projects/Nauka_R/Team_1_NaukaR_2020-21/Podaci/"
setwd(wdir)
getwd()


# Rešenje zadatka 1
# -----------------------------------------------------------------------------------------------------------

umka.data <- list.files("Umka_24/Umka_BG_24h/", full.names = TRUE)

umka.1 <- read.table(umka.data[4], sep = ",")
str(umka.1)

head(umka.1, 2) # Prve dve vrste
tail(umka.1, 3) # Poslednje tri vrste

umka.names <- c("header", "UTC_fix", "UTC_date", "latitude", "hemisphere", "longitude", "E/W", "GPS_quality", "n_satellites", "coord_quality", "antenna_altitude", "Altitude_units", "GDOP", "variance_factor", "C11", "C12", "C13", "C22", "C23", "C33")
names(umka.1) <- umka.names
str(umka.1)

 
# Rešenje zadatka 2
# -----------------------------------------------------------------------------------------------------------

# Za potrebe učitavanja više fajlova, koristićemo petlju `for`. Svaka petlja `for` se sastoji iz tri komponente: rezultat (output), sekvenca (sequence), telo (body).
umka.data.list <- list()                                                   # 1. output
for(i in 1:length(umka.data)){                                             # 2. sequence
  umka.data.list[[i]] <- read.table(umka.data[i], sep = ",")               # 3. body
}

str(umka.data.list)

umka.data.list[[3]]

# Dimenzije svakog elementa liste
lapply(umka.data.list, dim)

# Nazivi kolona svakog elementa liste
for(i in 1:length(umka.data.list)){
  names(umka.data.list[[i]]) <- umka.names
}

# Spajanje elemenata liste
umka12 <- rbind(umka.data.list[[1]], umka.data.list[[2]])

# Spajanje svih elemenata
umka.df <- data.frame()

for(i in 1:length(umka.data.list)){
  umka.df <- rbind(umka.df, umka.data.list[[i]])
}

# Elegantnije resenje
umka.df <- do.call(rbind, umka.data.list) # ?do.call

dim(umka.df)

# 1. nacin
umka.df$high_GDOP <- umka.df$GDOP > 2.6

# 2. nacin
umka.df %<>% dplyr::mutate(high_GDOP = case_when(GDOP > 2.6 ~ TRUE,
                                                 GDOP <= 2.6 ~ FALSE))

umka.df[umka.df$high_GDOP, "GPS_quality"]



# Ucitavanje svih podataka
# -----------------------------------------------------------------------------------------------------------

# :::::::::::::::
# Umka_BG_24h
# :::::::::::::::

# Pregled sadržaja foldera Umka_BG_24h
umka_bg_files <- list.files("Umka_24/Umka_BG_24h/", full.names = TRUE)

# Vektor naziva kolona
umka.names <- c("header", "UTC_fix", "UTC_date", "latitude", "hemisphere", "longitude", "E/W", "GPS_quality", "n_satellites", "coord_quality", "antenna_altitude", "Altitude_units", "GDOP", "variance_factor", "C11", "C12", "C13", "C22", "C23", "C33")

# Kreiranje prazne liste
umka_bg_list <- list()

# Popunjavanje liste sadržajem fajlova
for(i in 1:length(umka_bg_files)){                                             
  umka_bg_list[[i]] <- read.table(umka_bg_files[i], 
                                  sep = ",", 
                                  na.strings = NA, 
                                  fill = TRUE, 
                                  header =  FALSE, 
                                  col.names = umka.names) 
}

umka_bg_df <- data.frame()
for(i in 1:length(umka_bg_list)){
  umka_bg_df <- rbind(umka_bg_df, umka_bg_list[[i]])
}

# Elegantnije rešenje:

umka_bg_df <- do.call(rbind, umka_bg_list)

umka_bg_df <- dplyr::bind_rows(umka_bg_list)


# :::::::::::::::
# Umka_Grocka_24h
# :::::::::::::::

# Pregled sadržaja foldera Umka_Grocka_24h
umka_gr_files <- list.files("Umka_24/Umka_Grocka_24h/", full.names = TRUE)

# Kreiranje prazne liste
umka_gr_list <- list()

# Popunjavanje liste sadržajem fajlova
for(i in 1:length(umka_gr_files)){                                             
  umka_gr_list[[i]] <- read.table(umka_gr_files[i], 
                                  sep = ",", 
                                  na.strings = NA, 
                                  fill = TRUE, 
                                  header =  FALSE, 
                                  col.names = umka.names) 
}

umka_gr_df <- dplyr::bind_rows(umka_gr_list)

# :::::::::::::::
# Umka_Indjija_24h
# :::::::::::::::

# Pregled sadržaja foldera Umka_Indjija_24h
umka_in_files <- list.files("Umka_24/Umka_Indjija_24h/", full.names = TRUE)

# Kreiranje prazne liste
umka_in_list <- list()

# Popunjavanje liste sadržajem fajlova
for(i in 1:length(umka_in_files)){                                             
  umka_in_list[[i]] <- read.table(umka_in_files[i], 
                                  sep = ",", 
                                  na.strings = NA, 
                                  fill = TRUE, 
                                  header =  FALSE, 
                                  col.names = umka.names) 
}

umka_in_df <- dplyr::bind_rows(umka_in_list)

# ::::::::::::::::::::::::::::::
# Umka sa svim merenim vektorima
# ::::::::::::::::::::::::::::::

umka_df <- dplyr::bind_rows(umka_bg_df, umka_gr_df, umka_in_df)

summary(umka_df)

# Obelezavanje merenja koja imaju fixed i float resenje
unique(umka_df$GPS_quality)
umka_df$GPS_quality <- factor(umka_df$GPS_quality, labels = c("fixed")) # , "float"

# Kreiranje atributa GPS_vector koji identifikuje pripadnost odredjenom vektoru
umka_df$GPS_vector <- factor(c(rep("Beograd", dim(umka_bg_df)[1]), rep("Grocka", dim(umka_gr_df)[1]), rep("Indjija", dim(umka_in_df)[1])))

# Izbacivanje merenja koja imaju NA vrednosti
umka_df %<>% tidyr::drop_na(.)
# umka_df <- umka_df[complete.cases(umka_df), ]

# Konverzija promenljive `n_satellites` u kategorijsku (faktor)
umka_df$n_satellites <- as.factor(umka_df$n_satellites)




# Rešenje zadatka 3
# -----------------------------------------------------------------------------------------------------------

# UTC_date kolona ima format mmddyy
umka_df$UTC_date

# Da bi se konvertovala u datum mora se opisati format

# Ali prethodno mora biti konvertovana u tekstualni podatak
typeof(umka_df$UTC_date)
umka_df$UTC_date <- as.character(umka_df$UTC_date)

# Pojavljuje se drugi problem, neki zapisi imaju 5 karaktera: Jedan za mesece, dva za dane, dva za godine.

# Napraviti logicki vektor identifikuje vrste koje imaju 5 karaktera.
five_char <- nchar(umka_df$UTC_date) == 5

# Iskoristiti tu kolonu u selekciji i konverziji zapisa u 6-to karakterni
# Potrebno je dodati nulu ispred jednocifrenih meseci
# Komanda `paste` je iskorišćena za kreiranje tekstualnog podatka

umka_df$UTC_date[five_char] <- paste(0, umka_df$UTC_date[five_char], sep = "")

# Na kraju konverzija u datum se može uraditi komandom `as.Date()`

umka_df$UTC_date <- as.Date(umka_df$UTC_date, format = "%m%d%y")





