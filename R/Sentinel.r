#' ---
#' title: "Oblikovanje podataka"
#' subtitle: Sentinel data analysis
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
#' 
#' ## Analiza Sentinel podataka
#' 
#' ### Učitavanje i transformacija
#' 
#+ eval = TRUE, include = TRUE 

# Ucitavanje merenja
sentinel2 <- readxl::read_xlsx("./data/Sentinel2_Crops.xlsx")

s1 <- sentinel2[1, ]

s1$Image_dates

strsplit(s1$Image_dates, " ")

#

bands <- s1 %>% dplyr::select(-(Crop_type:Image_dates))

bands.df <- matrix(NA, ncol = 10, nrow = length(bands))
for(i in 1:length(bands)){
  bands.df[i,] <-  as.numeric(unlist(strsplit(bands[[i]], " "))) 
}


bands <- apply(bands, 2, function(x) (as.numeric(unlist(strsplit(x, " ")))))
str(bands)
bands <- data.frame(do.call(rbind, bands))
names(bands) <- c("band2","band3","band4","band5","band6","band7","band8","band8a","band11","band12")

bands <- bands[complete.cases(bands), ] # uklanjamo NA-ove
row.names(bands) <- unlist(strsplit(s1$Image_dates, " "))
bands <- bands %>% tibble::rownames_to_column(var = "Image_dates")
bands$Image_dates <- ymd(bands$Image_dates)

str(bands)

?do.call


str(temp)

# NDVI = (band8-band4)/(band8+band4),
# CI_Green = (band8/band3)-1,
# Green_WDRVI = (0.1*band8-band3)/(0.1*band8+band3)+(1-0.1)/(1+0.1),
# CI_RedE_WDRVI = (0.1*band7-band5)/(0.1*band7+band5)+(1-0.1)/(1+0.1),
# CI_RedEdge1  = (band8/band5)-1,
# NDI = (band5-band4)/(band5+band4),
# EVI2 = 2.5*(band8-band3)/(band8+2.4*band3+1),
# SR = band8/band4

#' 