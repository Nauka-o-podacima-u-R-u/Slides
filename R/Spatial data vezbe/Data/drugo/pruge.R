

### 1A3bi_R - Road Transport: Passengers cars - Rural transport (linijski izvor)
***
  
  Mreža puteva po kategorijama puteva:
  
  ```{r fig.align="center", fig.width=6, fig.height=8}
ggplot()+
  geom_sf(data = sf.1A3bi_R, aes(colour = Name))+
  coord_sf(datum=st_crs(32634))+
  scale_colour_manual(name = "Kategorija: ", values = c("red", "orange"))+
  labs(title = "Mreža puteva", 
       subtitle = "Klasifikacija po kategorijama puteva",
       caption = "Republika Srbija")+
  theme_bw()+
  theme(legend.position = "bottom")

```

Mreža puteva po vrednosti protoka saobraćaja:
  
  ```{r fig.align="center", fig.width=6, fig.height=8}
ggplot()+
  geom_sf(data = sf.1A3bi_R, aes(size = PGDS_2015/10000), colour = "black")+
  scale_size_identity()+
  coord_sf(datum=st_crs(32634))+
  labs(title = "Mreža puteva", 
       subtitle = "Klasifikacija po vrednosti protoka saobraćaja",
       caption = "Republika Srbija")+
  theme_bw()+
  theme(legend.position = "bottom")

```


```{r}
sf.1A3bi_R %<>% dplyr::select(ID, vars, PGDS_2015) 
```


Sumiranje ukupnih vrednosti po polutantima:
  
  ```{r eval=T, warning=F, message=F}
sum.sf.1A3bi_R <- sf.1A3bi_R %>%
  sf::st_drop_geometry() %>%
  dplyr::select(., vars) %>% 
  apply(., 2, sum) %>% 
  t(.) %>% 
  as.data.frame() %>%
  dplyr::mutate_if(is.numeric, round, 2)
sum.sf.1A3bi_R %>% datatable()
```


Presek sa gridom:
  
  ```{r eval=T, warning=F, message=F}
sf.1A3bi_R %<>% dplyr::mutate(Length = st_length(.),
                              PGDSL = PGDS_2015 * Length)

sf.1A3bi_R.int <- st_intersection(sf.1A3bi_R, gridUTM) %>%
  dplyr::select(., PGDS_2015, PGDSL, Length) %>%
  mutate(Length_int = st_length(.), 
         PGDS_int = (PGDS_2015/Length)*Length_int) %>%
  dplyr::select(., Length, PGDS_int)

sum_PGDS <- sum(sf.1A3bi_R.int$PGDS_int)

sf.1A3bi_R.int <- sf.1A3bi_R.int %>%
  dplyr::mutate(NOx = ((sum.sf.1A3bi_R$NOx/sum_PGDS)*PGDS_int),
                SO2 = ((sum.sf.1A3bi_R$SO2/sum_PGDS)*PGDS_int),
                PM10 = ((sum.sf.1A3bi_R$PM10/sum_PGDS)*PGDS_int),
                PM2_5 = ((sum.sf.1A3bi_R$PM2_5/sum_PGDS)*PGDS_int),
                NMVOC = ((sum.sf.1A3bi_R$NMVOC/sum_PGDS)*PGDS_int),
                NH3 = ((sum.sf.1A3bi_R$NH3/sum_PGDS)*PGDS_int)) %>% 
  dplyr::select(vars)

# Kontrola

sum.sf.1A3bi_R.int <- sf.1A3bi_R.int %>%
  sf::st_drop_geometry() %>%
  dplyr::select(., vars) %>% 
  apply(., 2, sum) %>% 
  t(.) %>% 
  as.data.frame() %>%
  dplyr::mutate_if(is.numeric, round, 2)

sum.sf.1A3bi_R
sum.sf.1A3bi_R.int
```

Prostorizacija - sumiranje vrednosti linijskih zagađivača po ćelijama grida:
  
  ```{r eval=T, warning=F, message=F}
p.1A3bi_R <- gridUTM %>%
  st_join(sf.1A3bi_R.int, join = st_contains) %>% 
  mutate(id = as.numeric(id)) %>%
  group_by(id) %>%
  summarize(NOx = sum(NOx, na.rm = TRUE),
            SO2 = sum(SO2, na.rm = TRUE),
            PM10 = sum(PM10, na.rm = TRUE),
            PM2_5 = sum(PM2_5, na.rm = TRUE),
            NMVOC = sum(NMVOC, na.rm = TRUE),
            NH3 = sum(NH3, na.rm = TRUE)) %>% 
  mutate(id = as.numeric(id))
#mapview(p.1A3bi_R) + mapview(sf.1A3bi_R.int)

# spatial overlay
join = st_join(gridUTM, sf.1A3bi_R.int)
# use the ID of the polygon for the aggregation
out = group_by(join, id) %>%
  summarize(length = sum(len))
# find out about polygons without line segments 
filter(out, is.na(length))




```


Kontrola:
  
  ```{r eval=T, warning=F, message=F}
sum.sf.1A3bi_R <- sf.1A3bi_R %>%
  sf::st_drop_geometry() %>%
  dplyr::select(., vars) %>% 
  apply(., 2, sum) %>% 
  t(.) %>% 
  as.data.frame() %>%
  dplyr::mutate_if(is.numeric, round, 2)

sum.p.1A3bi_R <- p.1A3bi_R %>%
  sf::st_drop_geometry() %>%
  dplyr::select(., vars) %>% 
  apply(., 2, sum) %>% 
  t(.) %>% 
  as.data.frame() %>%
  dplyr::mutate_if(is.numeric, round, 2)


data.frame(sum = c("prostorizovano", "ukupno", "razlika"), rbind(sum.p.1A3bi_R, sum.sf.1A3bi_R, data.frame(sum.p.1A3bi_R -  sum.sf.1A3bi_R))) %>%
  datatable(caption = "Tabela 2: Sumarne vrednosti razlika nakon prostorizacije") 

```


Mreža pruga:
  
  ```{r fig.align="center", fig.width=6, fig.height=8}
ggplot()+
  geom_sf(data = sf.1A3c, colour = "red")+
  coord_sf(datum=st_crs(32634))+
  labs(title = "Mreža železničke infrastrukture", 
       caption = "Republika Srbija")+
  theme_bw()+
  theme(legend.position = "bottom")

```

Ukupne vrednosti po polutantima:
  
  ```{r eval=T, warning=F, message=F}
sum.sf.1A3c <- data.frame(NOx = 524, SO2 = 0, PM10 = 14.4, PM2_5 = 13.7, NMVOC = 46.5, NH3 = 0.07)
sum.sf.1A3c
```

Presek sa gridom:
  
  ```{r eval=T, warning=F, message=F}
library(s2)
sf.1A3c[,vars] <- NA

sf.1A3c.int <- st_intersection(sf.1A3c, gridWGS84) %>%
  dplyr::select(.,vars) %>%
  dplyr::mutate(Length = st_length(.))

```


Interpolacija vrednosti po polutantima srazmerno duzini linijskog entiteta:
  
  ```{r eval=T, warning=F, message=F}

sum_Length <- sum(sf.1A3c.int$Length)


sf.1A3c.int <- sf.1A3c.int %>%
  mutate(NOx = ((sum.sf.1A3c$NOx/sum_Length)*Length),
         SO2 = ((sum.sf.1A3c$SO2/sum_Length)*Length),
         PM10 = ((sum.sf.1A3c$PM10/sum_Length)*Length),
         PM2_5 = ((sum.sf.1A3c$PM2_5/sum_Length)*Length),
         NMVOC = ((sum.sf.1A3c$NMVOC/sum_Length)*Length),
         NH3 = ((sum.sf.1A3c$NH3/sum_Length)*Length))
sf.1A3c.int %<>% dplyr::select(vars)


```

Prostorizacija - sumiranje vrednosti linijskih zagađivača po ćelijama grida:
  
  ```{r eval=T, warning=F, message=F}
sf.1A3c.int %<>% st_transform(4326)
gridWGS84


p.1A3c <- gridWGS84 %>%
  st_join(sf.1A3c.int, join = st_contains) %>% 
  group_by(id) %>%
  summarize(NOx = sum(NOx, na.rm = TRUE),
            SO2 = sum(SO2, na.rm = TRUE),
            PM10 = sum(PM10, na.rm = TRUE),
            PM2_5 = sum(PM2_5, na.rm = TRUE),
            NMVOC = sum(NMVOC, na.rm = TRUE),
            NH3 = sum(NH3, na.rm = TRUE)) %>% 
  mutate(id = as.numeric(id))




```

Kontrola:
  
  ```{r}

sum.p.1A3c <- p.1A3c %>%
  sf::st_drop_geometry() %>%
  dplyr::select(., vars) %>% 
  apply(., 2, sum) %>% 
  t(.) %>% 
  as.data.frame() %>%
  dplyr::mutate_if(is.numeric, round, 2)


data.frame(sum = c("prostorizovano", "ukupno", "razlika"), rbind(sum.p.1A3c, sum.sf.1A3c, data.frame(sum.p.1A3c -  sum.sf.1A3c))) %>%
  datatable(caption = "Tabela 2: Sumarne vrednosti razlika nakon prostorizacije") 

```