#' ---
#' title: "Uvod u R"
#' subtitle: Kontrola toka i oblikovanje podataka
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
#' # Kontrola toka u R-u
#' 
#' U okviru ovog predavanja upoznaćemo se sa mogućnostima kontrole toka i automatizacije izvršavanja komandi primenom komandi `if` i `for`. 
#'
#' ## `if` - grananje toka 
#' 
#' Komanda `if` omogućava da postavimo uslov kojim će izvršavanje neke komande zavisiti od rezultata nekog logičkog upita. Na taj način moguće je stvoriti razgranatu strukturu toka izvršavanja komandi (algoritma). Komanda `if` se koristi na sledeći način:
#' 
#' $$if(condition) \quad \textrm{{true_expression}} \quad elsе \quad \textrm{{false_expression}}$$ 
#' 
#' Na primer, ukoliko promenljiva `x` sadrži numerički podatak, podeliti ga sa 2, a ukoliko je neki drugi podatak ispisati "Nije moguće izvršiti komandu jer x ne sadrži numerički podatak"
#' 
#' 
x <- 5
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")

x <- "a"
if(is.numeric(x)) x/2 else print("Nije moguće izvršiti komandu jer x ne sadrži numerički podatak")
#' 
#' Ukoliko ne postoji određena operacija koja se uzvršava u slučaju `else`, nije potrebno pisati taj deo. Na primer:
#' 
x <- 5
if(is.numeric(x)) x/2 

x <- "a"
if(is(x, "numeric")) x/2 


#' 
#' Međutim, pravi smisao `if` komande se vidi tek kada očekujemo da prilikom izvršavanja niza komandi računar sam odluči šta treba uraditi u određenom trenutku u zavisnosti od ulazinih parametara. 
#' 
#' 
#' ## `for` petlja
#' 
#' `for` petlja se koristi kada želimo da automatizujemo izvršavanje neke komande ili niza komandi određeni broj puta. `for` petlja se koristi na sledeći način:
#'
#' $$ for(i \quad in \quad list) \quad \textrm{{expression}} $$
#'
#' Na primer, ako želimo da podacima `studenti` dodamo jednu kolonu pod nazivom "ispit" u vidu logičkog vektora koji će sadržati vrednost TRUE za studente koji su položili oba ispita (IG1 i Praksu) i FALSE za one koji nisu.
#'
#'
#'
studenti <- read.csv(file = "C:/R_projects/Nauka_R/Slides/data/Students_IG1.txt", header = TRUE, stringsAsFactors = FALSE)

studenti$ispit <- NA # Prvo cemo kreirati kolonu "ispit" koja ima sve NA vrednosti

 
# Komanda dim(studenti) vraca broj dimenzija, prvi se odnosi na broj vrsta.
dim(studenti)


for(i in 1:dim(studenti)[1]){ 
  # Sekvenca `1:dim(studenti)[1]` sadrzi niz brojeva od 1 do ukupnog broja vrsta u data.frame-u studenti.
  # i ide kroz svaku vrstu data.frame-a `studenti`
  studenti$ispit[i] <- if(is.na(studenti$Ocena[i]) | is.na(studenti$Praksa[i])){FALSE}else{TRUE}
}  

head(studenti, 15)

sum(studenti$ispit) # Koliko studenata je polozilo oba ispita

#'          
#'               
#' > <h3>Zadatak</h3>
#' 
#' > Potrebno je oblikovati fajl sa podacima nivelanja geometrijskim nivelmanom. Fajl sadrži sledeće informacije:
#'  
#' > > + Prva kolona: tacka - sadrzi imena repera i veznih tačaka. Reperi su B1, B3, B4 i B5, a vezne tacke su 1:n.
#' 
#' > > + Druga kolona: merenje - sadrži čitanja na letvi.
#' 
#' > > + Treća kolona: duzina - sadrži merenu dužinu od instrumenta do letve.
#' 
#' > U zadatku se traži sledeće:
#' > 1. Učitati podatke
#' 
#' > 2. Kreirati `data.frame` sa sledećim kolonama: od, do, dh i dužina. Pri tome, treba imati u vidu da je na svakoj stanici merena visinska razlika po principu zadnja-prednja-prednja-zadnja. To znači da svakoj stanici pripada po četiri reda izvornih podataka. Rezultujući `data.frame` treba da sadrži po jedan red po stanici, koji će u prvoj koloni ("od") imati "zadnju" tačku, u drugoj koloni ("do") imati prednju tačku, u trećoj koloni ("dh") imati srednju visinsku razliku sračunatu iz čitanja na letvi i u poslednjoj koloni ("duzina") imatu srednju dužinu od letve do letve sračunatu iz merenih dužina. Prilikom rada, pokušajte da se vodite sledećim principima:
#' 
#' 
#' > > *Generalna preporuka je da podelite zadatak na više manjih zadataka. Na primer, izdvojite podatke za samo jednu stanicu i pokušajte da kreirate željeni `data.frame` sa podacima samo jedne stanice. Uvidite šta su problemi u tom slučaju. Na početku, napravite rezultujući `data.frame` koji će sadržati samo `NA` vrednosti koje će biti zamenjene vrednostima koje treba da sadrži. Taj `data.frame` će imati broj redova onoliko koliko ima stanica i četiri kolone. Za te potrebe možete koristiti komandu `rep(NA, broj stanica)` za svaku kolonu `data.frame`-a. Komanda `rep` (repeat) pravi vektor određene dužine od vektora (sa jednom ili više) vrednosti. Za tim u taj `data.frame` upišite vrednosti koje izračunate ili isčitate iz ulaznih podataka. Kada rešite problem za jednu stanicu, razmislite kako ćete to automatizovati koristeći petlju `for`. Tu je preporuka da u ulaznim podacima napravite još jednu kolonu (faktorsku) koja će označiti koji red pripada kojoj stanici. Pa zatim, transformisati ulazne podatke u `list`-u prema toj promenljivoj i onda u okviru petlje `for`, na svaki član liste primeniti korake koje ste smislili kada ste rešavali samo jednu stanicu.*
#' 
#' > 3. Za tim, potrebno je rezultujući `data.frame` dodatno transformisati (sumirati) tako da sadrži samo merenja od repera do repera, sa sledećim kolonama: od (reper), do (reper), dh (ukupna visinska razlika između repera), n (broj stanica od repera do repera) i duzina (ukupna duzina od repera do repera).
#' 
#' ## Prvi način - korišćenjem petlje `for`
#' 
#' ### Kreiranje prve tabele - visinske razlike po stanici
#' 
#+ eval = TRUE, include = TRUE 

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

#' Kreiranje fajla
#+ eval = FALSE
writexl::write_xlsx(merenja_df, path = "merenja_df.xlsx")

#' 
#' ### Kreiranje sumarne tabele - visinske razlike od repera do repera

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


#' Kreiranje fajla
#+ eval = FALSE
writexl::write_xlsx(merenja_df_sum, path = "merenja_df_reperi.xlsx")

#'
#' # Transformacija podataka korišćenjem `dplyr` paketa 
#'
#'
#'
#' Kao što ste već videli, oblikovanje podataka često podrazumeva kreiranje novih promenljivih (atribute ili kolone), sumiranje podataka u novu tabelu, reimenovati ili rasporediti podatke u tabeli. Za te potrebe razvijeni su brojni alati koji omogućavaju laku manupulaciju podacima, a najpoznatiji paket u R okruženju je `dplyr` paket iz `tidyverse` famijije paketa. Da bi se koristio paket `dplyr` neophodno ga je instalirati. Medjutim, preporučuje se instalacija celog `tidyverse` paketa, koji uključuje celu grupu korisnih paketa.
#' 
#+ echo = FALSE, fig.align="center", out.width = '25%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/tidyverse-logo.png")
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/tidyverse_website.png")
#' 
#' 
#' Instalacija `tidyverse` paketa
#+ eval = FALSE
install.packages("tidyverse")
library(tidyverse)
#'
#'
#' `dplyr` paket ima nekoliko osnovnih funkcionalnosti koje rešavaju najčešće probleme, kao što su:
#' 
#' **selekcija pojedinačnih merenja (instanci ili vrsta u tabeli) komandom `dplyr::filter()`**
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/filter.png")
#' 
#' **selekcija atributa (kolona) komandom `dplyr::select()`**
#'   
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/rstudio-cheatsheet-select.png")    
#'     
#'      
#' **Kreiranje novih promenljivih komandom `dplyr::mutate()`**      
#'        
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/mutate.png")         
#'          
#' 
#' **Sumiranje podataka komandom `dplyr::summarise()`**
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/summarise.png")
#' 
#' 
#' **Grupisanje podataka `dplyr::group_by()` (često u kombinaciji sa `summarise`)**
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/group_by.png")
#' 
#' 
#' **Kombninovanje (spajanje) tabela komandom `dplyr::_join`**
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/combine-options1.png")
#' 
#' 
#' **Sortiranje podataka komandom `dplyr::arrange()`** 
#' 
#+ echo = FALSE, fig.align="center", out.width = '70%'
knitr::include_graphics("C:/R_projects/Nauka_R/Slides/Figures/reorder-data-frame-rows-in-r.png")
#'
#' 
#'   
#' ## Drugi način - korišćenjem `dplyr` paketa
#' 
#' 
#' 
#+ warning = FALSE, message = FALSE 
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


#' 
#' 
#' > <h3>Obrati pažnju na `%>%` </h3>
#' > Operator `%>%` (`pipe`) je moćan operator koji nam omogućava da sekvencijalno povezujemo operacije i da na taj način izbegnemo kreiranje nepotrebnih promenljivih. `Pipe` je dostupan preko paketa `magrittr`, što znači da je potrebno instalirati paket `magrittr` ako želimo da koristimo `pipe`. Međutim, `pipe` je takođe dostupan preko `tidyverse` paketa. Više detalja na [linku](https://r4ds.had.co.nz/pipes.html).
#'  

#'   
#' ### Kreiranje sumarne tabele - visinske razlike od repera do repera
#'                    
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

# Sumiranje visinskih razlika po vlaku sa dodatnim kolonama
merenja_df_sum <- merenja_df %>% dplyr::select(od, do, dh, duzina, vlak) %>%
                                 dplyr::group_by(vlak) %>% 
                                 dplyr::summarize(od = od[1],
                                                  do = do[length(vlak)],
                                                  dh = sum(dh),
                                                  stanica = n())

merenja_df_sum


#' # Kreiranje funkcija
#' 
#' R omogućava kreranje funkcija koje nam omogućavaju da automatizujemo određene korake u našem algoritmu. Kreiranje funkcija je poželjno u slučajevima kada imamo određeni deo koda koji je potrebno ponoviti više puta. Na taj način, umesto da kopiramo kod više puta, moguće je kreirati funkciju koja će izvršiti taj deo koda pozivanjem kreirane funkcije. Generalno, kreiranje funkcija se sastoji iz tri koraka:
#' 
#' + Dodeljivanje `imena`
#' + Definisanje `argumenata`
#' + Programiranje `tela` funckije (body) koje se sastoji od koda koji treba da se izvrši
#' 
#' Na primer ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u stepenima u radijane, to ćemo učiniti na sledeći način
#'
#+


step2rad <- function(ang_step){
  ang_step*pi/180
}

step2rad(180)

#' Ukoliko zelimo da napravimo funkciju koja pretvara decimalni zapis ugla u zapis step-min-sec to ćemo uraditi na sledeći način:

dec2dms <- function(ang){ # ime funkcije je `dec2dms`, a argument `ang`
  deg <- floor(ang) 
  minut <- floor((ang-deg)*60)
  sec <- ((ang-deg)*60-minut)*60
  return(paste(deg, minut, round(sec, 0), sep = " "))
}

dec2dms(ang = 35.26589)

dec2dms(45.52658)

#' 
#' Ukoliko želimo da napravimo funkciju od koda koji smo kreirali za potrebe oblikovanja ulaznih podataka to ćemo uraditi na sledeći način. 
#'    

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

#'
#' 
#'   
#' > <h3>Zadatak 1</h3>
#' > + Učitati excel fajl sa svim merenjima u mreži (`niv_merenja.xlsx`). Fajl je organizovan tako  da su merenja u pojedinačnim vlakovima smeštena u odvojenim excel sheet-ovima. Za učitavanje excel fajla sa više sheet-ova koristiti uputstva data na linku `readxl` paketa: https://readxl.tidyverse.org/articles/articles/readxl-workflows.html#iterate-over-multiple-worksheets-in-a-workbook. Rezultat učitanih merenja je lista!
#' > + Primeniti funkciju na svim elementima liste.
#' > + Spojiti odgovarajuće tabele u jednu, tako da na kraju imamo dve tabele, jednu koja se odnosi na merenja na stanici i jednu sumarnu tabelu.


#'
#' 
#'  

# Imena svih repera u mrezi:

library(tidyverse)
library(magrittr)
library(here)
library(readxl)
library(purrr)

reperi <- c("B1", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "S1", "S2", "S3", "D1", "H1", "J1", "M1", "P1", "D7", "H7", "N7", "D10", "E10", "I10", "P10", "P13", "L116",	"D19", "G19", "J19", "M19", "P19", "E26", "P26", "D29", "J29", "M29", "P29", "D32", "H32", "D38", "G38", "J38", "M38", "P38", "A11", "A12", "A13", "A14", "A21", "A22",	"A23", "A24")

merenja_path <- here::here("data", "niv_merenja.xlsx")

merenja <- merenja_path %>%
  readxl::excel_sheets() %>%
  purrr::set_names() %>%
  purrr::map(read_excel, path = merenja_path)

mreza_all <- lapply(merenja, function(x) nivelman(x, reperi = reperi))

mreza_by_station <- lapply(mreza_all, function(x) x[[1]])

mreza_oddo <- lapply(mreza_all, function(x) x[[2]])

mreza_by_station <- do.call(rbind, mreza_by_station)

mreza_oddo <- do.call(rbind, mreza_oddo)

# or 



  
#'     