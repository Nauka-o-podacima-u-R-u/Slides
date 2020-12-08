---
title: "Uvod u vizualizaciju podataka u R-u"
author: "Milutin Pejović"
date: "02 December 2020"
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










# Vizualizacija podataka u R-u

Vizualizacija podataka podrazumeva kreiranje različitih vrsta grafika i odnosno prikaza podataka u cilju otkrivanja informacija koje na prvi pogled nisu tako uočljive. `R` ima tri odvojena okruženja za kreiranje grafika, `base`, `Lattice` i `ggplot`. U poslednje vreme `ggplot` je daleko najpopularniji paket i upravo on doprinosi velikoj popularizaciji R-a. Sa druge strane `base` plot nikada neće izaći iz upotrebe medju R korisnicima. Njega odlikuje jednostavnost poziva funkcija. 

## `base` plot


```r
a <- rnorm(100)
b <- 3*a + rnorm(100)
ab <- data.frame(a, b)

plot(a ~ b, data = ab)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
plot(a, b)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-4-2.png)<!-- -->

```r
plot(ab$a)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-4-3.png)<!-- -->

```r
hist(a)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-4-4.png)<!-- -->

Glavni parametri fukcije plot su:

`+ `type` what type of plot should be drawn. Possible types are

- "p" for points,

- "l" for lines,

- "b" for both,

- "c" for the lines part alone of "b",

- "o" for both ‘overplotted’,

- "h" for ‘histogram’ like (or ‘high-density’) vertical lines,

- "s" for stair steps,

- "S" for other steps, see ‘Details’ below,

- "n" for no plotting.

+ `main` Naslov grafika

+ `sub` Pod-naslov grafika

+ `xlab` Naziv x-ose

+ `ylab` Naziv y-ose

+ `asp` odnos x-y osa

Koristei komandu `par` mogu se definisati dodatni parametri izgleda grafika.

+ `pch`: simbol tačke (otvoreni krug je po default-u)
+ `lty`: simbol linije
+ `lwd`: debljina linije
+ `col`: boja, (moguće je definisati rednim brojem, nazivom ili kodom).
+ `las`: orijentacija naziva osa
+ `bg`: boja pozadine
+ `mar`: margine
+ `oma`: spoljne margine
+ `mfrow`: broj grafika po redu
+ `mfcol`: broj grafika po koloni


Postoje i dodatne funkcije koje proširuju mogućnosti `base` plot okruženja.

+ `plot`: kreira plot u zavisnosti od klase podataka
+ `lines`: dodaje linije na već postojeći plot na osnovu matrice koordinata
+ `points`: dodaje tačke na već postojeći plot
+ `text`: dodaje tekst (label) na već postojeći plot na osnovu koordinata koje definišu poziciju teksta
+ `mtext`: dodaje proizvoljan tekst na marginama plota
+ `axis`: dodaje nazive osa



```r
plot(a, b, pch = 5)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
plot(a[1:5], b[1:5], type = "l")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
plot(a[1:5], b[1:5], type = "b")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```r
# korišćenje komande `par`
par(mfrow = c(1, 2))
hist(a)
plot(a[1:5], b[1:5], type = "b")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-5-4.png)<!-- -->


## `Lattice`
`Lattice` paket je napisan da unapredi mogućnosti `base` plot okruženja. Napisan je tako da podržava kreiranje tzv. uslovnih ili `trellis` grafika - grafika koji prikazuju je jednu ili odnos više promenljivih u odnosu na druge promenljive.

Tipičan poziv Lattice plot funkcije izgleda ovako:
```javascript
graph_type(formula, data=) 
```
gde je`graph_type` tip grafika (iz tabele dole). `formula` definiše promenljive koje se prikazuju kao i druge (uslovne) promenljive.  Na primer, ~x prikazuje samo promenljivu `x`; ~x|A prikazuje distribuciju promenljive `x` za svaki nivo faktorske promenljive `A`. `y~x | A*B` znači prikazati odnos `x`-a i `y`-a odvojeno za svaku kombinaciju novoa faktorskih promenljivih `A` i `B`. 


|  tip grafika  |   Opis                 |   Primer formule   |
|---------------|------------------------|--------------------|
|  barchart     |   bar chart            |   x~A or A~x       |
|  bwplot       |   boxplot              |   x~A or A~x       |
|  cloud        |   3D scatterplot       |   z~x*y/A          |
|  contourplot  |   3D contour plot      |   z~x*y            |
|  densityplot  |   kernal density plot  |   ~x/A*B           |
|  dotplot      |   dotplot              |   ~x/A             |
|  histogram    |   histogram            |   ~x               |
|  levelplot    |   3D level plot        |   z~y*x            |
|  parallel     |   parallel plot        |   data frame       |
|  splom        |   scatterplot matrix   |   data frame       |
|  stripplot    |   strip plots          |  A~x or x~A        |
|  xyplot       |   scatterplot          |   y~x*/A           |
|  wireframe    |   3D wireframe graph   |   z~y*x            |


```r
library(lattice)

mpg$cyl <- factor(mpg$cyl)

densityplot(~hwy, data=mpg)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
densityplot(~displ|cyl, data=mpg)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

```r
densityplot(~disp, groups=cyl, data=mtcars)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-6-3.png)<!-- -->


## `ggplot2`

`ggplot2` je daleko najpopularnije okruženje za kreiranje grafika. `ggplot2` predstavlja implementaciju poznatog pristupa poznatog po nazivu "The Grammar of Graphics" koji je predstavljen u istoimenoj knjizi autora Leland Wilkinson-a. Ovaj pristup je zasnovan na lejerskoj kompoziciji grafika.

### Instalacija

Pristup paketu `ggplot`, kao i podacima i help-u koji uz paket dolazi, omogućen je kroz učitavanje paketa `tidyverse`.


```r
library(tidyverse)
```


U okviru ggplot-a svaki grafik je sastavljen od komponenti. Komponente `ggplot` grafika je:

Obavezni elementi:

+ `data` -  izvor informacija (data.frame)

+ `aesthetic mapping` U ggplot okruženju **aestetics** (ili skraćeno **aes**) se odnosi na vizuelne atribute, kao što su veličina (size), oblik (shape) ili boja (color) nekog geometrijskog elementa (npr. tačka). Argument `mapping` se uvek povezuje sa `aes()`, a u okviru `aes()` definišu se atributi prikaza, izmedju ostalog `x , y, shape, color`. Promenljive iz `data` se dodeljuju **aestetics** atributima npr(`mapping = aes(x = latitude, y = longitude, color = GPS_quality)`).

+ `geom` - geometrijski objekat (`geom_point`, `geom_line`...)

Opcione komponente

+ `stat`  - omogućava transformaciju podataka u neku novu vrednost koja će biti dodeljena **aestetics** atributu,

+ `scales` - odredjuje odnos vrednosti podataka sa vrednostima **aestetics** atributa.

+ `coord`  - koordinatni sistem (ortogonalni, polarni)

+ `facet` - omogućava podelu grafika na više grafika (npr. prema nivoima nekog faktora)  





+ Layer - jedan lejer na grafiku
  - Data (data) - izvor informacija (data.frame)
  - Mapping (mapping) - definise koje promenljive i kako ce biti prikazane. 
  - Statistical transformation (stat) - transformise podatke
  - Geometric object (geom) - geometrijski objekat (prikaz, npr. tačka, linija...)
  - Position adjustment (position) - definiše poziciju (npr. bar plot/dodge or scatterplot jitter)
  - Scale - definiše kako će promenljive biti prikazane u odnosu na **aestetics** atribut,
+ Coordinate system (coord) - koordinatni sistem
+ Faceting (facet) - omogućava podelu grafika na više grafika (npr. prema nivoima nekog faktora)
+ Defaults - omogućava prepoznavanje određenih plotova
  - Data
  - Mapping
  
Tipičan poziv `ggplot` funkcije izgleda ovako:

```javascript
ggplot(data = <DATA>) +
 <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```


### The `mpg` data frame



```r
mpg
```

```
## # A tibble: 234 x 11
##    manufacturer model    displ  year cyl   trans   drv     cty   hwy fl    class
##    <chr>        <chr>    <dbl> <int> <fct> <chr>   <chr> <int> <int> <chr> <chr>
##  1 audi         a4         1.8  1999 4     auto(l~ f        18    29 p     comp~
##  2 audi         a4         1.8  1999 4     manual~ f        21    29 p     comp~
##  3 audi         a4         2    2008 4     manual~ f        20    31 p     comp~
##  4 audi         a4         2    2008 4     auto(a~ f        21    30 p     comp~
##  5 audi         a4         2.8  1999 6     auto(l~ f        16    26 p     comp~
##  6 audi         a4         2.8  1999 6     manual~ f        18    26 p     comp~
##  7 audi         a4         3.1  2008 6     auto(a~ f        18    27 p     comp~
##  8 audi         a4 quat~   1.8  1999 4     manual~ 4        18    26 p     comp~
##  9 audi         a4 quat~   1.8  1999 4     auto(l~ 4        16    25 p     comp~
## 10 audi         a4 quat~   2    2008 4     manual~ 4        20    28 p     comp~
## # ... with 224 more rows
```

Neke od promenljivih `mpg` seta podataka su:

1. `displ`, kubikaza motora u litrima,

1. `hwy`, efikasnost automobila na autoputu. u miljama po galonu (mpg). Automobili sa vecom efikasnoscu trose manje goriva.

Vise o podacima `?mpg`.

### Kreiranje ggplot-a

Kreiranje ggplot grafika uvek počinje pozivom komande `ggplot`. 


```r
ggplot(data = mpg)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-8-1.png)<!-- -->



Ukoliko zelimo da prikazemo odnos kubikaze i efikasnosti, definisacemo osnovne komponente grafika na sledeci nacin:


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-9-1.png)<!-- -->


> Zadatak 1
> 
> + Pregledati `mpg` podatke. Koliko kolona, a koliko redova ima `mpg` data frame.
> + Šta predstavlja promenljiva `drv`?
> + Napravi grafik odnosa hwy vs cyl.
> + What happens if you make a scatterplot of class vs drv? Why is the plot not useful?


```r
ggplot(data = mpg) + geom_point(aes(x = class, y = drv))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Aesthetic mappings

> "The greatest value of a picture is when it forces us to notice what we
> never expected to see." --- John Tukey



![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

U terminologiji pristupa `The grammar of graphics` (`ggplot`)`Aestetic` se odnosi na vizelne osobine prikaza neke promenljive. Tu mislimo pre svega na boju (`color`), oblik (`shape`) ili veličinu (`size`). Naravno i pozicija na grafiku predstavlja jednu osobinu prikaza, medjutim ona se smatra `default` osobinom. Različite informacije koje nose podaci mogu se prikazati pomoću `aestetic` parametara. Generalno, `Aestetic mapping` nam omogućava prikazivanje više promenljivih na jednom grafiku. `Aestetic` parametri se definišu u okviru komande `aes()`. Na primer, ukoliko želimo da prikažemo i promenljivu `class` na našem grafiku, u okviru `aestetic` parametara ćemo definisati da boja zavisi od promenljive `class`. 


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

Na ovom grafiku vidimo da se tačke koje odstupaju odnose na "coupe" (2seats) automobile. 

Slično, ista promenljiva može biti prikazana korišćenjem parametra `size`:


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
```

```
## Warning: Using size for a discrete variable is not advised.
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

Definisanjem `aestetic` parametara, `ggplot` automatski dodeljuje jednu vrednost svakoj vrednosti promenljive kroz proces koji se zove `scaling`. Pored toga, legenda se automatski generiše. Naravno, prikaz legende je moguće menjati.

Postoje i drugi `aestetic` parametri, kao na primer `alpha` kojim se definiše transparentnost prikaza. 


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
```

```
## Warning: Using alpha for a discrete variable is not advised.
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

Pored toga, aestetic parametri se mogu definisati i manuelno. Drugim rečima, ne moraju biti vezani za promenljivu. U tom slučaju, moraju biti definisani "izvan"  zagrade `aes()`.


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-15-1.png)<!-- -->


> Zadatak 2
> 
> + Šta mije u redu sa sledecim kodom? `ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))` Zašto su tačke crvene?
> + Koje promenljive su kontinualne, a koje kategoričke?
> + Prikazati kontinualne promenljive kroz `color`, `size` i `shape` aestetics. U čemu se razlikuje prikaz kategoričkih promenljivih kroz isti prikaz.


## Geometrijski objekti (`geom_`)

Geometrijski objekti (`geom_`) su geometrijska vrsta prikaza koja je odabrana za prikaz podataka. To mogu biti tačka (`geom_point`), linija (`geom_line`), stub (`geom_bar`), tačka (`geom_path`), box-plot (`geom_box`) i mnogi drugi.  

Na primer, iste podatke možemo prikazati pomoću dva različita geometrijska objekta. 

<img src="Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-16-1.png" width="50%" />


Svaki geometrijski objekat se dodaje na osnovni grafik u vidu lejera, pa ga često nazivamo i geometrijski lejer. U okviru geometrijskog lejera definiše se parametar `mapping` u okviru koga se definišu `aestetic` parametri.      Međutim, nisu svi aestetic parametri zajednički za sve geometrije. Na primer, nije moguće definisati `aestetic` parametar `shape` za geometriju linije. Umesto toga, postoji `aestetic` parametar `linetype`. 


```r
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

`ggplot` omogućava korišćenje preko 40 geometrijskih prikaza. Pregledni prikaz je dat u okviru [ggplot cheetsheet-a](https://raw.githubusercontent.com/rstudio/cheatsheets/master/data-visualization-2.1.pdf)

Neki geometrijski objekti (lejeri) služe za prikaz više podataka kroz jedan objekat. Kao na primer `geom_smooth`. Međutim, moguće je definisati `aestetic` parametar `group` koji će se odnositi na neku kategoričku promenljviu u podacima, čime će se definisati prikaz razlikičitih grupa podataka istom geometrijom.    



```r
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

```r
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-18-2.png)<!-- -->

```r
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-18-3.png)<!-- -->



> Postoje brojne "ekstenzije" ggplot  [ggplot extensions](https://exts.ggplot2.tidyverse.org/gallery/)



### Lejeri

Ukoliko želimo da prikažemo više geometrijskih objekata na jednom grafiku, moguće je samo dodati različite geometrijske lejere i definisati njihove parametre.


```r
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

          
Međutim, ovde se može primetiti da su isti parametri korišćeni u oba lejera. Ako zamislimo, neki grafik sa više lejera koji koriste iste `aestetic` parametre, i ako želimo promeniti neki parametar, on se mora menjati na više mesta u našem kodu. Da bi se to izbeglo, moguće je definisati `aestetic` parametre izvan geometrijskih lejera (u okviru `ggplot` funkcije). Tako definisani aestetic parametri se smatraju "globalnim" i primenjuju se u svim geoemtrijskim lejerima u okviru grafika.


```r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

Međutim, to ne znači da se dodatni `aestetic` parametri ne mogu definisati u okviru svakog geometrijskog lejera. Tako na primer, promeljiva `class` se može uključiti u lejer `geom_point` na sledeći način:


```r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

> Zadatak 3:
> + Pokušajte da reprodukujete sledeće grafike:

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-22-1.png)<!-- -->


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE) # se - confidence interval 
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-23-1.png)<!-- -->



```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(group = drv), se = FALSE) + # f = front-wheel drive, r = rear wheel drive, 4 = 4wd
  geom_point() 
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

```r
# grupisanje po vrednosti kategoričke promenljive - atribut drv
```


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(group = drv, colour = drv), se = FALSE) +   
  geom_point(mapping = aes(colour = drv))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

```r
# ILI 

#ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) +
#  geom_point() +
#  geom_smooth(se = FALSE)
```


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-26-1.png)<!-- -->


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-27-1.png)<!-- -->


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-28-1.png)<!-- -->


## Grafik kao alat komunikacije

Nauka o podacima u R-u, Čas vežbi, 02-12-2020 


U okviru ovog dela fokus je na mogućnostima ggplot2 paketa u cilju kreiranja kvalitetnih grafika i dodavanja neophodnih elemenata. Elementi grafika koji su neophodni kako bi kreirali dobar grafik, koji krajnjem korisniku nudi pravi uvid u podatke i nije dvosmislen, odnosi se na oznake koje svaki grafik treba da ima, anotacije, razmeru osa, legendu, temu i čuvanje grafika u visokoj rezolciji. 

### Oznake grafika

Pre svega dobar grafik mora imati naslov koji verno opisuje podatke (title), a opciono i podnaslov (subtitle), komentar (caption) i nazive po osama (xlab, ylab).


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-29-1.png)<!-- -->



```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-30-1.png)<!-- -->



```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov", 
    x = "Engine displacement [litres]",
    y = "Highway miles per gallon"
  )
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-31-1.png)<!-- -->


### Anotacije

Kao što je bitno da imamo generalno naslov i podnaslov, kao i nazive osa čime definišemo glavne komponente grafika, isto tako je ponekad korisno da postavimo anotacije - označimo merene vrednosti ili grupe merenih vrednosti na grafiku.


```r
# pull out the most efficient car in each class with dplyr, and then label it on the plot

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)


ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_text(data = best_in_class, aes(x = displ, y = hwy, label = model))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-32-1.png)<!-- -->



```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5)
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-33-1.png)<!-- -->


Da ne bi imali preklapanja u anotacijama, možemo korstiti paket ggrepel. Paket automatski pomera anotacije kako se ne bi preklapale.


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_point(data = best_in_class, size = 4, shape = 1) +
  ggrepel::geom_label_repel(data = best_in_class, aes(label = model))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

Ako želimo da postavimo anotacije po grupama - klasama, to možemo uraditi na sledeći način.


```r
class_avg <- mpg %>%
  group_by(class) %>%
  summarise(
    displ = median(displ),
    hwy = median(hwy)
  )
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
class_avg
```

```
## # A tibble: 7 x 3
##   class      displ   hwy
##   <chr>      <dbl> <dbl>
## 1 2seater     6.2   25  
## 2 compact     2.2   27  
## 3 midsize     2.8   27  
## 4 minivan     3.3   23  
## 5 pickup      4.7   17  
## 6 subcompact  2.2   26  
## 7 suv         4.65  17.5
```


```r
ggplot(mpg, aes(displ, hwy, colour = class)) +
  ggrepel::geom_label_repel(aes(label = class),
    data = class_avg,
    size = 6,
    label.size = 0,
    segment.color = NA
  ) +
  geom_point() +
  theme(legend.position = "none")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-36-1.png)<!-- -->

### Razmera

Razmerom se definiše odnos osa na grafiku, razmera pojedinačnih osa, kao i razmak između vrednosti nanteih na osama grafika. Po default-u ggplot definiše sam razmeru osa, koju naravno može i korisnik definisati.


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-37-1.png)<!-- -->


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-38-1.png)<!-- -->

```r
ggplot(mpg, mapping = aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth() +
  coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-39-1.png)<!-- -->

```r
# U čemu je razlika?

mpg %>%
  filter(displ >= 5, displ <= 7, hwy >= 10, hwy <= 30) %>%
  ggplot(aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-39-2.png)<!-- -->


### Legenda

https://www.datanovia.com/en/blog/ggplot-legend-title-position-and-labels/


```r
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))+
  labs(colour = "Class of cars")

base + theme(legend.position = "left")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-40-1.png)<!-- -->

```r
base + theme(legend.position = "top")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-40-2.png)<!-- -->

```r
base + theme(legend.position = "bottom")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-40-3.png)<!-- -->

```r
base + theme(legend.position = "right")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-40-4.png)<!-- -->

+theme(legend.position = "none") - na ovaj način ne prikazujemo legendu podataka

Isto tako kao što definišemo razmeru osa, odnos boja kojima prikazujemo podatke je bitan i često imamo predefinisane klase boja kojima želimo da prikažemo podake. Postoje i paketi kojima možemo da kreiramo paletu boja po želji, kako za kontinualne tako i za diskretne podatke.


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-41-1.png)<!-- -->

```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-41-2.png)<!-- -->

paket "viridis" nudi veoma kvalitetne palete boja, pre svega za kontinualne podatke.


```r
df <- tibble(
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() +
  coord_fixed()
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-42-1.png)<!-- -->

```r
ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis(option = "D") +
  coord_fixed()
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-42-2.png)<!-- -->

```r
ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis(option = "B") +
  coord_fixed()
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-42-3.png)<!-- -->

### Tema

Bitan element kreiranja grafika je tema, putem koje se definišu parametri i elemnti grafika koji ne sadrže podatke.

Pogledati: https://github.com/jrnold/ggthemes


```r
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](Vizualizacija-podataka-u-R-u_files/figure-html/unnamed-chunk-43-1.png)<!-- -->

### Čuvanje grafika

Grafik čuvamo komandom ggsave, u okviru koje se definišu parametri plot - promenljiva koja sadrži grafik, filename - putanja ka izlaznom fajlu, width - širina grafika, height - visina grafika, units - jedinice u kojima je izražena širina i visina, device - format podataka, dpi - "dots per inch" rezolucija, kvalitet grafika.


```r
graf1 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggsave(plot = graf1, 
       filename = "D:/R_projects/Nauka_R/Slides/R/graf1.jpg", 
       width = 30, 
       height = 30, 
       units = "cm", 
       device = "jpeg", 
       dpi = 300)
```
