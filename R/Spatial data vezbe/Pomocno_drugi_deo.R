library(sp)
library(raster)
library(sf)


cities <- st_read(system.file("vectors/cities.shp", package = "rgdal"))

cities

mapview::mapview(cities)

cities <- cbind(st_drop_geometry(cities), st_coordinates(cities))

head(cities, 10)

sf::sf_extSoftVersion()

# SF package 
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Defining a CRS with sf
crs_wgs84 <- st_crs(4326) # WGS84 has EPSG code 4326
class(crs_wgs84)

crs_wgs84 # printing the crs object shows us both the EPSG code (more generally: the user’s CRS specification) and the WKT2 string

cat(crs_wgs84$wkt) # You can directly acces the wkt element of the crs object
crs_wgs84$epsg
crs_wgs84$proj4string # You can (but should you?) export a (stripped) proj4string as well

# Set the CRS of an sf object
cities2 <- st_as_sf(cities, coords = c("X", "Y"))
cities2 # CRS: NA

st_crs(cities2) <- 4326 # Let’s add the CRS by using the EPSG code (we could also assign crs_wgs84 instead)
st_crs(cities2) <- crs_wgs84

# Get the CRS of an sf object
st_crs(cities2)
## As this returns the crs object, you can also use st_crs(cities2)$wkt to specifically return the WKT2 string!
st_crs(cities2)$wkt


# SP package 
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# Defining a CRS with sp
crs_wgs84 <- CRS(SRS_string = "EPSG:4326") # WGS84 has EPSG code 4326
class(crs_wgs84)

wkt_wgs84 <- wkt(crs_wgs84)
cat(wkt_wgs84)

# Set the CRS of a Spatial* object in sp
cities2 <- cities
coordinates(cities2) <-  ~ X + Y
proj4string(cities2) <- crs_wgs84

str(cities2)

# Get the CRS of a Spatial* object in sp
cat(wkt(cities2))


# Conversion sp <--> sf
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

cities_sf <- st_as_sf(cities2)
cities_sf
cities_sp <- as(cities_sf, "Spatial")
cities_sp

# RASTER package 
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
library(raster)

# Kreiranje rastera sa slucajnim vrednostima celija - piksela

extent(7440500, 7475000, 4948000, 4976500) # xmin, xmax, ymin, ymax
podrucje_beograda <- raster(extent(7440500, 7475000, 4948000, 4976500), res = 100)
# Funkcija rnorm - vektor slucajnih brojeva sa normalnom raspodelom
values(podrucje_beograda) <- rnorm(ncell(podrucje_beograda)) 

podrucje_beograda
plot(podrucje_beograda)

# Dodeljivanje definicije referentnog koordinatnog sistema

podrucje_beograda1 <- podrucje_beograda
podrucje_beograda2 <- podrucje_beograda
podrucje_beograda3 <- podrucje_beograda
podrucje_beograda4 <- podrucje_beograda

# Dodeljivanje CRS-a se vrsi putem funkcije <- crs(), na vise nacina koji daju isti rezultat

crs(podrucje_beograda1) <- 3909
crs(podrucje_beograda2) <- "EPSG:3909"
crs(podrucje_beograda3) <- st_crs(3909)$wkt # a WKT string
crs(podrucje_beograda4) <- CRS(SRS_string = "EPSG:3909") # an sp CRS object


cat(wkt(podrucje_beograda1))

all.equal(wkt(podrucje_beograda1),
          wkt(podrucje_beograda2),
          wkt(podrucje_beograda3),
          wkt(podrucje_beograda4))


podrucje_beograda1
mapview::mapview(podrucje_beograda1)










