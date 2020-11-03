#' ---
#' title: "Uvod u R"
#' author:
#'    - "Milutin Pejovic, Petar Bursac"
#' date: "`r format(Sys.time(), '%d %B %Y')`"
#' output:
#'    html_document:
#'      keep_md: true
#'      theme: "simplex"
#'      highlight: tango
#'      toc: true
#'      toc_depth: 5
#'      toc_float: true
#'      fig_caption: yes
#' ---
#'
#' # Osnovni tipovi i klase podataka u R-u
#' 
#' ## Atomic vectors
#' 

v1 <- c(1, 2, 3, 4, 5, 6)

v2 <- 1:6

is.vector(v1)

#' ### Tipovi podatka
#' 
#' R razlikuje šest osnovnih tipova podatka, a to su *doubles, integers, characters, logicals, complex, and raw*. Tip podatka je obično poznat autoru koda, međutim ukoliko ima potrebe da se sazna kojeg je tipa određeni podatak skladišten u nekom vektoru, to moguće saznati pozivom komandom `typeof`: 
#' 
#' #### Double
#' 
typeof(v1)
#'
#' #### Integer
#'
v3 <- c(1L, 2L, 3L, 4L, 5L, 6L)

typeof(v3)

#'
#' #### Characters
#'
v4 <- c("Milutin", "Vojkan", "Petar")

typeof(v4)

prof_name <- paste("Milutin", "Pejovic", sep = " ")

prof_name

v5 <- paste(c("Milutin", "Vojkan", "Petar"), "GRF", sep = "_")

typeof(v5)

#'
#'
#' #### Logicals
#'
v6 <-c(TRUE, FALSE, TRUE)

typeof(v6)

v7 <-c(T, F, T)
v7
typeof(v7)

#'
#' #### Nedostajuće vrednosti (`NA`)
#'
#' Nodostajuće ili nepoznate vrednosti u R-u se predstavljaju sa `NA`. Treba imati na umu da nedostajuća vrednost nije nula vrednost, odnosno da bilo koja operacija sa nedostajućom vrednosti rezultira takođe u nedostajuću vrednost.
#'
#+ include = TRUE

1 > 5

NA > 5

10 * NA

#'
#' Izuzeci su samo sledeće operacije:
#' 
#+ include = TRUE
NA ^ 0

NA | TRUE # operator | znači "ili"

NA & FALSE
#'
#'
#' #### Provera tipa podataka
#' 
#' Provera tipa podataka se može sprovesti pozivanjem neke od funkcija iz familije `is.*()`, kao na primer `is.logical()`, `is.integer()`, `is.double()`, ili `is.character()`. Postoje i funkcije kao što su `is.vector()`, `is.atomic()`, ili `is.numeric()` ali oni ne služe toj svrsi. 
#'
#+
is.numeric(v1)

is.integer(v1)

is.logical(v1)
#'
#' 
#' #### Prinudna konverzija imeđu tipova podataka
#'
#' Kao što je poznato, vektor, matrica ili array su strukture podataka koje mogu sadržati samo jedan tip podataka. Stim u vezi, ukoliko se u nekom vektoru nađu dva tipa podataka, R će prema integrisanim pravilima (`character → double → integer → logical`) prinudno transformisati tip podataka.  
#'
#
str(c("a", 1)) # komanda `str` pokazuje strukturu podataka

#'
#' ## Atributi
#'
#' ### `Names` (nazivi)
#'

names(v1) <-c("jedan", "dva", "tri", "cetiri", "pet", "sest")

v1+1 # Imena ne prepoznaju vrednost na koju se odnose


names(v1) <- NULL # Uklanjanje atributa


 
#'
#' ### `Dim` (dimenzije)
#' 
#' Vektor se moze transformisati u dvo-dimenzionalnu strukturu podataka - matricu, dodavanjem odgovarajućih dimenzija pomoću komande `dim`:
#' 
#+ include = TRUE

dim(v1) <- c(2, 3)

v1

#' 
#' Na isti način, vektor se može transformisati u `array`:
#'
#+ include = TRUE

v1 <- 1:6
dim(v1) <- c(1, 2, 3)
v1
#' 
#' 
#' 
#' 
#' ### Klase podataka
#' 
#' Jedan od najvažnijih atributa koji se vezuje za osnovne strukture podataka u R-u je `klasa`, čime se definiše jedan od objektno orijentisanih pristupa definisanja strukture podataka poznat pod imenom `S3` klase. R podržava više sistema za objeknto orijentisano struktuiranje podataka kao što su `S3`, `S4` i `R6`. `S3` je osnovni sistem i podržan je u okviru osnovne istalacije R-a.  
#' Dodavanjem atributa `class` R objekat postja `S3` objekat i od toga zavisi kako će se neke osnovne funkcije (`generic functions`) ophoditi prema tom objektu. Drugim rečima, rezultat neke operacije zavisi od klase podataka. 
#' 
#' U okviru ovog poglavlja, razmotrićemo dve osnovne klase vekorskih podataka:
#' 
#' #### `factors`
#' 
#' Faktor je vektor koji može sadržati samo određeni broj predefinisanih vrednosti i služi za skladištenje kategoričkih promenljivih. Faktorski vektor u sebi sadrži celobrojne vrednosti kojima je dodeljen naziv, odnosno nivo (`level`). Tako na primer:
#' 
v7 <- factor(c("a", "b", "b", "a"))

v7

typeof(v7)

attributes(v7)

#' Faktorski vektor je pogodan za grupisanje podataka, što nam može omogućiti analizu podataka prema grupi kojoj pripadaju.  
#' 
#' 
#' #### `Dates` (Datum) vektori
#' 
#' `Dates` ili datumski vektori vektori u sebi sadrže podatak o vremenu na dnevnoj rezoluciji i kreirani su na osnovu `double` vrednosti. Oni predstavljanju broj dana počev od `1970-01-01` 
#' 
v8 <- Sys.Date()

typeof(v8)

attributes(v8)

as.numeric(v8)

v9 <- as.Date("1983-03-30")
v9

as.numeric(v9)

#' 
#' #### `Date-time` (datum-vreme) vektori
#' 
#' R podržava dva načina u okviru `S3` klasa za skladištenje informacija o datumu-vremenu POSIXct, and POSIXlt. POSIX je skraćenica od Portable Operating System Interface što je skraćenica za familiju standarda za razmenu informacija o vremenu. `ct` je skraćenica od `calendar`, a `lt` od  `local time`. POSIXct vektor je kreiran na osnovu `double` vektora i predstavlja broj sekundi od `1970-01-01`.   
#' 

v10 <- as.POSIXct("2020-11-04 10:00", tz = "UTC")

typeof(v10)

attributes(v10)

#' 
#' 
#' 
#' # Podešavanje radnog direktorijuma 
#'
#' Ukoliko postoji potreba da se neka skripta veže za određeni set podataka koji se nalazi u određenom folderu, često je potrebno definisati radni direktorijum. Time se praktično definiše `default` putanja koju će koristiti sve funkcije koje za argument koriste putanju do određenog foldera, ukoliko se ne podesi drugačije. Podešavanje radnog direktorijuma se vrši pozivom komande `setwd()`
#'
?setwd()

setwd(dir = "C:/R_projects/Nauka_R/Slides")
#'
#' Ukoliko postoji potreba da se proveri koja je aktuelna putanja, odnosno koji je aktuelni radni direktorijum, to se može učiniti pozivom komande `getwd()`.
#' 
getwd()
#'
#' Izlistavanje fajlova koji se nalaze u nekom direktorijumu se vrši pozivom komande `ls()`
#'
#' > <h3>Zadatak 1</h3>
#' > + Podesiti radni direktorijum.
#' > + Izlistati sve fajlove koji se nalaze u radnom direktorijumu.
#'
#'
#'
#'
#' # Učitavanje i eksportovanje podataka u R-u
#' 
#+ include = TRUE
studenti <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", sep = ",", header = TRUE)

studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE)
#'
#' #### `readxl` paket
#'
#+ eval = FALSE
install.packages("readxl")
library(readxl)

# Dati primer za readxl

#'
#'
#'
#' ### Pregledavanje podataka
#' 
str(studenti) # Obratite pažnju da su imena studenata skladištena kao faktorske kolone u okviru data.frame?

#' Ukoliko želimo da se određene kolone ne transformišu u faktorske prilikom učitavanja potrebno opciju `stringsAsFactors` podesititi da bude `FALSE`.
#' 

str(studenti)

head(studenti)

tail(studenti)

#'
#' #### Selektovanje podataka
#' 
#' 
#' #### Sumiranje
#' 
#'
#' #### Modifikovanje 
#' 
#' 
#' #### Kombinovanje i spajanje
#' 
#' 
#' #### 
#' 
