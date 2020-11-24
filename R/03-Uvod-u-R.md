---
title: "Uvod u R"
subtitle: Kontrola toka i oblikovanje podataka
author:
   - "Milutin Pejovic, Petar Bursac"
date: "24 November 2020"
output:
   html_document:
     keep_md: true
     theme: "simplex"
     highlight: tango
     toc: true
     toc_depth: 5
     toc_float: true
     fig_caption: yes
---

# Kontrola toka u R-u

U okviru ovog predavanja upoznaćemo se sa mogućnostima kontrole toka i automatizacije izvršavanja komandi primenom komandi `if` i `for`. 

## `if` - grananje toka 

Komanda `if` omogućava da postavimo uslov kojim će izvršavanje neke komande zavisiti od rezultata nekog logičkog upita. Na taj način moguće je stvoriti razgranatu strukturu toka izvršavanja komandi (algoritma). Komanda `if` se koristi na sledeći način:

$$if(condition) \quad \textrm{{true_expression}} \quad elsе \quad \textrm{{false_expression}}$$ 

Na primer, ukoliko promenljiva `x` sadrži numerički podatak, podeliti ga sa 2, a ukoliko je neki drugi podatak ispisati "Nije moguće izvršiti komandu jer x ne sadrži numerički podatak"




```r
x <- 5
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")
```

```
## [1] 2.5
```

```r
x <- "a"
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")
```

```
## [1] "Nije moguce izvršiti komandu jer x ne sadrži numericki podatak"
```


Ukoliko ne postoji određena operacija koja se uzvršava u slučaju `else`, nije potrebno pisati taj deo. Na primer:



```r
x <- 5
if(is.numeric(x)) x/2 
```

```
## [1] 2.5
```

```r
x <- "a"
if(is(x, "numeric")) x/2 
```


Međutim, pravi smisao `if` komande se vidi tek kada očekujemo da prilikom izvršavanja niza komandi računar sam odluči šta treba uraditi u određenom trenutku u zavisnosti od ulazinih parametara. 


## `for` petlja

`for` petlja se koristi kada želimo da automatizujemo izvršavanje neke komande ili niza komandi određeni broj puta. `for` petlja se koristi na sledeći način:

$$ for(i \quad in \quad list) \quad \textrm{{expression}} $$

Na primer, ako želimo da podacima `studenti` dodamo jednu kolonu pod nazivom "ispit" u vidu logičkog vektora koji će sadržati vrednost TRUE za studente koji su položili oba ispita (IG1 i Praksu) i FALSE za one koji nisu.





```r
studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE, stringsAsFactors = FALSE)

studenti$ispit <- NA # Prvo cemo kreirati kolonu "ispit" koja ima sve NA vrednosti

 
# Komanda dim(studenti) vraca broj dimenzija, prvi se odnosi na broj vrsta.
dim(studenti)
```

```
## [1] 35 15
```

```r
for(i in 1:dim(studenti)[1]){ 
  # Sekvenca `1:dim(studenti)[1]` sadrzi niz brojeva od 1 do ukupnog broja vrsta u data.frame-u studenti.
  # i ide kroz svaku vrstu data.frame-a `studenti`
  studenti$ispit[i] <- if(is.na(studenti$Ocena[i]) | is.na(studenti$Praksa[i])){FALSE}else{TRUE}
}  

head(studenti, 15)
```

```
##    ID         Prezime        Ime br.ind god.upisa kol.1 kol.2 kol.1.1 kol.2.2
## 1   1       Antonijev      Boris   1035        16    NA    NA      NA      NA
## 2   2          Arvaji       Luka   1020        17    NA    NA      NA      NA
## 3   3           Babic     Stefan   1051        16     0    NA      NA      NA
## 4   4          Beljin      Miloš   1019        17     0    NA      NA      NA
## 5   5 Božic Krajišnik     Stefan   1041        16     0    NA      NA      NA
## 6   6           Brkic Aleksandar   1038        17     0    60      55      NA
## 7   7         Vasovic Aleksandar   1031        17    40    85     100      NA
## 8   8           Vucic      Boban   1018        17    NA    NA      NA      NA
## 9   9       Garibovic      Tarik   1027        17     0    NA      NA      NA
## 10 10          Gordic     Nataša   1015        17     0    NA      NA      NA
## 11 11        Grujovic   Katarina   1042        15    NA    NA      NA      NA
## 12 12    Dimitrijevic      Jovan   1040        17    45    95      10      NA
## 13 13         Jovicic  Andrijana   1012        17    30    NA      NA      NA
## 14 14           Kocic     Danilo   1024        17     0    90     100      NA
## 15 15           Kocic     Stefan   1035        17     0    NA      NA      NA
##    Januar Februar Jun Ocena Praksa ispit
## 1      NA      40  51     7      9  TRUE
## 2      NA      NA  NA    NA     NA FALSE
## 3      NA      NA 100     7      8  TRUE
## 4      NA      10 100     8      8  TRUE
## 5      NA     100  NA     7      8  TRUE
## 6      NA      NA  NA     7     NA FALSE
## 7      NA      NA  NA     8      9  TRUE
## 8      NA       8  70     6      8  TRUE
## 9      NA      NA 100     6     NA FALSE
## 10     NA      82  NA     8      7  TRUE
## 11     NA      NA  90     8      8  TRUE
## 12     NA      80  NA     8      8  TRUE
## 13     NA      92  NA     8      8  TRUE
## 14     NA      NA  NA     9      9  TRUE
## 15     NA      24 100     9      8  TRUE
```

```r
sum(studenti$ispit) # Koliko studenata je polozilo oba ispita
```

```
## [1] 31
```

         
              
> <h3>Zadatak</h3>

> Potrebno je oblikovati fajl sa podacima nivelanja geometrijskim nivelmanom. Fajl sadrži sledeće informacije:
 
> > + Prva kolona: tacka - sadrzi imena repera i veznih tačaka. Reperi su B1, B3, B4 i B5, a vezne tacke su 1:n.

> > + Druga kolona: merenje - sadrži čitanja na letvi.

> > + Treća kolona: duzina - sadrži merenu dužinu od instrumenta do letve.

> U zadatku se traži sledeće:
> 1. Učitati podatke

> 2. Kreirati `data.frame` sa sledećim kolonama: od, do, dh i dužina. Pri tome, treba imati u vidu da je na svakoj stanici merena visinska razlika po principu zadnja-prednja-prednja-zadnja. To znači da svakoj stanici pripada po četiri reda izvornih podataka. Rezultujući `data.frame` treba da sadrži po jedan red po stanici, koji će u prvoj koloni ("od") imati "zadnju" tačku, u drugoj koloni ("do") imati prednju tačku, u trećoj koloni ("dh") imati srednju visinsku razliku sračunatu iz čitanja na letvi i u poslednjoj koloni ("duzina") imatu srednju dužinu od letve do letve sračunatu iz merenih dužina. Prilikom rada, pokušajte da se vodite sledećim principima:


> > *Generalna preporuka je da podelite zadatak na više manjih zadataka. Na primer, izdvojite podatke za samo jednu stanicu i pokušajte da kreirate željeni `data.frame` sa podacima samo jedne stanice. Uvidite šta su problemi u tom slučaju. Na početku, napravite rezultujući `data.frame` koji će sadržati samo `NA` vrednosti koje će biti zamenjene vrednostima koje treba da sadrži. Taj `data.frame` će imati broj redova onoliko koliko ima stanica i četiri kolone. Za te potrebe možete koristiti komandu `rep(NA, broj stanica)` za svaku kolonu `data.frame`-a. Komanda `rep` (repeat) pravi vektor određene dužine od vektora (sa jednom ili više) vrednosti. Za tim u taj `data.frame` upišite vrednosti koje izračunate ili isčitate iz ulaznih podataka. Kada rešite problem za jednu stanicu, razmislite kako ćete to automatizovati koristeći petlju `for`. Tu je preporuka da u ulaznim podacima napravite još jednu kolonu (faktorsku) koja će označiti koji red pripada kojoj stanici. Pa zatim, transformisati ulazne podatke u `list`-u prema toj promenljivoj i onda u okviru petlje `for`, na svaki član liste primeniti korake koje ste smislili kada ste rešavali samo jednu stanicu.*

> 3. Za tim, potrebno je rezultujući `data.frame` dodatno transformisati (sumirati) tako da sadrži samo merenja od repera do repera, sa sledećim kolonama: od (reper), do (reper), dh (ukupna visinska razlika između repera), n (broj stanica od repera do repera) i duzina (ukupna duzina od repera do repera).

## Prvi način - korišćenjem petlje `for`

### Kreiranje prve tabele - visinske razlike po stanici



```r
# Ucitavanje merenja
merenja <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/nivelman.txt", header = TRUE, sep = ",", stringsAsFactors = FALSE)

# Kreiranje pomocne kolone (faktorske) koja pokazuje pripadnost redova stanici
merenja$stanica <- factor(rep(1:(dim(merenja)[1]/4), each = 4))

# Kreiranje liste prema pomocnoj faktorskoj promenljivoj (stanica)
merenja_list <- split(merenja, merenja$stanica)

# Kreiranje praznog data.frame-a
merenja_df <- data.frame( od = rep(NA, length(merenja_list)), 
                          do = rep(NA, length(merenja_list)), 
                          dh = rep(NA, length(merenja_list)), 
                          duzina = rep(NA, length(merenja_list)))

# popunjavanje data.frame-a
for(i in 1:length(merenja_list)){
  merenja_df$od[i] <- as.character(merenja_list[[i]]$tacka[1])
  merenja_df$do[i] <- as.character(merenja_list[[i]]$tacka[2])
  merenja_df$dh[i] <- ((merenja_list[[i]]$merenje[1]-merenja_list[[i]]$merenje[2])+(merenja_list[[i]]$merenje[4]-merenja_list[[i]]$merenje[3]))/2
  merenja_df$duzina[i] <- sum(merenja_list[[i]]$duzina)/2 
}

merenja_df
```

```
##    od do        dh duzina
## 1  B1  1 -0.973905 51.185
## 2   1  2  0.006950 47.885
## 3   2  3 -0.121490 49.485
## 4   3  4 -0.035755 50.790
## 5   4 B3  0.125845 48.295
## 6  B3  1 -0.035680 49.735
## 7   1  2 -0.220535 47.665
## 8   2  3 -0.125240 48.165
## 9   3  4  0.060390 45.570
## 10  4 B4  0.082415 30.905
## 11 B4  1 -0.088360 50.930
## 12  1  2  0.025690 47.290
## 13  2 B5  0.208125 40.605
## 14 B5  1 -0.058110 49.855
## 15  1  2  0.084720 49.980
## 16  2  3 -0.080190 49.400
## 17  3  4  0.431440 51.160
## 18  4  5 -0.319645 49.920
## 19  5  6  0.009700 48.270
## 20  6  7  0.043795 49.850
## 21  7 B1  0.981210 61.770
```

Kreiranje fajla


```r
writexl::write_xlsx(merenja_df, path = "merenja_df.xlsx")
```


### Kreiranje sumarne tabele - visinske razlike od repera do repera


```r
reperi <- c("B1", "B3", "B4", "B5")

merenja_df$isReperOD <- merenja_df$od %in% reperi
merenja_df$isReperDO <- merenja_df$do %in% reperi


# broj vis razlika izmedju repera
ndh <- sum(merenja_df$isReperOD)

#indeks pozicije "od" repera,
ind.od <- which(merenja_df$isReperOD == T)
# indeks pozicije "do" repera
ind.do <- which(merenja_df$isReperDO == T)

# Visinske razlike

# Naziv "od" repera
od <- merenja_df$od[ind.od]

# Naziv "do" repera
do <- merenja_df$do[ind.do]

# Racunanje visinskih razlika od repera do repera
dh <- rep(NA, ndh)

for(i in 1:ndh){
  dh[i] <- sum(merenja_df$dh[ind.od[i]:ind.do[i]])
}

# Racunanje broja stanica od repera do repera
n <- rep(NA, ndh)

for(i in 1:ndh){
  n[i] <- length(ind.od[i]:ind.do[i])
}

# Racunanje duzina od repera do repera
duzina <- rep(NA, ndh)

for(i in 1:ndh){
  duzina[i] <- sum(merenja_df$duzina[ind.od[i]:ind.do[i]])
}

# Kreiranje data.frame-a
merenja_df_sum <- data.frame(od = od, do = do, dh = dh, n = n, duzina = duzina)


merenja_df_sum
```

```
##   od do        dh n  duzina
## 1 B1 B3 -0.998355 5 247.640
## 2 B3 B4 -0.238650 5 222.040
## 3 B4 B5  0.145455 3 138.825
## 4 B5 B1  1.092920 8 410.205
```

Kreiranje fajla


```r
writexl::write_xlsx(merenja_df_sum, path = "merenja_df_reperi.xlsx")
```


# Transformacija podataka korišćenjem `dplyr` paketa 



Kao što ste već videli, oblikovanje podataka često podrazumeva kreiranje novih promenljivih (atribute ili kolone), sumiranje podataka u novu tabelu, reimenovati ili rasporediti podatke u tabeli. Za te potrebe razvijeni su brojni alati koji omogućavaju laku manupulaciju podacima, a najpoznatiji paket u R okruženju je `dplyr` paket iz `tidyverse` famijije paketa. Da bi se koristio paket `dplyr` neophodno ga je instalirati. Medjutim, preporučuje se instalacija celog `tidyverse` paketa, koji uključuje celu grupu korisnih paketa.


<img src="C:/R_projects/Nauka_R/Slides/Figures/tidyverse-logo.png" width="25%" style="display: block; margin: auto;" />



<img src="C:/R_projects/Nauka_R/Slides/Figures/tidyverse_website.png" width="70%" style="display: block; margin: auto;" />



Instalacija `tidyverse` paketa


```r
install.packages("tidyverse")
library(tidyverse)
```



`dplyr` paket ima nekoliko osnovnih funkcionalnosti koje rešavaju najčešće probleme, kao što su:

**selekcija pojedinačnih merenja (instanci ili vrsta u tabeli) komandom `dplyr::filter()`**


<img src="C:/R_projects/Nauka_R/Slides/Figures/filter.png" width="70%" style="display: block; margin: auto;" />


**selekcija atributa (kolona) komandom `dplyr::select()`**
  

<img src="C:/R_projects/Nauka_R/Slides/Figures/rstudio-cheatsheet-select.png" width="70%" style="display: block; margin: auto;" />

    
     
**Kreiranje novih promenljivih komandom `dplyr::mutate()`**      
       

<img src="C:/R_projects/Nauka_R/Slides/Figures/mutate.png" width="70%" style="display: block; margin: auto;" />

         

**Sumiranje podataka komandom `dplyr::summarise()`**


<img src="C:/R_projects/Nauka_R/Slides/Figures/summarise.png" width="70%" style="display: block; margin: auto;" />



**Grupisanje podataka `dplyr::group_by()` (često u kombinaciji sa `summarise`)**


<img src="C:/R_projects/Nauka_R/Slides/Figures/group_by.png" width="70%" style="display: block; margin: auto;" />



**Kombninovanje (spajanje) tabela komandom `dplyr::_join`**


<img src="C:/R_projects/Nauka_R/Slides/Figures/combine-options1.png" width="70%" style="display: block; margin: auto;" />



**Sortiranje podataka komandom `dplyr::arrange()`** 


<img src="C:/R_projects/Nauka_R/Slides/Figures/reorder-data-frame-rows-in-r.png" width="70%" style="display: block; margin: auto;" />



  
## Drugi način - korišćenjem `dplyr` paketa





```r
library(tidyverse)
library(magrittr)

# Ucitavanje merenja
merenja <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/nivelman.txt", header = TRUE, sep = ",", stringsAsFactors = FALSE)

merenja_df <- merenja %>% 
  dplyr::mutate(stanica = factor(rep(1:(dim(merenja)[1]/4), each = 4))) %>%  # Kreiranje novih kolona
  dplyr::group_by(stanica) %>% # grupisanje podataka prema nekoj promenljivoj
  dplyr::summarise(od = as.character(tacka[1]), # sumiranje podataka
                   do = as.character(tacka[2]),
                   dh = ((merenje[1]-merenje[2])+(merenje[4]-merenje[3]))/2,
                   duzina = sum(duzina)/2)

merenja_df
```

```
## # A tibble: 21 x 5
##    stanica od    do          dh duzina
##    <fct>   <chr> <chr>    <dbl>  <dbl>
##  1 1       B1    1     -0.974     51.2
##  2 2       1     2      0.00695   47.9
##  3 3       2     3     -0.121     49.5
##  4 4       3     4     -0.0358    50.8
##  5 5       4     B3     0.126     48.3
##  6 6       B3    1     -0.0357    49.7
##  7 7       1     2     -0.221     47.7
##  8 8       2     3     -0.125     48.2
##  9 9       3     4      0.0604    45.6
## 10 10      4     B4     0.0824    30.9
## # ... with 11 more rows
```



> <h3>Obrati pažnju na `%>%` </h3>
> Operator `%>%` (`pipe`) je moćan operator koji nam omogućava da sekvencijalno povezujemo operacije i da na taj način izbegnemo kreiranje nepotrebnih promenljivih. `Pipe` je dostupan preko paketa `magrittr`, što znači da je potrebno instalirati paket `magrittr` ako želimo da koristimo `pipe`. Međutim, `pipe` je takođe dostupan preko `tidyverse` paketa. Više detalja na [linku](https://r4ds.had.co.nz/pipes.html).
 
  
### Kreiranje sumarne tabele - visinske razlike od repera do repera
                   


```r
reperi <- c("B1", "B3", "B4", "B5")

merenja_df <- merenja_df %>% dplyr::mutate(isReperOD = merenja_df$od %in% reperi,
                             isReperDO = merenja_df$do %in% reperi)



#indeks pozicije "od" repera,
ind.od <- which(merenja_df$isReperOD == T)
# indeks pozicije "do" repera
ind.do <- which(merenja_df$isReperDO == T)  

# broj vis razlika izmedju repera
ndh = sum(merenja_df$isReperOD)

# Promenljiva koja pokazuje koja merenja pripadaju odredjenom nivelmanskom vlaku
vlak <- c()
for(i in 1:ndh){
  vlak <- c(vlak, rep(i, ind.do[i]-(ind.od[i]-1)))
}

merenja_df$vlak <- factor(vlak) 

# Sumiranje visinskih razlika po vlaku
merenja_df %>% dplyr::select(od, do, dh, duzina, vlak) %>%
               dplyr::group_by(vlak) %>% 
               dplyr::summarize(dh_mean = sum(dh))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 4 x 2
##   vlak  dh_mean
##   <fct>   <dbl>
## 1 1      -0.998
## 2 2      -0.239
## 3 3       0.145
## 4 4       1.09
```

```r
# Sumiranje visinskih razlika po vlaku sa dodatnim kolonama
merenja_df_sum <- merenja_df %>% dplyr::select(od, do, dh, duzina, vlak) %>%
                                 dplyr::group_by(vlak) %>% 
                                 dplyr::summarize(od = od[1],
                                                  do = do[length(vlak)],
                                                  dh = sum(dh),
                                                  stanica = n())
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
merenja_df_sum
```

```
## # A tibble: 4 x 5
##   vlak  od    do        dh stanica
##   <fct> <chr> <chr>  <dbl>   <int>
## 1 1     B1    B3    -0.998       5
## 2 2     B3    B4    -0.239       5
## 3 3     B4    B5     0.145       3
## 4 4     B5    B1     1.09        8
```

# Kreiranje funkcija

R omogućava kreranje funkcija koje nam omogućavaju da automatizujemo određene korake u našem algoritmu. Kreiranje funkcija je poželjno u slučajevima kada imamo određeni deo koda koji je potrebno ponoviti više puta. Na taj način, umesto da kopiramo kod više puta, moguće je kreirati funkciju koja će izvršiti taj deo koda pozivanjem kreirane funkcije. Generalno, kreiranje funkcija se sastoji iz tri koraka:

+ Dodeljivanje `imena`
+ Definisanje `argumenata`
+ Programiranje `tela` funckije (body) koje se sastoji od koda koji treba da se izvrši

Na primer ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u stepenima u radijane, to ćemo učiniti na sledeći način



```r
step2rad <- function(ang_step){
  ang_step*pi/180
}

step2rad(180)
```

```
## [1] 3.141593
```

Ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u zapis step-min-sec to ćemo uraditi na sledeći način:


```r
dec2dms <- function(ang){ # ime funkcije je `dec2dms`, a argument `ang`
  deg <- floor(ang) 
  minut <- floor((ang-deg)*60)
  sec <- ((ang-deg)*60-minut)*60
  return(paste(deg, minut, round(sec, 0), sep = " "))
}

dec2dms(ang = 35.26589)
```

```
## [1] "35 15 57"
```

```r
dec2dms(45.52658)
```

```
## [1] "45 31 36"
```


Ukoliko želimo da napravimo funkciju od koda koji smo kreirali za potrebe oblikovanja ulaznih podataka to ćemo uraditi na sledeći način. 
   


```r
merenja <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/nivelman.txt", header = TRUE, sep = ",", stringsAsFactors = FALSE)

nivelman <- function(niv_merenja, reperi){ # ime funkcije je nivelman, a argumenti niv_merenja (ulazna merenja) i reperi (naziv repera)
  
  # kopiramo kod koji smo kreirali ()
  merenja_df <- niv_merenja %>% dplyr::mutate(stanica = factor(rep(1:(dim(niv_merenja)[1]/4), each = 4))) %>% 
    dplyr::group_by(stanica) %>%
    dplyr::summarise(od = as.character(tacka[1]),
                     do = as.character(tacka[2]),
                     dh = ((merenje[2]-merenje[1])+(merenje[3]-merenje[4]))/2,
                     duzina = sum(duzina)/2)
  
  merenja_df <- merenja_df %>% dplyr::mutate(isReperOD = merenja_df$od %in% reperi,
                                             isReperDO = merenja_df$do %in% reperi)
  
  #indeks pozicije "od" repera,
  ind.od <- which(merenja_df$isReperOD == T)
  # indeks pozicije "do" repera
  ind.do <- which(merenja_df$isReperDO == T)  
  
  # broj vis razlika izmedju repera
  ndh = sum(merenja_df$isReperOD)
  
  # Promenljiva koja pokazuje koja merenja pripadaju odredjenom nivelmanskom vlaku
  vlak <- c()
  for(i in 1:ndh){
    vlak <- c(vlak, rep(i, ind.do[i]-(ind.od[i]-1)))
  }
  
  merenja_df$vlak <- factor(vlak) 
  
  
  merenja_df_sum <- merenja_df %>% dplyr::select(od, do, dh, duzina, vlak) %>%
    dplyr::group_by(vlak) %>% 
    dplyr::summarize(od = od[1],
                     do = do[length(vlak)],
                     dh = sum(dh),
                     stanica = length(vlak))
  
  merenja_df <- merenja_df %>% dplyr::select(od, do, dh, duzina)
  
  results <- list(tabela_1 = merenja_df, tabela_2 = merenja_df_sum)
  return(results) # Ukoliko je u okviru funkcije kreirano više promenljivih, komandom `return` biramo koja promenljiva će biti rezultat naše funkcije
}


nivelman(niv_merenja = merenja, reperi = c("B1", "B3", "B4", "B5"))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## $tabela_1
## # A tibble: 21 x 4
##    od    do          dh duzina
##    <chr> <chr>    <dbl>  <dbl>
##  1 B1    1      0.974     51.2
##  2 1     2     -0.00695   47.9
##  3 2     3      0.121     49.5
##  4 3     4      0.0358    50.8
##  5 4     B3    -0.126     48.3
##  6 B3    1      0.0357    49.7
##  7 1     2      0.221     47.7
##  8 2     3      0.125     48.2
##  9 3     4     -0.0604    45.6
## 10 4     B4    -0.0824    30.9
## # ... with 11 more rows
## 
## $tabela_2
## # A tibble: 4 x 5
##   vlak  od    do        dh stanica
##   <fct> <chr> <chr>  <dbl>   <int>
## 1 1     B1    B3     0.998       5
## 2 2     B3    B4     0.239       5
## 3 3     B4    B5    -0.145       3
## 4 4     B5    B1    -1.09        8
```



  
> <h3>Zadatak 1</h3>
> + Učitati excel fajl sa svim merenjima u mreži (`niv_merenja.xlsx`). Fajl je organizovan tako  da su merenja u pojedinačnim vlakovima smeštena u odvojenim excel sheet-ovima. Za učitavanje excel fajla sa više sheet-ova koristiti uputstva data na linku `readxl` paketa: https://readxl.tidyverse.org/articles/articles/readxl-workflows.html#iterate-over-multiple-worksheets-in-a-workbook. Rezultat učitanih merenja je lista!
> + Primeniti funkciju na svim elementima liste.
> + Spojiti odgovarajuće tabele u jednu, tako da na kraju imamo dve tabele, jednu koja se odnosi na merenja na stanici i jednu sumarnu tabelu.


 


```r
# Imena svih repera u mrezi:

library(tidyverse)
library(magrittr)
library(here)
```

```
## here() starts at C:/R_projects/Nauka_R/Slides
```

```r
library(readxl)
library(purrr)

reperi <- c("B1", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "S1", "S2", "S3", "D1", "H1", "J1", "M1", "P1", "D7", "H7", "N7", "D10", "E10", "I10", "P10", "P13", "L116",	"D19", "G19", "J19", "M19", "P19", "E26", "P26", "D29", "J29", "M29", "P29", "D32", "H32", "D38", "G38", "J38", "M38", "P38", "A11", "A12", "A13", "A14", "A21", "A22",	"A23", "A24")

merenja_path <- here::here("data", "niv_merenja.xlsx")

merenja <- merenja_path %>%
  readxl::excel_sheets() %>%
  purrr::set_names() %>%
  purrr::map(read_excel, path = merenja_path)

mreza_all <- lapply(merenja, function(x) nivelman(x, reperi = reperi))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
mreza_by_station <- lapply(mreza_all, function(x) x[[1]])

mreza_oddo <- lapply(mreza_all, function(x) x[[2]])

mreza_by_station <- do.call(rbind, mreza_by_station)

mreza_oddo <- do.call(rbind, mreza_oddo)

# or 
```

    
