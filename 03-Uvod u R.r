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
#+ eval = FALSE, include = FALSE 

# Ucitavanje merenja
merenja <- read.table(file = "./data/nivelman.txt", header = TRUE, sep = ",", stringsAsFactors = FALSE)

# Kreiranje pomocne kolone (faktorske) koja pokazuje pripadnost redova stanici
merenja$stanica <- factor(rep(1:(dim(merenja)[1]/4), each = 4))

# Kreiranje liste prema pomocnoj faktorskoj promenljivoj (stanica)
merenja_list <- split(merenja, merenja$stanica)

# Kreiranje praznog data.frame-a
merenja_df <- data.frame(od = rep(NA, length(merenja_list)), 
                          do = rep(NA, length(merenja_list)), 
                          dh = rep(NA, length(merenja_list)), 
                          duzina = rep(NA, length(merenja_list)))

# popunjavanje data.frame-a
for(i in 1:length(merenja_list)){
  merenja_df$od[i] <- as.character(merenja_list[[i]]$tacka[1])
  merenja_df$do[i] <- as.character(merenja_list[[i]]$tacka[2])
  merenja_df$dh[i] <- ((merenja_list[[i]]$merenje[2]-merenja_list[[i]]$merenje[1])+(merenja_list[[i]]$merenje[3]-merenja_list[[i]]$merenje[4]))/2
  merenja_df$duzina[i] <- sum(merenja_list[[i]]$duzina)/2 
}

# Kreiranje fajla
writexl::write_xlsx(merenja_df, path = "merenja_df.xlsx")

# SUMIRANJE OD REPERA DO REPERA

reperi <- c("B1", "B3", "B4", "B5")

merenja_df$isReperOD <- merenja_df$od %in% reperi
merenja_df$isReperDO <- merenja_df$do %in% reperi


# broj vis razlika izmedju repera
ndh = sum(merenja_df$isReperOD)

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
merenja_df_reperi <- data.frame(od = od, do = do, dh = dh, n = n, duzina = duzina)

# Kreiranje fajla
writexl::write_xlsx(merenja_df_reperi, path = "merenja_df_reperi.xlsx")

#' 
#' 
#' 

