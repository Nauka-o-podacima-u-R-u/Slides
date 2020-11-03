---
title: "Nauka o podacima"
author: "Milutin Pejović"
date: "21 November 2019"
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

<style>
body {
text-align: justify}
</style>

# R markdown

R markdown je okruzenje za "Literate programming" ili pisanje programiranih izveštaja. On omogućava da u isti dokument stavite lepo formatirani tekst i kod kojim se izvršava određena operacija nad podacima, a rezultati te operacije su sastavni deo izveštaja. R markdown vam omogućava da ispričate priču koju kriju vaši podaci.

Pored toga, R markdown vam omogućava da birate željeni izlazni format od mnogih koje podržava, kao što su:

- [HTML](https://bookdown.org/yihui/rmarkdown/html-document.html)
- [PDF](https://bookdown.org/yihui/rmarkdown/pdf-document.html)
- [WORD](https://bookdown.org/yihui/rmarkdown/word-document.html)
- [Beamer](https://bookdown.org/yihui/rmarkdown/beamer-presentation.html)
- [HTML5 slides](https://bookdown.org/yihui/rmarkdown/ioslides-presentation.html)
- [...](https://bookdown.org/yihui/rmarkdown/documents.html)


# Učitavanje neophodnih R paketa

R paketi su setovi R funkcija kreiranih od strane R korisnika. R paketi proširuju mogućnosti R-a. Pored osnovnog R paketa (seta funkcija) koji dolazi uz instalaciju R-a, R korisnici mogu potražiti dodatne funkcije koje bi im pomogle u rešavanju nekog problema. Trenutno postoji preko 10000 R paketa namenjenih različitim korisnicima i njihovim potrebama. Neki paketi su popularniji, a neki manje popularni. Logično je da paketi koji koriste širokom spektru korisnika imaju veću popularnost. Popularnost se ogleda u broju korisnika. Jedan takav primer je paket za vizualizaciju podataka "ggplot".

Da bi se neki paket koristio mora se instalirati na lokalnom računaru. Za uspešan rad na ovom kursu, neophodno je instalirati nekoliko paketa. To ćemo uraditi sledećom funkcijom:


```r
packages <- c("usethis", "tidyverse", "rmarkdown")

install.packages(packages, dependencies = c("Depends", "Imports"))
```

Učitavanje paketa se radi komandom `library()`


```r
library(usethis)
library(tidyverse)
library(rmarkdown)
```



# Instalacija Git-a

Git je *verstion control* sistem namenjen za praćenje promena u kodu tokom razvijanja nekog softvera. Pored toga, može biti korišćen za praćenje promena na bilo kojem setu fajlova.  Dizajniran je tako da podržava kolaborativan rad. Da bi se Git koristio, mora se instalirati na računaru. Instalacija Git-a za Windows korisnike (korak po korak) data je na sledećem linku: [Instalacija Git-a](https://rafalab.github.io/dsbook/accessing-the-terminal-and-installing-git.html#installing-git-and-git-bash-on-windows).


# Kreiranje profila na Github-u

Nakon instaliranja Git-a, prvi korak je kreiranje profila na Github-u. Preporuka je da prilikom odabira vašeg Github korisničkog imena, odaberete ime koje nedvosmisleno asocira na vas. To može biti vaše ime i prezime ili neka skraćenica istih. 

Kreiranje Github profila može se uraditi prateći sledeća [uputstva](https://www.wikihow.com/Create-an-Account-on-GitHub)


# Podešavanje Git-a

Nakon što ste instalirali Git i napravili profil na Github-u, potrebno autorizovati Git, odnosno predstaviti se git-u. To je moguće uraditi na dva načina:

***Prvi način:***
Prvi način podrazumeva korišćenje komandnog programa `git Bash`

```r
git config --global user.name "Your Name"
git config --global user.mail "your@email.com"
git config --global --list
```

Više o komandnim programima na [sledećem linku](http://remi-daigle.github.io/2016-04-15-UCSB/shell/) i na [Software Carpentry lesson](http://swcarpentry.github.io/shell-novice/)

***Drugi način:***
Drugi način podrazumeva korišćenje fukncije iz paketa `usethis`:



```r
install.packages("usethis")
library(usethis)

use_git_config(user.name = "MilutinPejovic", user.email = "milutinpejovic@grf.bg.ac.rs")
```

# R markdown
