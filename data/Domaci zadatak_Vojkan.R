#Neophodni paketi
library(tidyverse)
library(readxl)
#Ukoliko je potrebno export-ovati dobijene tabele
# library(writexl)

#Funkcija "nivelman"
nivelman <- function(merenja, reperi) {
  #Vraca listu koju cine dve tabele. Prva tabela sadrzi visinske razlike po stanici. Druga tabela sadrzi visinske razlike od repera do repera.
  #Argument "merenja" zahteva tabelu koja treba da sadrzi kolone (tacka, merenje, duzina) sa odgovarajuce pridruzenim vrednostima.
  #Argument "reperi" zahteva vektor repera koji se nalaze u mrezi. 
  
  #TABELA1
  tabela1 <- merenja %>%
    dplyr::mutate(koeficijent1 = rep(1:4, dim(merenja)[1]/4)) %>%
    dplyr::summarize(od = tacka[koeficijent1 == 1],
                     do = tacka[koeficijent1 == 2],
                     dh = (merenje[koeficijent1 == 1] - merenje[koeficijent1 == 2] + merenje[koeficijent1 == 4] - merenje[koeficijent1 ==3])/2,
                     duzina = (duzina[koeficijent1 == 1] + duzina[koeficijent1 == 2] + duzina[koeficijent1 == 3] + duzina[koeficijent1 == 4])/2)
  
  #TABELA2
  tabela1 <- tabela1 %>%
    dplyr::mutate(koeficijent2 = 0)
  
  #Promenljiva "brojac" kroz for petlju dodeljuje vrednosti koloni "koeficijent2".
  #Nakon izvrsene for petlje, promenljiva "brojac" predstavlja broj nivelmanskih vlakova.
  brojac <- 0
  for(i in 1:dim(tabela1)[1]) {
    if (tabela1$od[i] %in% reperi) {
      (brojac <- brojac + 1) & (tabela1$koeficijent2[i] <- brojac)
    } else {
      tabela1$koeficijent2[i] <- brojac
    }
  }
  
  brojvlakova <- brojac
  
  tabela2 <- tabela1 %>%
    dplyr::group_by(koeficijent2) %>%
    dplyr::summarize(od = od[1],
                     do = do[length(do)],
                     dh = sum(dh),
                     n = length(koeficijent2),
                     duzina = sum(duzina)) %>%
    dplyr::select(od, do, dh, n, duzina)
  
  tabela1 <- tabela1 %>%
    dplyr::select(od, do, dh, duzina)
  
  rezultat <- list(tabela1 = tabela1, tabela2 = tabela2)
  return(rezultat)
}

#Ucitavanje Excel tabela (rasporedjenih po sheet-ovima u okviru jednog Excel fajla) 
putanja <- "E:/GRF/Master akademske studije/Semestar 1/Nauka o podacima u R-u/4. cas (18.11.2020.)/Materijal/niv_merenja.xlsx"
lista1 <- putanja %>%
  readxl::excel_sheets() %>%
  purrr::set_names() %>%
  purrr::map(readxl::read_excel, path = putanja)

#Kroz for petlju, vrsi se primenjivanje funkcije "nivelman" na svaku tabelu u listi "lista1" i ubacivanje dobijenih rezultata u novu listu "lista2".
#Svaki clan u listi "lista2" ce se sastojati od liste koja sadrzi dve tabele (tabela1 i tabela2) koje su rezultat primene funkcije "nivelman".
lista2 <- list()
for(i in 1:length(lista1)) {
  lista2[i] <- list(nivelman(lista1[[i]], c("B1", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "S1", "S2", "S3", "D1", "H1", "J1", "M1", "P1", "D7", "H7", "N7", "D10", "E10", "I10", "P10", "P13", "L116",    "D19", "G19", "J19", "M19", "P19", "E26", "P26", "D29", "J29", "M29", "P29", "D32", "H32", "D38", "G38", "J38", "M38", "P38", "A11", "A12", "A13", "A14", "A21", "A22", "A23", "A24")))
}

#Spajanje svih tabela "tabela1" iz liste "lista2" u tabelu "tabela1sve"
#Spajanje svih tabela "tabela2" iz liste "lista2" u tabelu "tabela2sve"
tabela1sve <- data.frame()
tabela2sve <- data.frame()
for(i in 1:length(lista2)) {
  tabela1sve <- rbind(tabela1sve, lista2[[i]][[1]])
  tabela2sve <- rbind(tabela2sve, lista2[[i]][[2]])
}

tabela1sve
tabela2sve

#Ukoliko je potrebno export-ovati dobijene tabele
# writexl::write_xlsx(tabela1sve, "E:/GRF/Master akademske studije/Semestar 1/Nauka o podacima u R-u/4. cas (18.11.2020.)/Domaci zadatak/tabela1sve.xlsx")
# writexl::write_xlsx(tabela2sve, "E:/GRF/Master akademske studije/Semestar 1/Nauka o podacima u R-u/4. cas (18.11.2020.)/Domaci zadatak/tabela2sve.xlsx")

#Jedna mala kontrola koja proverava da li je funkcija rbind odradila dobro posao :)
# broj_vrsta1 <- 0
# broj_vrsta2 <- 0
# for(i in 1:length(lista2)) {
#   broj_vrsta1 <- broj_vrsta1 + dim(lista2[[i]][[1]])[1]
#   broj_vrsta2 <- broj_vrsta2 + dim(lista2[[i]][[2]])[1]
# }
# 
# if (dim(tabela1sve)[1] == broj_vrsta1 & dim(tabela2sve)[1] == broj_vrsta2) {
#   print("rbind radi sjajno")
# } else {
#     print("rbind ne radi sjajno")
#   }