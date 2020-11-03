---
title: "Uvod u R"
author:
   - "Milutin Pejovic, Petar Bursac"
date: "03 November 2020"
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

# Osnovni tipovi i klase podataka u R-u

## Atomic vectors



```r
v1 <- c(1, 2, 3, 4, 5, 6)

v2 <- 1:6

is.vector(v1)
```

```
## [1] TRUE
```

### Tipovi podatka

R razlikuje šest osnovnih tipova podatka, a to su *doubles, integers, characters, logicals, complex, and raw*. Tip podatka je obično poznat autoru koda, međutim ukoliko ima potrebe da se sazna kojeg je tipa određeni podatak skladišten u nekom vektoru, to moguće saznati pozivom komandom `typeof`: 

#### Double



```r
typeof(v1)
```

```
## [1] "double"
```


#### Integer



```r
v3 <- c(1L, 2L, 3L, 4L, 5L, 6L)

typeof(v3)
```

```
## [1] "integer"
```


#### Characters



```r
v4 <- c("Milutin", "Vojkan", "Petar")

typeof(v4)
```

```
## [1] "character"
```

```r
prof_name <- paste("Milutin", "Pejovic", sep = " ")

prof_name
```

```
## [1] "Milutin Pejovic"
```

```r
v5 <- paste(c("Milutin", "Vojkan", "Petar"), "GRF", sep = "_")

typeof(v5)
```

```
## [1] "character"
```



#### Logicals



```r
v6 <-c(TRUE, FALSE, TRUE)

typeof(v6)
```

```
## [1] "logical"
```

```r
v7 <-c(T, F, T)
v7
```

```
## [1]  TRUE FALSE  TRUE
```

```r
typeof(v7)
```

```
## [1] "logical"
```


#### Nedostajuće vrednosti (`NA`)

Nodostajuće ili nepoznate vrednosti u R-u se predstavljaju sa `NA`. Treba imati na umu da nedostajuća vrednost nije nula vrednost, odnosno da bilo koja operacija sa nedostajućom vrednosti rezultira takođe u nedostajuću vrednost.



```r
1 > 5
```

```
## [1] FALSE
```

```r
NA > 5
```

```
## [1] NA
```

```r
10 * NA
```

```
## [1] NA
```


Izuzeci su samo sledeće operacije:



```r
NA ^ 0
```

```
## [1] 1
```

```r
NA | TRUE # operator | znači "ili"
```

```
## [1] TRUE
```

```r
NA & FALSE
```

```
## [1] FALSE
```



#### Provera tipa podataka

Provera tipa podataka se može sprovesti pozivanjem neke od funkcija iz familije `is.*()`, kao na primer `is.logical()`, `is.integer()`, `is.double()`, ili `is.character()`. Postoje i funkcije kao što su `is.vector()`, `is.atomic()`, ili `is.numeric()` ali oni ne služe toj svrsi. 



```r
is.numeric(v1)
```

```
## [1] TRUE
```

```r
is.integer(v1)
```

```
## [1] FALSE
```

```r
is.logical(v1)
```

```
## [1] FALSE
```



#### Prinudna konverzija imeđu tipova podataka

Kao što je poznato, vektor, matrica ili array su strukture podataka koje mogu sadržati samo jedan tip podataka. Stim u vezi, ukoliko se u nekom vektoru nađu dva tipa podataka, R će prema integrisanim pravilima (`character → double → integer → logical`) prinudno transformisati tip podataka.  



```r
#
str(c("a", 1)) # komanda `str` pokazuje strukturu podataka
```

```
##  chr [1:2] "a" "1"
```


## Atributi

### `Names` (nazivi)



```r
names(v1) <-c("jedan", "dva", "tri", "cetiri", "pet", "sest")

v1+1 # Imena ne prepoznaju vrednost na koju se odnose
```

```
##  jedan    dva    tri cetiri    pet   sest 
##      2      3      4      5      6      7
```

```r
names(v1) <- NULL # Uklanjanje atributa
```


### `Dim` (dimenzije)

Vektor se moze transformisati u dvo-dimenzionalnu strukturu podataka - matricu, dodavanjem odgovarajućih dimenzija pomoću komande `dim`:



```r
dim(v1) <- c(2, 3)

v1
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


Na isti način, vektor se može transformisati u `array`:



```r
v1 <- 1:6
dim(v1) <- c(1, 2, 3)
v1
```

```
## , , 1
## 
##      [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
##      [,1] [,2]
## [1,]    5    6
```





### Klase podataka

Jedan od najvažnijih atributa koji se vezuje za osnovne strukture podataka u R-u je `klasa`, čime se definiše jedan od objektno orijentisanih pristupa definisanja strukture podataka poznat pod imenom `S3` klase. R podržava više sistema za objeknto orijentisano struktuiranje podataka kao što su `S3`, `S4` i `R6`. `S3` je osnovni sistem i podržan je u okviru osnovne istalacije R-a.  
Dodavanjem atributa `class` R objekat postja `S3` objekat i od toga zavisi kako će se neke osnovne funkcije (`generic functions`) ophoditi prema tom objektu. Drugim rečima, rezultat neke operacije zavisi od klase podataka. 

U okviru ovog poglavlja, razmotrićemo dve osnovne klase vekorskih podataka:

#### `factors`

Faktor je vektor koji može sadržati samo određeni broj predefinisanih vrednosti i služi za skladištenje kategoričkih promenljivih. Faktorski vektor u sebi sadrži celobrojne vrednosti kojima je dodeljen naziv, odnosno nivo (`level`). Tako na primer:



```r
v7 <- factor(c("a", "b", "b", "a"))

v7
```

```
## [1] a b b a
## Levels: a b
```

```r
typeof(v7)
```

```
## [1] "integer"
```

```r
attributes(v7)
```

```
## $levels
## [1] "a" "b"
## 
## $class
## [1] "factor"
```

Faktorski vektor je pogodan za grupisanje podataka, što nam može omogućiti analizu podataka prema grupi kojoj pripadaju.  


#### `Dates` (Datum) vektori

`Dates` ili datumski vektori vektori u sebi sadrže podatak o vremenu na dnevnoj rezoluciji i kreirani su na osnovu `double` vrednosti. Oni predstavljanju broj dana počev od `1970-01-01` 



```r
v8 <- Sys.Date()

typeof(v8)
```

```
## [1] "double"
```

```r
attributes(v8)
```

```
## $class
## [1] "Date"
```

```r
as.numeric(v8)
```

```
## [1] 18569
```

```r
v9 <- as.Date("1983-03-30")
v9
```

```
## [1] "1983-03-30"
```

```r
as.numeric(v9)
```

```
## [1] 4836
```


#### `Date-time` (datum-vreme) vektori

R podržava dva načina u okviru `S3` klasa za skladištenje informacija o datumu-vremenu POSIXct, and POSIXlt. POSIX je skraćenica od Portable Operating System Interface što je skraćenica za familiju standarda za razmenu informacija o vremenu. `ct` je skraćenica od `calendar`, a `lt` od  `local time`. POSIXct vektor je kreiran na osnovu `double` vektora i predstavlja broj sekundi od `1970-01-01`.   



```r
v10 <- as.POSIXct("2020-11-04 10:00", tz = "UTC")

typeof(v10)
```

```
## [1] "double"
```

```r
attributes(v10)
```

```
## $class
## [1] "POSIXct" "POSIXt" 
## 
## $tzone
## [1] "UTC"
```




# Podešavanje radnog direktorijuma 

Ukoliko postoji potreba da se neka skripta veže za određeni set podataka koji se nalazi u određenom folderu, često je potrebno definisati radni direktorijum. Time se praktično definiše `default` putanja koju će koristiti sve funkcije koje za argument koriste putanju do određenog foldera, ukoliko se ne podesi drugačije. Podešavanje radnog direktorijuma se vrši pozivom komande `setwd()`



```r
?setwd()
```

```
## starting httpd help server ... done
```

```r
setwd(dir = "C:/R_projects/Nauka_R/Slides")
```


Ukoliko postoji potreba da se proveri koja je aktuelna putanja, odnosno koji je aktuelni radni direktorijum, to se može učiniti pozivom komande `getwd()`.



```r
getwd()
```

```
## [1] "C:/R_projects/Nauka_R/Slides"
```


Izlistavanje fajlova koji se nalaze u nekom direktorijumu se vrši pozivom komande `ls()`

> <h3>Zadatak 1</h3>
> + Podesiti radni direktorijum.
> + Izlistati sve fajlove koji se nalaze u radnom direktorijumu.

Rešenje:

```r
wDir <- "D:/R_projects/[naziv foldera]" # (Napomena: Zagrade [] nisu potrebne!)
setwd(wDir)

##  Kontrola:
getwd()

```

```r
list.files("[naziv pod-foldera ako postoji]/")

```

```
## [1] "iris.csv"          "Students_IG1.csv"  "Students_IG1.txt"  "Students_IG1.xlsx"
## [5] "Students_IG2.xlsx"
```

Podešavanje radnog direktorijuma je korisno koristiti ako prilikom rada koristimo konstantno jedinstven direktorijum sa skriptama, podacima i drugim potrebnim fajlovima. Tada u radu i korišćenju funkcija možemo koristiti relativne putanje ka pod-fodlerima ako je potrebno, inače se podrazumeva data putanja kao apsolutna.


# Učitavanje podataka u R-u



```r
studenti <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", sep = ",", header = TRUE)

studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE)
```


<<<<<<< HEAD
## Pregled podataka (Summary)


=======
#### `readxl` paket



```r
install.packages("readxl")
library(readxl)

# Dati primer za readxl
```




### Pregledavanje podataka



```r
str(studenti) # Obratite pažnju da su imena studenata skladištena kao faktorske kolone u okviru data.frame?
```

```
## 'data.frame':	35 obs. of  14 variables:
##  $ ID       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Prezime  : Factor w/ 30 levels "Antonijev","Arvaji",..: 1 2 3 4 5 6 29 30 9 10 ...
##  $ Ime      : Factor w/ 25 levels "Aleksandar","Andrijana",..: 4 13 22 15 22 1 1 3 23 17 ...
##  $ br.ind   : int  1035 1020 1051 1019 1041 1038 1031 1018 1027 1015 ...
##  $ god.upisa: int  16 17 16 17 16 17 17 17 17 17 ...
##  $ kol.1    : int  NA NA 0 0 0 0 40 NA 0 0 ...
##  $ kol.2    : int  NA NA NA NA NA 60 85 NA NA NA ...
##  $ kol.1.1  : int  NA NA NA NA NA 55 100 NA NA NA ...
##  $ kol.2.2  : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Januar   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Februar  : int  40 NA NA 10 100 NA NA 8 NA 82 ...
##  $ Jun      : int  51 NA 100 100 NA NA NA 70 100 NA ...
##  $ Ocena    : int  7 NA 7 8 7 7 8 6 6 8 ...
##  $ Praksa   : int  9 NA 8 8 8 NA 9 8 NA 7 ...
```

Ukoliko želimo da se određene kolone ne transformišu u faktorske prilikom učitavanja potrebno opciju `stringsAsFactors` podesititi da bude `FALSE`.



```r
str(studenti)
```

```
## 'data.frame':	35 obs. of  14 variables:
##  $ ID       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Prezime  : Factor w/ 30 levels "Antonijev","Arvaji",..: 1 2 3 4 5 6 29 30 9 10 ...
##  $ Ime      : Factor w/ 25 levels "Aleksandar","Andrijana",..: 4 13 22 15 22 1 1 3 23 17 ...
##  $ br.ind   : int  1035 1020 1051 1019 1041 1038 1031 1018 1027 1015 ...
##  $ god.upisa: int  16 17 16 17 16 17 17 17 17 17 ...
##  $ kol.1    : int  NA NA 0 0 0 0 40 NA 0 0 ...
##  $ kol.2    : int  NA NA NA NA NA 60 85 NA NA NA ...
##  $ kol.1.1  : int  NA NA NA NA NA 55 100 NA NA NA ...
##  $ kol.2.2  : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Januar   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Februar  : int  40 NA NA 10 100 NA NA 8 NA 82 ...
##  $ Jun      : int  51 NA 100 100 NA NA NA 70 100 NA ...
##  $ Ocena    : int  7 NA 7 8 7 7 8 6 6 8 ...
##  $ Praksa   : int  9 NA 8 8 8 NA 9 8 NA 7 ...
```

```r
head(studenti)
```

```
##   ID         Prezime        Ime br.ind god.upisa kol.1 kol.2 kol.1.1 kol.2.2
## 1  1       Antonijev      Boris   1035        16    NA    NA      NA      NA
## 2  2          Arvaji       Luka   1020        17    NA    NA      NA      NA
## 3  3           Babic     Stefan   1051        16     0    NA      NA      NA
## 4  4          Beljin      Miloš   1019        17     0    NA      NA      NA
## 5  5 Božic Krajišnik     Stefan   1041        16     0    NA      NA      NA
## 6  6           Brkic Aleksandar   1038        17     0    60      55      NA
##   Januar Februar Jun Ocena Praksa
## 1     NA      40  51     7      9
## 2     NA      NA  NA    NA     NA
## 3     NA      NA 100     7      8
## 4     NA      10 100     8      8
## 5     NA     100  NA     7      8
## 6     NA      NA  NA     7     NA
```

```r
tail(studenti)
```

```
##    ID     Prezime     Ime br.ind god.upisa kol.1 kol.2 kol.1.1 kol.2.2 Januar
## 30 30 Stanojkovic   Ðorde   1004        17    75    60      NA      NA     NA
## 31 31  Stojanovic   Marta   1048        16     0    NA      NA      NA     20
## 32 32  Stojanovic   Mitar   1058        17     0    NA      NA      NA     NA
## 33 33       Tomic   Filip   1029        17     0    NA      NA      NA     65
## 34 34   Cvetkovic Božidar   1006        17     0    NA      NA      NA     NA
## 35 35   Cvetkovic Nemanja   1039        17    15   100      60      NA     NA
##    Februar Jun Ocena Praksa
## 30      NA  NA     7      9
## 31      51  NA     6      7
## 32      10 100     9     10
## 33      NA  NA     6      8
## 34      40  70     6      8
## 35      NA  NA     7      8
```


#### Selektovanje podataka


#### Sumiranje


#### Modifikovanje 


#### Kombinovanje i spajanje
>>>>>>> 5814d90a2095178cc95d08731f19d507d9bbf9be


#### 

<<<<<<< HEAD


## Dodeljivanje atributa
=======
>>>>>>> 5814d90a2095178cc95d08731f19d507d9bbf9be

# Kreiranje funkcija




# Transformacija vrednosti podataka (Modifying values)

## Promena vrednosti

## Logički podskup podataka

## Rad sa NA (nedostajući podaci)






# Eksportovanje podataka u R-u






















