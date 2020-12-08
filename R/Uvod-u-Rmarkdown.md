---
title: "Uvod u Rmarkdown"
author: "Milutin Pejović"
date: "03 December 2020"
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

# Uvod

`Rmarkdown` je okruženje u okviru `R` programskog jezika koje nam omogućava da kreiramo dokumente koji objedinjuju R kod, rezultate koda i prateći tekst. U okviru `Rmarkdown`-a moguće je kreirati različite dokumente u različitim formatima, kao što su html, pdf, word, prezentaciju itd. 

`Rmarkdown` je prevashodno namenjen da:

1.  Da omogući lakšu komunikaciju između onoga ko radi na rešavanju nekog problema i onoga ko će da donese odluku na osnovu rezultata, omogućavajući onome ko donosi odluke da se fokusira na rezultate i tekst, a ne na kod. 

1.  Da omogući komunikaciju između ljudi (uključujući i budućeg tebe) tako što će kod biti praćen određenim tekstom koji će objašnjavati kako se došlo do određenih rezultata.
    
1.  Da omogući bolju dokumentaciju onoga što je urađeno.


Primer jednog jednostavnog `Rmarkdown` dokumenta:



````
---
title: "Diamond sizes"
date: 2016-08-25
output: html_document
---

```{r setup, include = FALSE}
library(ggplot2)
library(dplyr)
smaller <- diamonds %>% 
  filter(carat <= 2.5)
```

We have data about `r nrow(diamonds)` diamonds. Only 
`r nrow(diamonds) - nrow(smaller)` are larger than
2.5 carats. The distribution of the remainder is shown
below:

```{r, echo = FALSE}
smaller %>% 
  ggplot(aes(carat)) + 
  geom_freqpoly(binwidth = 0.01)
```
````

Svaki `Rmarkdown` dokument se sastoji iz tri osnovna dela:

1.  __YAML zaglavlje (header)__ koji je počinje i završava se sa `---`.
1.  R kod ( __Chunks__ ) koji počinje i završava se sa  ```` ``` ````.
1.  Tekst koji može da se oblikuje sa nekim jednostavnim pravilima sintakse, npr. `# heading` and `_italics_`.

Da bi ste kreirali `Rmarkdown` dokumenta potrebno je u okviru `Rstudio`-a iz `file` menija odabrati opciju `New file`, pa iz podmenija `Rmarkdown`. Tada će vam se otvoriti dijalog prozor u koji je potrebno uneti osnovne informacije o naslovu, autoru i tipu izlaznog fajla, a nakon toga i `Rmarkdown` okruženje, tzv. `notebook` okruženje.

<img src="C:/R_projects/Nauka_R/Slides/Figures/rmarkdown_1.png" width="2880" />


Da biste kreirairali finalni dokument potrebno je proslediti `.Rmd` fajl paketu koji se zove `knitr`. `knitr` ima zadatak da izvrši sav kod koji se nalazi u `.Rmd` fajlu i da kreira rezultate koda. Kao izlaz iz `knitr` paketa, formira se `.md` (markdown) fajl. Zatim, se `.md` fajl prosledjuje u `pandoc` [universal document converter](https://pandoc.org/). On je zadužen da kreira finalni izlazni fajl. 


<img src="C:/R_projects/Nauka_R/Slides/Figures/rmarkdown_3.png" width="709" />



### Oblikovanje teksta u Rmarkdown-u



```
Text formatting 
------------------------------------------------------------

*italic*  or _italic_
**bold**   __bold__
`code`
superscript^2^ and subscript~2~

Headings
------------------------------------------------------------

# 1st Level Header

## 2nd Level Header

### 3rd Level Header

Lists
------------------------------------------------------------

*   Bulleted list item 1

*   Item 2

    * Item 2a

    * Item 2b

1.  Numbered list item 1

1.  Item 2. The numbers are incremented automatically in the output.

Links and images
------------------------------------------------------------

<http://example.com>

[linked phrase](http://example.com)

![optional caption text](path/to/img.png)

Tables 
------------------------------------------------------------

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell
```

Korisni saveti i trikovi za oblikovanje i formatiranje Rmarkdown dokumenta mogu se naći na sledećim linkovima:

> Zadatak 1
> - Koristeči navedena pravila sintekse za oblikovanje teksta, napisati kratko svoj CV.

## R kod

Kao što je već rečeno, R kod je sastavni deo `Rmarkdown` fajla. R kod se može dodati na jedan od tri načina: 

1. Preko prečice na tastaturi Cmd/Ctrl + Alt + I

1. Korišćenjem "Insert" ikone u okviru `editor toolbar`-a.

1. I manuelno, ukucavanjem ` ```{r} ` and ` ``` `.

Nakon ukucavanja koda, potrebno je proveriti da li kod radi. Prečica `Cmd/Ctrl + Shift + Enter` izvršava ceo kod iz jednog `chunk`-a.

U cilju bolje organizacije i navigacije u okviru `Rmarkdown` fajlam, svakom `R chunk` - u se može dodeliti ime. : ```` ```{r by-name} ````. 

### `Chunk` opcije

Prikaz rezultata R koda može biti prilagođen potrebama. Na primer, rezultati R koda, koji se odnosi na neku pomoćnu računicu, kao i sam R kod ne moraju biti prikazani u konačnom fajlu. Moguće je podesiti da se kod izvršava ali da rezultati ne budu prikazani u okviru konačnog fajla. `Knitr` omogućava oko 60 opcija kojima se kontroliše R kod u okviru `Rmarkdown` fajla. U okviru ovog predavanja, spomenućemo samo najčešće korišćene opcije. Cela lista se može pogledati na <http://yihui.name/knitr/options/>. 

Najčeće korišćene opcije su:
  
*   `eval = FALSE`  - kod se ne izvšava.

*   `include = FALSE` - isključuje kod iz konačnog dokumenta.

*   `echo = FALSE` - kod se izvšava ali se ne prikazuje u konačnom dokumentu.
    
*   `message = FALSE` or `warning = FALSE` - isključuje ili uključuje poruke i upozorenja.

*   `results = 'hide'` i `fig.show = 'hide'`  - isključuje rezultate iz konačnog dokumenta.

*   `error = TRUE` - nastaljna sa izvšenjem nekog koda u slučaju da se pojavi greška u kodu.
    
Sumarna tabela:

Option             | Run code | Show code | Output | Plots | Messages | Warnings 
-------------------|----------|-----------|--------|-------|----------|---------
`eval = FALSE`     | -        |           | -      | -     | -        | -
`include = FALSE`  |          | -         | -      | -     | -        | -
`echo = FALSE`     |          | -         |        |       |          |
`results = "hide"` |          |           | -      |       |          | 
`fig.show = "hide"`|          |           |        | -     |          |
`message = FALSE`  |          |           |        |       | -        |
`warning = FALSE`  |          |           |        |       |          | -


#### Tabele

Za prikaz tabela preporučuje se koriščenje komanda `kable` iz paketa `knitr`


```r
knitr::kable(
  mtcars[1:5, ], 
  caption = "A knitr kable."
)
```



Table: A knitr kable.

|                  |  mpg| cyl| disp|  hp| drat|    wt|  qsec| vs| am| gear| carb|
|:-----------------|----:|---:|----:|---:|----:|-----:|-----:|--:|--:|----:|----:|
|Mazda RX4         | 21.0|   6|  160| 110| 3.90| 2.620| 16.46|  0|  1|    4|    4|
|Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90| 2.875| 17.02|  0|  1|    4|    4|
|Datsun 710        | 22.8|   4|  108|  93| 3.85| 2.320| 18.61|  1|  1|    4|    1|
|Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08| 3.215| 19.44|  1|  0|    3|    1|
|Hornet Sportabout | 18.7|   8|  360| 175| 3.15| 3.440| 17.02|  0|  0|    3|    2|

#### `Caching` - memorisanje rezultata

Svaki put kada se pozove komanda `knit`, `knitr` prolazi kroz ceo dokument i izvršava svaki R `chunk` koji je opcijama namenjen za izvršavanje. Međutim, ukoliko u dokumentu postoji neki deo koda koji je zahtevana za izvršavanje, moguće je izbeći ponovno izvršavanje tog koda tako što će se rezultati tog `chunk`-a memorisati.



```r
rawdata <- readr::read_csv("a_very_large_file.csv")
```


```r
processed_data <- rawdata %>% 
  filter(!is.na(import_var)) %>% 
  mutate(new_variable = complicated_transformation(x, y, z))
```

#### `Inline` kod


```r
reperi <- c("B1", "B2", "B3", "B4", "B5")
```


R kod je moguće dodati i u okviru teksta. Na primer, ukoliko u tekstu želimo da spomenemo neke nazive (npr. nazive prva četiri repera iz vektora naziva repera), to ćemo učiniti tako što ćemo kucati: B1, B2, B3, B4.



    
