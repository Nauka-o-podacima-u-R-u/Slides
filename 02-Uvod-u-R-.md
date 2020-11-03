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

U okviru ovog poglavlja, razmotrićemo četiri osnovne klase vekorskih podataka:

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




# Podešavanje radnog direktorijuma 



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


## Pregled podataka (Summary)



# Selektovanje podataka




## Dodeljivanje atributa





# Transformacija vrednosti podataka (Modifying values)

## Promena vrednosti

## Logički podskup podataka

## Rad sa NA (nedostajući podaci)






# Eksportovanje podataka u R-u






















