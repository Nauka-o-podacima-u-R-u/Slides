---
title: "Izravnanje GPS vektora"
author: "Milutin Pejović"
date: "17 November 2020"
output:
  html_document:
      keep_md: true
      theme: "simplex"
      toc: true
      highlight: tango
      toc_depth: 5
      toc_float: true
      fig_caption: yes

---








# O podacima
Podaci obuhvataju rezultate procesiranja tri GPS vektora koji se sustiču u tački stabilizovanoj na klizištu Umka. Druge tačke ovih vektora nalaze se u Beogradu, Indjiji i Grockoj. Rezultati procesiranja vektora dobijeni su iz softvera `Leica Spider` i odnose se na interval od 12h i 24h. To znači da je na svakih 12h i 24h zapisan jedan rezultat procesiranja vektora. Rezultati su zapisani u tekstualnom fajlu sa ekstenzijom `.rtl`. Pojedinačne informacije u okviru jednog rezultata su odvojene zarezom (`","`)


## Leica proprietary Definition

A NMEA-like format for transmission of geographic coordinates, coordinate quality and variance-covariance information.

<!--html_preserve--><div id="htmlwidget-1979d2f44d6d0dad0305" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1979d2f44d6d0dad0305">{"x":{"filter":"none","data":[["$GPLMM","hhmmss.ss","mmddyy","llll.ll","a","yyyyy.yy","a","x","xx","x.x","x.x","M","x.x","x.x","x.x","x.x","x.x","x.x","x.x","x.x","* hh","&lt;CR&gt;","&lt;LF&gt;"],["Header","UTC of Position Fix","UTC date","Latitude","Hemisphere “N”/“S”","Longitude","  “E”/“W”","GPS Quality Indicator","Number of Satellites in Use","Coordinate Quality","Antenna altitude above/below mean sea level","Units of altitude meters (fixed text “M”)","GDOP","A posteriori variance factor. Show to 4 decimal places.","Element C11 from the co-factor matrix. Shown to 4 decimal places, in metres. Corresponds to the latitude component. ","Element C12 from the co-factor matrix. Shown to 4 decimal places, in metres.","Element C13 from the co-factor matrix. Shown to 4 decimal places, in metres.","Element C22 from the co-factor matrix. Shown to 4 decimal places, in metres. Corresponds to the longitude component.","Element C23 from the co-factor matrix. Shown to 4 decimal places, in metres.","Element C33 from the co-factor matrix. Shown to 4 decimal places, in metres. Corresponds to the height component. ","Checksum","Carriage Return"," Line Feed"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Format<\/th>\n      <th>Content<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":23,"scrollY":true,"order":[],"autoWidth":false,"orderClasses":false,"lengthMenu":[10,23,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

GPS Quality Indicator

* 0 = fix not available or invalid.
* 1 = No Realtime position, navigation fix.
* 2 = Realtime position, ambiguities not fixed.
* 3 = Realtime position, ambiguities fixed.
* 5 = Realtime position, float ambiguities.


> ### Zadatak 1
>
> - Pregledati sadržaj foldera `data/Umka_BG_24h`
> - Učitati sedmi fajl iz foldera `data/Umka_BG_24h` i pregledati strukturu učitanih podataka. 
> - Pregledati prve dve i poslednje tri vrste u tabeli učitanih podatka.
> - Kreirati vektor sa imenima kolona ("header", "UTC_fix", "UTC_date", "latitude", "hemisphere", "longitude", "E/W", "GPS_quality", "n_satellites", "coord_quality", "antenna_altitude", "Altitude_units", "GDOP", "variance_factor", "C11", "C12", "C13", "C22", "C23", "C33")
> - Dodeliti imena kolonama nakon učitavanja
> - Dodeliti imena kolonama prilikom učitavanja.
>
> > #### Rešenje za Zadatak 1
> >
> > 
> > ```r
> > umka.data <- list.files(here::here("data"))
> > 
> > umka.1 <- read.table(here::here("data", umka.data[4]), sep = ",")
> > 
> > str(umka.1)
> > 
> > head(umka.1, 2) # Prve dve vrste
> > tail(umka.1, 3) # Poslednje tri vrste
> > 
> > umka.names <- c("header", "UTC_fix", "UTC_date", "latitude", "hemisphere", "longitude", "E/W", "GPS_quality", "n_satellites", "coord_quality", "antenna_altitude", "Altitude_units", "GDOP", "variance_factor", "C11", "C12", "C13", "C22", "C23", "C33")
> > 
> > names(umka.1) <- umka.names
> > 
> > str(umka.1)
> > ```
>

## Učitavanje podataka

> ### R paket `here`
> R paket `here` je namnjen navodjenju putanja unutar jednog direktorijuma u kojem ne kreiran `R` projekat **projektni** direktorijum. On omogućava kreiranje putanja koje su nezavisne od naziva foldera koji se mogu razlikovati od korisnika do korisnika, već navodi autora projekta da struktuira projektni folder i da pomoću komande `here` navodi funkcije koje zahtevaju putanje do fajlova. Veoma koristan tekst na tu temu se nalazi na sledećem linku [Project-Oriented Workflow](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/).
> 
> 
> ```r
> # install.packages("here")
> library(here)
> here()
> ```
> 
> ```
> ## [1] "C:/R_projects/Nauka_R/Slides"
> ```
> 
> Pomoću paketa `here` mogu se kreirati relativne putanje jednostavnom sintaksom.
> 
> 
> ```r
> here("data")
> ```
> 
> ```
> ## [1] "C:/R_projects/Nauka_R/Slides/data"
> ```
> 


> ### Zadatak 2
>
> - Učitati sve fajlove iz foldera `data/Umka_BG_24h` korišćenjem komande `here` i petlje `for`. (Fajlove učitati kao elemente liste)
> - Pregledati treći član liste
> - Proveriti dimenzije svih elemenata liste.
> - Dodeliti imena (umka.names) svakom elementu liste
> - Spojiti dva elementa liste u jedan `data.frame`
> - Spojiti sve elemente liste u jedan `data.frame` koristeći petlju `for`.
> - kreirati novu kolonu `high_GDOP` koja sadrži logički podatak da li je `GDOP` veci od 2.7.
> - Pregledati vrednosti kolone `GPS_quality` za vrednosti u kojima je kolona `high_GDOP` `TRUE`.
>
> > #### Rešenje zadatka 2
> > 
> > ```r
> > # Za potrebe učitavanja više fajlova, koristićemo petlju `for`. Svaka petlja `for` se sastoji iz tri komponente: rezultat (output), sekvenca (sequence), telo (body).
> > umka.data.list <- list()                                                   # 1. output
> > for(i in 1:length(umka.data)){                                             # 2. sequence
> >   umka.data.list[[i]] <- read.table(here("data", umka.data[i]), sep = ",") # 3. body
> > }
> > 
> > str(umka.data.list)
> > 
> > umka.data.list[[3]]
> > 
> > lapply(umka.data.list, dim)
> > 
> > for(i in 1:length(umka.data.list)){
> >   names(umka.data.list[[i]]) <- umka.names
> > }
> > 
> > 
> > umka12 <- rbind(umka.data.list[[1]], umka.data.list[[2]])
> > 
> > umka.df <- data.frame()
> > 
> > for(i in 1:length(umka.data.list)){
> >   umka.df <- rbind(umka.df, umka.data.list[[i]])
> > }
> > 
> > do.call(rbind, umka.data.list) # ?do.call
> > 
> > dim(umka.df)
> > 
> > umka.df$high_GDOP <- umka.df$GDOP > 2.6
> > 
> > umka.df[umka.df$high_GDOP, "GPS_quality"]
> > ```
>


### Učitavanje svih podataka




```r
##################################### Ucitavanje Umka_Bg vektor #####################################################
# Pregled sadržaja foldera Umka_BG_24h
umka_bg_files <- list.files(here::here("data", "Umka_BG_24h"))

# Vektor naziva kolona
umka.names <- c("header", "UTC_fix", "UTC_date", "latitude", "hemisphere", "longitude", "E/W", "GPS_quality", "n_satellites", "coord_quality", "antenna_altitude", "Altitude_units", "GDOP", "variance_factor", "C11", "C12", "C13", "C22", "C23", "C33")

# Kreiranje prazne liste
umka_bg_list <- list()

# Popunjavanje liste sadržajem fajlova
for(i in 1:length(umka_bg_files)){                                             
  umka_bg_list[[i]] <- read.table(here("data", "Umka_BG_24h", umka_bg_files[i]), sep = ",", na.strings = NA, fill = TRUE, header =  FALSE, col.names = umka.names) 
  }

umka_bg_df <- data.frame()
for(i in 1:length(umka_bg_list)){
  umka_bg_df <- rbind(umka_bg_df, umka_bg_list[[i]])
}

# Elegantnije rešenje:

umka_bg_df <- do.call(rbind, umka_bg_list)

umka_bg_df <- dplyr::bind_rows(umka_bg_list)

#################################### Ucitavanje Umka_Grocka vektor ###################################################

umka_gr_files <- list.files(here::here("data", "Umka_Grocka_24h"))

umka_gr_list <- list()                                                  
for(i in 1:length(umka_gr_files)){                                         
  umka_gr_list[[i]] <- read.table(here("data", "Umka_Grocka_24h", umka_gr_files[i]), sep = ",", na.strings = NA, fill = TRUE, header =  FALSE, col.names = umka.names)     # 3. body
}


umka_gr_df <- data.frame()
for(i in 1:length(umka_gr_list)){
  umka_gr_df <- rbind(umka_gr_df, umka_gr_list[[i]])
}

################################### Ucitavanje Umka_Indjija vektor ####################################################

umka_in_files <- list.files(here::here("data", "Umka_Indjija_24h"))

umka_in_list <- list()                                                       
for(i in 1:length(umka_in_files)){                                            
  umka_in_list[[i]] <- read.table(here("data", "Umka_Indjija_24h", umka_in_files[i]), sep = ",", na.strings = NA, fill = TRUE, header =  FALSE, col.names = umka.names)     # 3. body
}

umka_in_df <- data.frame()
for(i in 1:length(umka_in_list)){
  umka_in_df <- rbind(umka_in_df, umka_in_list[[i]])
}

###################################################################################################################
```


```r
# Spajanje svih u jedan data.frame
umka.df <- rbind(umka_bg_df, umka_gr_df, umka_in_df)

# Obelezavanje merenja koja imaju fixed i float resenje
# umka.df$GPS_quality <- factor(umka.df$GPS_quality, labels = c("fixed", "float"))

# Kreiranje atributa GPS_vector koji identifikuje pripadnost odredjenom vektoru
umka.df$GPS_vector <- factor(c(rep("Beograd", dim(umka_bg_df)[1]), rep("Grocka", dim(umka_gr_df)[1]), rep("Indjija", dim(umka_in_df)[1])))

# Izbacivanje merenja koja imaju NA vrednosti
umka.df <- umka.df[complete.cases(umka.df), ]

# Konverzija promenljive `n_satellites` u kategorijsku (faktor)
umka.df$n_satellites <- as.factor(umka.df$n_satellites)
```

### Konverzija `UTC_date` u datumski podatak

> ### Zadatak 3
>
> - Pregledati kolonu `UTC_date` i utvrditi `tip` podatka
> - Utvrditi problem i predloziti način konverzije
> - Kreirati funkciju koja transformise `UTC_date` kolonu u vremenski podatak.


```r
# UTC_date kolona ima format mmddyy
# umka.df$UTC_date

# Da bi se konvertovala u datum mora se opisati format

# Ali prethodno mora biti konvertovana u tekstualni podatak
# typeof(umka.df$UTC_date)

umka.df$UTC_date <- as.character(umka.df$UTC_date)

# Pojavljuje se drugi problem, neki zapisi imaju 5 karaktera: Jedan za mesece, dva za dane, dva za godine.

# Napraviti logicki vektor identifikuje vrste koje imaju 5 karaktera.
five_char <- nchar(umka.df$UTC_date) == 5

# Iskoristiti tu kolonu u selekciji i konverziji zapisa u 6-to karakterni
# Potrebno je dodati nulu ispred jednocifrenih meseci
# Komanda `paste` je iskorišćena za kreiranje tekstualnog podatka

umka.df$UTC_date[five_char] <- paste(0, umka.df$UTC_date[five_char], sep = "")

# Na kraju konverzija u datum se može uraditi komandom `as.Date()`

umka.df$UTC_date <- as.Date(umka.df$UTC_date, format = "%m%d%y")
```






## Priprema podataka za izravnanje GPS vektora

Cilj ove vezbe je uraditi izravnanje GPS vektora koji se sustiču u tački `Umka` i to u svakoj epohi, tj. za svaki ciklus merenja (u ovom slučaju to je na svakih 24h). Pre svega, treba imati u vidu da su merene veličine u stvari koordinatne razlike izmedju fiksnih tačaka (`Beograd`, `Grocka` i `Indjija`) i tačke `Umka`. Imajući to u vidu, potrebno da definišemo funkcionalni i stohastički model koji opisuje sistem merenih veličina preko nepoznatih parametara (koordinata tačke `Umka`). To podrazumeva kreiranje matrice modela (A matrica - ista za svaku epohu), kreiranje vektora merenih veličina (koordinatnih razlika) i vektora slobodnih članova (l i f - razlikuju se od epohe do epohe), kreiranje stohastičkog modela (Kl - razlikuje se od epohe do epohe). Za tim je potrebno primeniti algoritam MNK izravnanja na svaku epohu i oceniti koordinate. Pri tome, treba imati u vidu kako su podaci organizovani i kako ih pripremiti za primenu algoritma izravnanja. 

Imajući u vidu šta je sve potrebno pripremiti, šta je nepromenljivo od epohe do epohe, a šta se menja, logično je pripremiti podatke tako što ćemo proširiti `data.frame` `umka.df` kolonama koje sadrže elemente matrica koje se menjaju od epohe do epohe, a to su:

+ Približne vrednosti nepoznatih parametara
+ Rezultati merenja koordinatnih razlika
+ Približne vrednostima merenih veličina
+ Vektor slobodnih članova.

Za ovo su nam potrebni i vrednosti merenih koordinata u svakoj epohi i koordinate fiksnih tačaka (u pravouglom geocentričnom koordinatnom sistemu).

Nakon toga, moguće je primeniti algoritam MNK izravnanja na svaku vrstu `data.frame`-a `umka.df`.


Pre svega, potrebno je sagledati da li je za svaku epohu ispunjen uslov da postoje rezultati merenja tri vektora.

Da bi smo to uradili neophodno je uraditi pripremu podataka koja podrazumeva:

+ Promenu zapisa koordinata iz `stepmin,sec`, u decimalni zapis (`step+min/60+sec/3600`)
+ Transformaciju koordinata iz ($\phi, \lambda, h$) u $X,Y,Z$ (pravougle geocentrične)
+ Pripremiti podatke za kreiranje kovariacione matrice
+ Proširiti `data.frame` `umka.df` neophodnim podacima:
- Koordinate stanica Beograd, Grocka i Indjija (Učitati ih iz `excel` fajla)
- Merene koordinatne razlike (razlike koordinatana za svaku epohu)
- Približne koordinate tačke `Umka` za svaku epohu (izračunati kao sredinu koordinata iz tri vektora u svakoj epohi)
- Približne vrednosti merenih koordinatnih razlika
- Vrednosti vektora slobodnih članova


### Transformacija podataka korišćenjem `dplyr` paketa 


<img src="C:/R_projects/Nauka_R/Slides/Figures/datascience_workflow.png" width="70%" style="display: block; margin: auto;" />

Pored vizualizacije podataka, često je potrebno kreirati nove promenljive (atribute ili kolone), sumirati podatke u novu tabelu, reimenovati ili rasporediti podatke u tabeli. Za te potrebe razvijeni su brojni alati koji omogućavaju laku manupulaciju podacima, a najpoznatiji paket u R okruženju je `dplyr` paket iz `tidyverse` famijije paketa.

Da bi se koristio paket `dplyr` neophodno ga je instalirati. Medjutim, preporučuje se instalacija celog `tidyverse` paketa, koji uključuje celu grupu korisnih paketa.


```r
install.packages("tidyverse")
library(tidyverse)
```

`dplyr` paket ima nekoliko osnovnih funkcionalnosti koje rešavaju najčešće probleme, kao što su:

<center>
**selekcija pojedinačnih merenja (instanci ili vrsta u tabeli) komandom `dplyr::filter()`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/filter.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>

<center>
**selekcija atributa (kolona) komandom `dplyr::select()`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/rstudio-cheatsheet-select.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>

<center>
**Kreiranje novih promenljivih komandom `dplyr::mutate()`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/mutate.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>


<center>
**Sumiranje podataka komandom `dplyr::summarise()`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/summarise.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>

<center>
**Grupisanje podataka `dplyr::group_by()` (često u kombinaciji sa `summarise`)**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/group_by.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>


<center>
**Kombninovanje (spajanje) tabela komandom `dplyr::_join`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/combine-options1.png" width="70%" style="display: block; margin: auto;" />

</br></br></br></br></br>


<center>
**Sortiranje podataka komandom `dplyr::arrange()`**
</center>


<img src="C:/R_projects/Nauka_R/Slides/Figures/reorder-data-frame-rows-in-r.png" width="70%" style="display: block; margin: auto;" />
</br></br></br></br></br>

## Primena funkcionalnosti `dplyr` paketa

#### Promena zapisa koordinata iz `stepmin,sec`, u decimalni zapis (`step+min/60+sec/3600`)

Imajući u vidu specifikaciju [NMEA](https://www.gpsinformation.org/dale/nmea.htm) podataka, koordinate zapisane u obliku `stepmin,decmin` (na primer `4807.038,N   Latitude 48 deg 07.038' N`). Prema tome, neophodno je promeniti zapis koordinata u standardni decimalni zapis u stepenima.


```r
options(digits = 12)

lat1 <- umka.df[1, "latitude"]

lat1

# operator %% izdvaja ostatak u rezultatu deljenja
lat1%%100 # u ovom slučaju ostatak je broj minuta u decimalnom zapisu.

# operator %/% izdvaja ceo broj u rezultatu deljenja
lat1%/%100 # u ovom slucaju ceo broj predstavlja broj stepeni

# ostaje da se broj minuta u decimalnom zapisu pretvori u broj stepeni u decimalnom zapisu i da se doda na ceo broj stepeni.

umka.df$latitude <- umka.df$latitude%/%100+umka.df$latitude%%100/60

umka.df$longitude <- umka.df$longitude%/%100+umka.df$longitude%%100/60
```


#### Transformacija koordinata iz ($\phi, \lambda, h$) u $X,Y,Z$ (pravougle geocentrične).

Da bi se izvršila transformacija u koordinata iz ($\phi, \lambda, h$) u $X,Y,Z$ (pravougle geocentrične) neophodno je napraviti funkciju koja implementira sledeće relacije koja se definiše odnos koordinata:

$$ X=(N+h) \times cos(\phi) \times cos(\lambda) $$
$$ Y=(N+h) \times cos(\phi) \times sin(\lambda) $$


$$ Z=(\dfrac{b^2}{a^2} \times N+h) \times sin(\phi) $$ 


gde je $N$ radijus krivine po prvom vertikalu koji se može dobiti kao

$$ N=\dfrac{a^2}{\sqrt{a^2 \times cos(\phi)^2 + b^2 \times sin(\phi)^2}} $$



a $a=6378137m$ i $b=6356752.3142$ su poluose elipsoida. $h$ smatrati elipsoidnom visinom.



```r
a <- 6378137
b <- 6356752.3142

# Koriščenje komande `mutate`
umka.df <- umka.df %>% mutate(., N = (a^2)/sqrt((a^2)*(cos(latitude*pi/180))^2+(b^2)*(sin(latitude*pi/180))^2),
                      X = (N+antenna_altitude)*cos(latitude*pi/180)*cos(longitude*pi/180),
                      Y = (N+antenna_altitude)*cos(latitude*pi/180)*sin(longitude*pi/180),
                      Z = ((b^2/a^2)*N+antenna_altitude)*sin(latitude*pi/180))
```

#### Proširiti `umka.df` `data.frame`-a neophodnim podacima

Određivanje datuma u kojima postoje merenja sva tri vektora primenom komandi `broup_by`, `count()` i `filter()` i sortiranje podataka komandom `arrange`. 

**Obrati pažnju na operator `%<>%`**

```r
common_dates <- umka.df %>% group_by(UTC_date) %>% count() %>% filter(n == 3)


umka.df %<>% filter(UTC_date %in% common_dates$UTC_date) %>% dplyr::arrange(UTC_date)
```


Učitavanje podataka (koordinata fiksnih tačaka) iz `excel` fajla korišćenjem `readxl` paketa, reimenovanje komandom `rename` i promena tipa podatak komandom `mutate_if`.

```r
# readxl + dplyr::rename + mutate_of
stations <- readxl::read_xlsx("./Data/Stations.xlsx") %>% 
            dplyr::rename(GPS_vector = Station, Xs = X, Ys = Y, Zs = Z) %>%
            mutate_if(is.character, factor)
```


Sumiranje podataka kombinovanjem komandi `group_by` i `summarize` u cilju odredjivanja približnih koordinata sa svaku epohu.

```r
# group_by + summarize

# Za svaku epohu naci priblizne vrednosti (najbolje uzeti sredinu svih vektora u svakoj epohi)
coord_0 <- umka.df %>% group_by(UTC_date) %>% summarize(X0 = mean(X), Y0 = mean(Y), Z0 = mean(Z)) %>% ungroup()
```


Kreiranje novih kolona sa podacima koji se menjaju od epohe do epohe korišćenjem komandi  `mutate` i `full_join`. 

```r
umka.df <- dplyr::full_join(umka.df, coord_0, by = "UTC_date") %>% 
           dplyr::full_join(., stations, by = "GPS_vector" ) %>%
           mutate(dx0 = X0 - Xs, # problizna koordinatna razlika
                  dy0 = Y0 - Ys,
                  dz0 = Z0 - Zs,
                  dx = X - Xs, # merena koordinatna razlika
                  dy = Y - Ys,
                  dz = Z - Zs,
                  fx = dx0 - dx, # priblizno - mereno
                  fy = dy0 - dy,
                  fz = dz0 - dz)
```


```r
# Select

umka.df %<>% mutate(id = row_number()) %>% dplyr::select(id, GPS_vector, UTC_date, latitude, longitude, antenna_altitude, coord_quality, variance_factor, starts_with("C"), X, Y, Z, X0, Y0, Z0, Xs, Ys, Zs, dx0, dy0, dz0, dx, dy, dz, fx, fy, fz)
```


## Split-Apply-Combine

`Split-Apply-Combine` strategija, kao što joj samo ime kaže, podrazumeva podelu jednog "repetativnog" problema na više manjih i istovremeno rešavanje manjih problema primenom odgovarajuće operacije. Strategija se završava objedinjavanjem rezultata. Cilj ove strategije je ušteda u vremenu i resursima, kao i bolji uvid u sam tok kalkulacije koja treba da se izvrši nad velikim setom podataka. Važan korak u primeni `Split-Apply-Combine` strategije je prepoznavanje mogućnosti primene i kada je ona uopšte korisna. U našem slučaju, očigledno je da se problem izravnanja vektora može razložiti na epohe.  


```r
# Kreiranje model matrice

amat <- diag(c(1,1,1), ncol = 3)
A <- rbind(amat, amat, amat)
```
#### Kreiranje kovariacione matrice


```r
head(umka.df[, c("C11","C12","C13","C22","C23","C33")])
```
     
Primetimo da je element `C33`neophodno odvojiti od ostatka `*Checksum`. To ćemo uraditi komandom `separate` iz paketa `tidyr`. 

```r
umka.df %<>% tidyr::separate(C33, sep = "\\*", into = c("C33", "Checksum"))
```

Kovariaciona matrica ima formu blok-matrice koju čine tri medjusobno nezavisne matrice za svaki vektor. 


```r
umka_1 <- umka.df[1:3, ] # Jedna epoha

umka_1[1, c("C11","C12","C13","C22","C23","C33")] # Elementi kovariacione matrice jednog vektora

class(umka_1[1, c("C11","C12","C13","C22","C23","C33")]) 

as.numeric(umka_1[1, c("C11","C12","C13","C22","C23","C33")])
```


Napravićemo funkciju koja ima jedan argument, a to je vektor od 6 elemenata gornjeg ili donjeg trougla kofaktorske matrice i kreira  matricu dimenzija `3x3`.  

```r
covmat <- function(x){
  cov.mat <- matrix(NA, ncol = 3, nrow = 3)
  cov.mat[upper.tri(cov.mat, diag = TRUE)] <- x
  cov.mat[lower.tri(cov.mat, diag = FALSE)] <- x[c(2,4,5)]
  return(cov.mat)
}

# ?upper.tri

covmat(x = as.numeric(umka_1[1, c("C11","C12","C13","C22","C23","C33")]))
```

Za tim je potrebo iskoristiti prethodnu funkciju za potrebe kreiranja blok kovariacione matrice koja opisuje stohastičke relacije merenih veličina. Preciznije rečeno, potrebno je napraviti matricu `9x9` koja na diagonali ima matrice pojedinacnih vektora. Naravno, pošto su dati elementi kofaktorske matrice, potrebno ih je pomnožiti sa *a posteriori* varijans vaktorom (`variance_factor`). 


```r
umka_1$variance_factor


blokcov <- function(y){
  blok1 <- covmat(x = as.numeric(y[1, c("C11","C12","C13","C22","C23","C33")])) # Beograd
  blok2 <- covmat(x = as.numeric(y[2, c("C11","C12","C13","C22","C23","C33")])) # Grocka
  blok3 <- covmat(x = as.numeric(y[3, c("C11","C12","C13","C22","C23","C33")])) # Indjija
  blok_cov_mat <- bdiag(y$variance_factor[1]^2*blok1, y$variance_factor[2]^2*blok2, y$variance_factor[3]^2*blok3)
  return(blok_cov_mat)
}

blokcov(y = umka_1)
```

### Algoritam MNK izravnanja


```r
# options(digits = 12)

# Kovariaciona matrica:
Kl <- blokcov(umka_1)

# Kofaktorska matrica nepoznatih parametara
Qx <- solve(t(A)%*%solve(Kl)%*%A)

# Vektor slobodnih članova
fl <-  c(umka_1$fx, umka_1$fy, umka_1$fz)  #umka_1 %>% dplyr::select(fx, fy, fz) %>% unlist()  ili  unlist(umka_1[, c("fx", "fy", "fz")])

# vektor koeficijenata slobodnih  članova normalnih jednačina
n <- t(A)%*%solve(Kl)%*%fl

# Ocena nepoznatih parametara
dx <- -1*Qx%*%n

# Ocena koordinata
Xoc <- c(umka_1$X0[1], umka_1$Y0[1], umka_1$Z0[1]) + dx  #(umka_1 %>% dplyr::select(X0, Y0, Z0) %>% unlist()) + dx  ili  unlist(umka_1[1, c("X0", "Y0", "Z0")]) + dx

# Vektor popravaka
v <- A%*%dx + fl

# Ocena disperzionog faktora
s <- sqrt((t(v)%*%solve(Kl)%*%v)/6)

# Ocena preciznosti nepoznatih parametara
sx <- s%*%sqrt(diag(Qx))

# Objedinjavanje rezultata
coords <- c(as.numeric(Xoc), as.numeric(sx)) %>% round(., 3)
```


### Primena `Split-Apply-Combine`

```r
adjust <- function(z){
  Kl <- blokcov(z)
  Qx <- solve(t(A)%*%solve(Kl)%*%A)
  fl <-  c(z$fx, z$fy, z$fz)  #umka_1 %>% dplyr::select(fx, fy, fz) %>% unlist()      #unlist(umka_1[, c("fx", "fy", "fz")])
  n <- t(A)%*%solve(Kl)%*%fl
  dx <- -1*Qx%*%n
  Xoc <- c(z$X0[1], z$Y0[1], z$Z0[1]) + dx  #(umka_1 %>% dplyr::select(X0, Y0, Z0) %>% unlist()) + dx #unlist(umka_1[1, c("X0", "Y0", "Z0")]) + dx
  v <- A%*%dx + fl
  s <- sqrt((t(v)%*%solve(Kl)%*%v)/6)
  sx <- s%*%sqrt(diag(Qx))
  coords <- c(as.numeric(Xoc), as.numeric(sx)) %>% round(., 3)
  return(coords)
}
```


```r
umka.df <- umka.df %>% 
  split(f = factor(.$UTC_date)) %>% 
  lapply(., function(x) results = adjust(x)) %>% do.call(rbind, .) %>% 
  as.data.frame(.) %>% 
  dplyr::rename_all(.,  list(~c("X", "Y", "Z", "sx", "sy", "sz"))) %>% 
  tibble::rownames_to_column("UTC_date") %>%
  dplyr::mutate_if(is.character, as.Date) %>%
  dplyr::right_join(., dplyr::select(umka.df, -c("X", "Y", "Z")))



# https://stackoverflow.com/questions/31431322/run-a-custom-function-on-a-data-frame-in-r-by-group

# umka.df %>% group_by(UTC_date) %>% group_map(~tibble(results = adjust(.)))

# umka.df %>% group_by(UTC_date) %>% do(results = adjust(.)) # list columns

geocent2latlong <- function(xyz){
  x = xyz[1]; y = xyz[2]; z = xyz[3]
  a <- 6378137.0
  b <- 6356752.3142
  e <- sqrt((a^2-b^2)/a^2)
  lambda <- atan(y/x)
  fi_0 <- atan(z/sqrt(x^2+y^2))
  iteracije <- as.list(rep(NA,10))
   for(i in 1:10){
    N_0 <- a/sqrt(1-e^2*(sin(fi_0))^2)
    h_0 <- (sqrt(x^2+y^2)/cos(fi_0))-N_0
    fi_0 <- atan((z/sqrt(x^2+y^2))*(1-N_0*e^2/(N_0+h_0))^(-1))
    iteracije[[i]] <- c(lambda*180/pi,fi_0*180/pi,h_0)
   }
  return(iteracije[[10]])
}

umka.df <- umka.df.adjust %>% 
  dplyr::select(UTC_date, X, Y, Z) %>%
  split(f = factor(.$UTC_date)) %>% 
  lapply(., function(x) results = geocent2latlong(xyz = x[-1])) %>% 
  do.call(rbind, .) %>%
  as.data.frame() %>%
  tibble::rownames_to_column("UTC_date") %>%
  dplyr::rename_all(.,  list(~c("UTC_date", "latitude", "longitude", "h"))) %>%
  dplyr::mutate_if(is.character, as.Date) %>% unnest() %>%
  dplyr::right_join(., dplyr::select(umka.df, -c("latitude", "longitude")))


umka.df <- cbind(umka.df, umka.df.latlong)

write.csv(umka.df, "umka.df.csv")

writexl::write_xlsx(aa, "umka.df.xlsx")
```




















