setwd("E:/GRF/Master akademske studije/Semestar 1/Nauka o podacima u R-u/3. cas (10.11.2020.)")

nivelman <- read.csv("nivelman.txt", header = TRUE, stringsAsFactors = FALSE)

#Keiranje pomocne tabele koja ce sluziti za modifikaciju u skladu sa potrebama zadatka
nivelman_pomoc <- nivelman 




##TABELA1

#Kreiranje prazne tabele
# MP: OK
tabela1 <- data.frame(od = rep(NA, dim(nivelman_pomoc)[1]/4), do = rep(NA, dim(nivelman_pomoc)[1]/4), dh = rep(NA, dim(nivelman_pomoc)[1]/4), duzina = rep(NA, dim(nivelman_pomoc)[1]/4))



#Pomocna kolona "koeficijent1"
# MP: pokusaj da stavis sve u jednu liniju koda koriscenjem komande rep(c(1:4), dim(nivelman_pomoc)[1]/4)
nivelman_pomoc$koeficijent1 <- 0
for(i in seq(1, dim(nivelman_pomoc)[1], 4)) {nivelman_pomoc$koeficijent1[i] <- 1}
for(i in seq(2, dim(nivelman_pomoc)[1], 4)) {nivelman_pomoc$koeficijent1[i] <- 2}
for(i in seq(3, dim(nivelman_pomoc)[1], 4)) {nivelman_pomoc$koeficijent1[i] <- 3}
for(i in seq(4, dim(nivelman_pomoc)[1], 4)) {nivelman_pomoc$koeficijent1[i] <- 4}

#Pomocni vektori za kolone "od" i "do"
# MP: Ok
v_zadnja_letva <- nivelman_pomoc[nivelman_pomoc$koeficijent1 == 1, "tacka"]
v_prednja_letva <- nivelman_pomoc[nivelman_pomoc$koeficijent1 == 2, "tacka"]

#Pomocni vektor za kolonu "dh"
# MP: Ok
v_dh_stanica <- ((nivelman_pomoc[nivelman_pomoc$koeficijent1 == 1, "merenje"] - nivelman_pomoc[nivelman_pomoc$koeficijent1 == 2, "merenje"]) + (nivelman_pomoc[nivelman_pomoc$koeficijent1 == 4, "merenje"] - nivelman_pomoc[nivelman_pomoc$koeficijent1 == 3, "merenje"]))/2

#Pomocni vektor za kolonu "duzina"
# MP: Ok
v_duzina_stanica <- (nivelman_pomoc[nivelman_pomoc$koeficijent1 == 1, "duzina"] + nivelman_pomoc[nivelman_pomoc$koeficijent1 == 4, "duzina"])/2 + (nivelman_pomoc[nivelman_pomoc$koeficijent1 == 2, "duzina"] + nivelman_pomoc[nivelman_pomoc$koeficijent1 == 3, "duzina"])/2

#Popunjavanje tabele
# MP: Moze sve u jednu for petlju. A jos jednostavnije resenje je da samo spojite vektore u data.frame komandom cbind.
for(i in 1:length(v_zadnja_letva)) {tabela1$od[i] <- v_zadnja_letva[i]} 
for(i in 1:length(v_prednja_letva)) {tabela1$do[i] <- v_prednja_letva[i]} 
for(i in 1:length(v_dh_stanica)) {tabela1$dh[i] <- v_dh_stanica[i]} 
for(i in 1:length(v_duzina_stanica)) {tabela1$duzina[i] <- v_duzina_stanica[i]}





##TABELA2

#Keiranje pomocne tabele koja ce sluziti za modifikaciju u skladu sa potrebama zadatka
tabela1_pomoc <- tabela1

#Pomocni vektor 
oznaka_repera <- "B"

#Racunanje brojaca (broja nivelmanskih vlakova), kreiranje prazne tabele
brojac1 <- 0 #Kada se izvrsi for petlja koja se nalazi u redu ispod, vektor "brojac1" predstavlja zapravo broj nivelmanskih vlakova u poligonu
# MP: Pozdravljam pronalazenje funkcije grepl.  Moja ideja je bila da se vektor repera definise odmah na pocetku npr. reperi <- c("B1", "B3", "B4", "B5") pa da se onda sa upitom %in% proverava da li je neka oznaka reper ili nije. npr. tabela1_pomoc$od %in% c("B1", "B3", "B4", "B5")
for(i in 1:dim(tabela1_pomoc)[1]) {if(grepl(oznaka_repera, tabela1_pomoc$od[i], fixed = TRUE)) {brojac1 <- brojac1 + 1}}
tabela2 <- data.frame(od = rep(NA, brojac1), do = rep(NA, brojac1), dh = rep(NA, brojac1), n = rep(NA, brojac1), duzina = rep(NA, brojac1))

#Pomocni vektori za kolone "od" i "do"
# MP: Ok, samo je moglo u jednu for petlju
v_od <- c()
for(i in 1:dim(tabela1_pomoc)[1]) {if(grepl(oznaka_repera, tabela1_pomoc$od[i], fixed = TRUE)) {v_od <- c(v_od, tabela1_pomoc$od[i])}}
v_do <- c()
for(i in 1:dim(tabela1_pomoc)[1]) {if(grepl(oznaka_repera, tabela1_pomoc$do[i], fixed = TRUE)) {v_do <- c(v_do, tabela1_pomoc$do[i])}}

#Pomocna kolona "koeficijent2"
# MP: Ok
tabela1_pomoc$koeficijent2 <- 0
brojac2 <- 1
for(i in 1:dim(tabela1_pomoc)[1]) {if(grepl(oznaka_repera, tabela1_pomoc$do[i], fixed = TRUE)) {(tabela1_pomoc$koeficijent2[i] <- brojac2) & (brojac2 <- brojac2 + 1)} else {tabela1_pomoc$koeficijent2[i] <- brojac2}}

#Pomocni vektor za kolonu "dh"
# MP: Ok
v_dh <- c()
for(i in 1:brojac1) {v_dh <- c(v_dh, sum(tabela1_pomoc[tabela1_pomoc$koeficijent2 == i, "dh"]))}

#Pomocni vektor za kolonu "n"
# MP: Ok
v_n <- c()
for(i in 1:brojac1) {v_n <- c(v_n, sum(tabela1_pomoc$koeficijent2 == i))}

#Pomocni vektor za kolonu "duzina"
# MP: Ok
v_duzina <- c()
for(i in 1:brojac1) {v_duzina <- c(v_duzina, sum(tabela1_pomoc[tabela1_pomoc$koeficijent2 == i, "duzina"]))}

#Popunjavanje tabele
# MP: Kada su vec formirani svi vektori, moglo je samo cbind vektora u jedan data.frame ili komandom data.frame(od = v_od, do = v_do, ...)
for(i in 1:length(v_od)) {tabela2$od[i] <- v_od[i]} 
for(i in 1:length(v_do)) {tabela2$do[i] <- v_do[i]} 
for(i in 1:length(v_dh)) {tabela2$dh[i] <- v_dh[i]} 
for(i in 1:length(v_n)) {tabela2$n[i] <- v_n[i]}
for(i in 1:length(v_duzina)) {tabela2$duzina[i] <- v_duzina[i]}


nivelman
tabela1
tabela2
