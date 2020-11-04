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
#' # Strukture podataka
#' 
#' Podsetićemo se na početku osnovnih struktura podataka u R-u
#' 
#+ echo = FALSE, warning = FALSE, message = FALSE, fig.width = 10, fig.height = 8, fig.align='center'
knitr::include_graphics("Figures/strukture_podataka.jpg")
#'
#' # Osnovni tipovi i klase podataka u R-u
#' 
#' 
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
#+ echo = FALSE, warning = FALSE, message = FALSE, fig.width = 10, fig.height = 10, fig.align='center'
knitr::include_graphics("Figures/prinudna_promena.jpg")
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
#' U okviru ovog poglavlja, razmotrićemo tri osnovne klase vekorskih podataka:
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
#?setwd()

#setwd(dir = "C:/R_projects/Nauka_R/Slides")
#'
#' Ukoliko postoji potreba da se proveri koja je aktuelna putanja, odnosno koji je aktuelni radni direktorijum, to se može učiniti pozivom komande `getwd()`.
#' 
#getwd()
#'
#' Izlistavanje fajlova koji se nalaze u nekom direktorijumu se vrši pozivom komande `ls()`
#'
#' > <h3>Zadatak 1</h3>
#' > + Podesiti radni direktorijum.
#' > + Izlistati sve fajlove koji se nalaze u radnom direktorijumu.
#'
#'Podešavanje radnog direktorijuma je korisno koristiti ako prilikom rada koristimo konstantno jedinstven direktorijum sa skriptama, podacima i drugim potrebnim fajlovima. Tada u radu i korišćenju funkcija možemo koristiti relativne putanje ka pod-fodlerima ako je potrebno, inače se podrazumeva data putanja kao apsolutna.
#'
#'
#' # Učitavanje podataka u R-u
#' 
#' Za učitavanje podataka u radno okruženje koriste se funkcije, koje rade na principu zadavanja putanje ka podacima, kao i formata podataka, koji ne mora biti eksplicitno naveden. Neke od osnovnih funkcija su:
#' 
#' 
#+ include = TRUE
studenti <- read.table(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", sep = ",", header = TRUE)

studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE, stringsAsFactors = FALSE)
#'
#' ## `readxl` paket
#'
#'Učitavanje excel tabela je moguće učiniti putem paketa "readxl":
#+ eval = FALSE
install.packages("readxl")
library(readxl)

studenti <- readxl::read_xlsx(path = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.xlsx", sheet = "Students")

#'
#'
#'
#' ## Pregled podataka
#' 
str(studenti) # Obratite pažnju da su imena studenata skladištena kao faktorske kolone u okviru data.frame?

#' Ukoliko želimo da se određene kolone ne transformišu u faktorske prilikom učitavanja potrebno opciju `stringsAsFactors` podesititi da bude `FALSE`.
#' 


class(studenti)

head(studenti, 5)

tail(studenti, 5)

dim(studenti)

#'
#'
#'
#' ## Selektovanje podataka
#' 
#' U okviru R-a postoji poseban sistem notacije kojim je moguće pristupiti vrednostima objekta. Kako bi pristupili podatku ili setu podataka (red-u i/ili kolona-ma), koristi se sledeće notacija sa [] zagradama:

# studenti[ , ]

#' U okviru zagrada pišu se dva indeksa odvojena zarezom, pri predstavlja broj **reda** i drugi predstavlja broj **kolone**. Indeksi mogu biti napisani na veći broj načina, i to:
#'  
#' - Pozitivne celobrojne vrednosti
#' - Negativne celobrojne vrednosti
#' - Nula
#' - Razmak
#' - Logičke vrednosti
#' - Nazivi   
#' 
#' #### Pozitivne celobrojne vrednosti
#' 
studenti[1, ]

studenti[, 2]

studenti[1, 2]

#' Na ovaj način izvršena je selekcija prvog reda i druge kolone. Pored zadavanja jedne vrednosti, možemo izvršiti selekciju podataka skupom indeksa.
studenti[1, c(2,3)]
studenti[1, c(2:5)]

#' Rezultat upita je samo prikaz - kopija vrednosti. Rezultat možemo dodeliti novoj promenljivoj:

Boris <- studenti[1, c(1:14)]
Boris

#' Isti sistem notacije se koristi i kod drugih tipova podataka, npr. kod vektora:
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]

#' Bitno je zapamtiti da indeksiranje u R-u **uvek počinje od 1**, dok za razliku od nekih drugih programskih jezika počinje od 0.      
#'    
#' #### Negativne celobrojne vrednosti
#' Negativne vrednosti daju suprotni rezultat u odnosu na pozitivne celobrojne vrednosti. Rezultat je sve osim elemenata navedenih indeksom:
studenti[-c(2:35), 2:5]

#' Kombincija pozitivnih i negativnih indeksa je moguća, dok nije moguće postaviti pozitivnu i negativnu vrednost u okviru istog inndeksa:
# studenti[-c(-1,1), 2]
# Error in x[i] : only 0's may be mixed with negative subscripts

studenti[1:5, -1]

#'
#' #### Nula
#' Kao što je rečeno indeksiranje elemenata počinje od 1, dok indeks 0 nije greška, već je rezultat objekat bez elemenata:
#' 
studenti[0, 0]

#'
#' #### Razmak
#' Korišćenem razmaka - praznog indeksa, dobija se rezultat koji podrazumeva sve elemente datog reda ili kolone:
#' 
studenti[1, ]

#' 
#' #### Logičke vrednosti          
#' Vrednost indeksa može biti i logička vrednost i tom slučaju rezultat je red i/ili kolona koja odgovara vrednosti TRUE:
#' 
studenti[1, c(FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]

#' Vektor logičkih vrednosti moguće je kreirati primenom logičkih upita. Odnosno kreiranjem logičkog upita dobija se vektor sa vrednostima TRUE i FALSE koji se mogu koristiti za određivanje pozicije vrednosti koju želimo izmeniti:
#'   
generacija_2017 <- studenti$god.upisa == 2017
generacija_2017 # vektor logičkih vrednosti

studenti[generacija_2017, ]

#' 
#' Logički operatori su veoma efikasan način selekcije i u okviru R-a definisani su na sledeći način:
#' 
#' 
#' #### Bulovi operatori
#' 
#' #' Bulovi operatori nam omogućuju da kombinujemo logičke izraze. Međutim, tu treba imati na umu da `NA` vrednosti mogu uticati na rezultat izraza. Bilo koji izraz sa `NA`vrednošću nam kao rezultat vraća `NA` vrednost.
#' 
#+ echo = FALSE, warning = FALSE, message = FALSE, fig.width = 10, fig.height = 8, fig.align='center'
knitr::include_graphics("Figures/logicki operatori.jpg")
#' 

#' 
#' Na primer, ako želimo pogledati  koji studenti su imali 100 bodova junskom roku i kranju ocenu 9, nećemo dobiti željeni rezultat, upravo zbog prisustva `NA` vrednosti
#' 
studenti[studenti$Jun == 100 & studenti$Ocena == 9, ]

studenti[!is.na(studenti$Jun) & !is.na(studenti$Ocena) & studenti$Jun == 100 & studenti$Ocena == 9, ]

#' 
#'  
#'    
#' #### Nazivi 
#' 
#' Selekcija podataka - elementa je moguća i putem naziva kolona i/ili redova ako su dostupni:

names(studenti) 
studenti[, "Prezime"]
studenti[1:5, c("Prezime", "Ime", "br.ind", "god.upisa")]

#' Kao i kombinacija navedenog:
studenti[1:5, c(names(studenti[, c(2:5)]))]

#' 
#' ### Selektovanje podataka putem $ sintakse
#' Putem prethodnih primera pokazan je osnovni način selekcije elementa iz skupa podataka. Način selekcije podataka koji se najčešče koristi predstavlja upotrebu $ sintakse.      
#' Potrebno je napisati naziv objekta - data frame-a a zatim napisati naziv kolone odvojen znakom "$":
#' 
studenti$Prezime

#' *Tips: Nakon napisanog znaka "$" moguće je pritisnuti taster TAB na tastaturi kako bi dobili listu naziva kolona.*      
#' Kako bi izvršili upit po redu, potrebno je napisati [] zagrade i navesti indeks reda.
#' 
studenti$Prezime[1]
studenti$Prezime[1:5]

#' 
#' 
#' ### Selektovanje podataka u okviru `list` - e
#' 
#' Selektovanje podataka u okviru liste vrši se korišćenjem operatora `[]` i `[[]]` ili prema nazivu elementa liste. 
#' Na primer, kreiraćemo listu studenata sa dva elementa, oni koji su položili praksu i onih koji nisu položili praksu.
#' 
praksa_list <- list(polozili = studenti[!is.na(studenti$Praksa), ], nisu_polozili = studenti[is.na(studenti$Praksa), ])
#' 
#' Ukoliko želimo selektovati prvi član liste primenom operatora `[]`, za rezultat ćemo takođe dobiti listu!
#' 
praksa_list[1]

class(praksa_list[1])
#'
#+ echo = FALSE, warning = FALSE, message = FALSE, fig.width = 10, fig.height = 7, fig.align='center'
knitr::include_graphics("Figures/selektovanje_liste.jpg")
#' 
#' Međutim, ukoliko želimo selektovati prvi član liste primenom operatora `[[]]`, za rezultat ćemo takođe dobiti `data.frame`!
#' 
praksa_list[[1]]
class(praksa_list[[1]])

#' 
#' Element liste moguće je selektovati i naznačavanjem imena liste u okviru operatora `[]`:
#' 
praksa_list["polozili"]

praksa_list[["polozili"]]
#' 
#' 
praksa_list[1]
class(praksa_list[1])
#' 
#' > <h3>Zadatak</h3>
#' > + Kreirati listu tako što da studenti upisani iste godine čine jedan član liste. Za te potrebe koristiti komandu `list(prvi data.frame, drugi data.frame, treci data.frame)`
#' 
#' 
#' 
#' 
#' 
#' ## Modifikovanje podataka
#' 
#' 
#' ### Promena vrednosti
#' 
#' Modifikacija vrednosti podataka odnosi se na promenu vrednosti nekog podatka. Da bi neku vrednost bilo moguce promeniti, potrebno je prvo specificirati tačnu poziciju vrednosti koju želimo promeniti. Na primer, ako želimo da upišemo kao godinu upisa broj 2017 umesto 17, i 2016 umesto 16, to cemo uraditi na sledeci nacin:


studenti[studenti$god.upisa == 17, "god.upisa"] <- 2017

studenti[studenti$god.upisa == 16, "god.upisa"] <- 2016

studenti$god.upisa

#' Ukoliko žeilimo da svim studentima koji su upisali fakultet 2017 godine dodelimo ocenu 5 iz IG1, to možemo uraditi na sledeći način:

studenti[studenti$god.upisa == 2017, "Ocena"] <- 5
studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE, stringsAsFactors = FALSE)
#'
#' > <h3>Zadatak</h3>
#' > + Izmeniti rezultate krajnje ocene i prakse za svoje ime tako sto cete dodeliti ocenu 10.

#' 
#' #### Modifikovanje tipa podataka
#' 
str(studenti)

unique(studenti$god.upisa)

studenti$god.upisa <- factor(studenti$god.upisa, labels = c("2015", "2016", "2017"))

#' #### Modifikovanje redosleda podataka
#' 
#' Ukoliko želimo da poređamo vrste u `data.frame`-u prema vrednostima u nekoj koloni, to možemo učiniti na sledeći način:
#' 
studenti[order(studenti$Ocena, studenti$Praksa),] 
#' 
#' #### Kombinovanje podataka
#' 
#' Kombinovanjem podataka se odnosi na mogućnost spajanja dve tabele. Za te potrebe učitaćemo rezultate (konačne ocene) studenata postignute na predmetima IG1, Praksa i IG2. 
#' 
ig1 <- readxl::read_xlsx(path = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.xlsx", sheet = "Students")
head(ig1)
ig1 <- ig1[, c("Prezime", "Ime", "Ocena", "Praksa")] # Selektovali smo samo kolone koje nas zanimaju.
names(ig1) <- c("prezime", "ime", "ocena_ig1", "ocena_praksa")

ig2 <- readxl::read_xlsx(path = "C:/R_projects/Nauka_R/Slides/data/Students_IG2.xlsx", sheet = "Students")
head(ig1)
ig2 <- ig2[, c("Prezime", "Ime", "Ocena")] # Selektovali smo samo kolone koje nas zanimaju.
names(ig2) <- c("prezime", "ime", "ocena_ig2")

#' Komanda `cbind` spaja dve tabele tako što drugu "nalepi" na prvu. Kao rezultat se dobija tabela sa ponovljenih kolonama koje su zajedničke. Uslov za korišćenje komande `cbind` je da dve tabele imaju isti broj vrsta. 

ig <- cbind(ig1, ig2)
ig

#' Analogno komandi `cbind`, postoji komanda `rbind` koja spaja dve tabele tako što ih nadovezuje jednu ispod druge. Uslov za korišćenje komande `rbind` je da dve tabele imaju isti broj kolona. 

#' Ukoliko postoje zajedničke kolone poželjno je da se one ne ponavljaju. U tu svrhu koristićemo komandu `merge`:
#' 
ig <- merge(ig1, ig2, by = c("prezime", "ime"))

ig
#' 
#' 
#' ## Sumiranje
#' 
#' Sumiranje podataka je moguće uraditi po vrednostima reodova i/ili kolona. Postoji veliki broj funkcija, kao i paketa koji koriste svoje funkcije za sumiranje po određenim pravilima. Neke od osnovnih funkcija base paketa su:
#' 
#' ### Base funkcije
summary(studenti)

mean(studenti$Ocena, na.rm = TRUE) # "na.rm" parametar se koristi kako bi se zanemarile NA vrednosti u podacima.

min(studenti$kol.1, na.rm = TRUE)
max(studenti$kol.1, na.rm = TRUE)

median(studenti$Praksa, na.rm = T)

#' 
#' ### apply i lapply funkcije
#' apply i lapply funkcije kao ulaz koriste data.frame ili matricu i kao rezultat daju vektor, listu ili array. 
## ?apply()
## ?lapply()
#' apply možemo koristiti kako bi izvršili sumiranje po svim redovima (drugi argument funkcije je 1) ili kolonama (drugi argument funkcije je 2). 
#' 
studenti_bez_na <- studenti
studenti_bez_na[is.na(studenti_bez_na)] <- 0
apply(studenti_bez_na[, 6:14], 2, mean)

#' lapply koristimo kada želimo da izvršimo sumiranje po svakom članu liste ili npr. svakoj koloni data.frame-a. Razlika u odnosu na apply je što je ovde rezltat lista,
#' 
lapply(studenti_bez_na[, 6:14], mean) 

#' ### Funkcije colSums() i rowSums()
#' 
colSums(studenti[, 6:14], na.rm = T) 
rowSums(studenti[, 6:7], na.rm = T) # Rezultat je zbir bodova na prvom i drugom kolokvijumu

colMeans(studenti[, 6:14], na.rm = T) # Uočavamo razilku između srednje vrednosti kolona dobijene funkcijom apply i colSums. Razlika je u tome da smo u prvom slučaju NA vrednosti zamenili sa 0 (pa je delilac veći) u odnosu na funkciju colSums gde smo naznačili da zanemarujemo NA vrednosti.
rowMeans(studenti[, 6:7], na.rm = T)

#'
#' ### Funkcija by()
#' Koriscenjem funkcije by(), možemo na jednostavan način uraditi sumiranje po određenim faktorskim kolona.
by(studenti, studenti[, 5], summary) # Sumarni rezultati po godini upisa

#' ### Kreiranje jednostavne funkcije
#' U cilju sumiranja podataka po određenom pravilu, možemo napisati jednostavnu funkciju:
#' 
racunajSrednjuVrednost <- function(data_frame = data_frame, izbaciNA = TRUE){ # argumenti funkcije
  sr_vrednost  <- mean(data_frame$Ocena, na.rm = izbaciNA)
  return(sr_vrednost)
}

racunajSrednjuVrednost(data_frame = studenti, izbaciNA = TRUE) 


#' 
#' > <h3>Zadatak</h3>
#' > + Sumirati podatke i sračunati ukupan broj studenata koji su položili prvi kolokvijum.
#' > + Sumirati podatke i sračunati ukupan broj studenata koji su položili oba kolokvijuma.
#' > + Sumirati podatke i sračunati koliko su bodovi na prvom i drugom kolokvijumu u korelaciji sa krajnjom ocenom.
#' 
#' Rešenje: 
#' 

#' Zadatak 1:
length(studenti_bez_na$kol.1[studenti_bez_na$kol.1 > 0])

#' Zadatak 2:
length(studenti_bez_na$kol.1[studenti_bez_na$kol.1 > 0 & studenti_bez_na$kol.2 > 0])

#' Zadatak 3:
cor(studenti_bez_na$kol.1, studenti_bez_na$Ocena)
plot(studenti_bez_na$kol.1, studenti_bez_na$Ocena)

cor(studenti_bez_na$kol.2, studenti_bez_na$Ocena)
plot(studenti_bez_na$kol.2, studenti_bez_na$Ocena)
#'
#'
#'
#' # Eksportovanje podataka u R-u
#' 
#' Osnovna funkcija za eksportovanje podataka u R-u je `write.table`. Međutim, češće se koriste tzv. `wrapper` funkcije koje pozivaju funkciju `write.table` ali sa predefinisanim `default` parametrima, kao na primer `write.csv`.
#' 
#' 
write.csv(studenti, file = "studenti_export.csv", row.names = FALSE)
#' 
#' ## `writexl` paket
#' 
#' Paket `writexl` je veoma jednostavan paket za kreiranje `excel` fajlova. Ima svega nekoliko veoma korisnih funkcija.
#+ eval = FALSE 
install.packages("writexl")
library(writexl)
#+ eval = FALSE 
writexl::write_xlsx(studenti, path = "studenti_excel.xlsx")
#'
#'  
#' ## Čuvanje i učitavanje R podataka
#' 
#' Podaci (objekti svih vrsta) kreirani u okviru R-a, mogu biti sačuvani kao `Rdata` (ukoliko je više objekata) ili `rda` (`rds`) (ukoliko je jedan objekat)
#+ eval = FALSE
save(studenti, file = "C:/R_projects/Nauka_R/Slides/studenti_export.rda")

#'   
#'       


