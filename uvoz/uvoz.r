# 2. faza: Uvoz podatkov

library(knitr)
library(ggplot2)
library(dplyr)
require(gsubfn)
require(rvest)
require(xml2)
require(ggplot2)
library(sp)
library(maptools)
library(reshape2)



############################### PODATKI V OBLIKI CSV: ###############################

## Uvoz ZDA iz drugih držav sveta:

# Funkcija "uvozi.tabelo" na podlagi naslova (mesta, kjer imamo uvozeno tabelo in 
# njejega naslova) in kategorije izdelkov in storitev vrne tabelo, ki ima 3 stolpce 
# (Partnerska država, Leto, Kategorija) in vsebuje za 10 letno obdobje (2006-2015) 
# podatke o uvozu ZDA po posameznih kategorijah in državah.

uvozi.tabelo <- function(naslov, products){
  tabela <- read.csv2(naslov, skip=1, na.strings = ";", 
                      stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                      col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                    "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
  tabela <- melt(tabela[,c(2,6:15)], variable.name = "Leto",
                                     value.name = products, na.rm = FALSE)
  tabela$Leto <- tabela$Leto %>% as.character() %>%
    strapplyc("([0-9]+)")
  tabela$Leto <- tabela$Leto %>% as.numeric()
  return(tabela)
}

tabela_uvoz_vseh_produktov <- uvozi.tabelo("podatki/import_all_product.csv", "Vsi_produkti")
tabela_uvoz_zivali <- uvozi.tabelo("podatki/import_animal.csv", "Zivali")
tabela_uvoz_zelenjave <- uvozi.tabelo("podatki/import_vegetable.csv", "Zelenjava")
tabela_uvoz_goriva <- uvozi.tabelo("podatki/import_fuels.csv", "Gorivo")
tabela_uvoz_plastike_in_gume <- uvozi.tabelo("podatki/import_plastic_or_rubber.csv", "Plastika_in_guma")
tabela_uvoz_lesa <- uvozi.tabelo("podatki/import_wood.csv", "Les")



# SESTAVA SKUPNE TABELE "tabela_uvoz":

tabela_uvoz <- merge(tabela_uvoz_vseh_produktov, tabela_uvoz_zivali, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_uvoz <- merge(tabela_uvoz, tabela_uvoz_zelenjave, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_uvoz <- merge(tabela_uvoz, tabela_uvoz_goriva, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_uvoz <- merge(tabela_uvoz, tabela_uvoz_plastike_in_gume, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_uvoz <- merge(tabela_uvoz, tabela_uvoz_lesa, 
                     by = c("Partner", "Leto"), all.x = TRUE)


# Urejanje in čiščenje podatkov v tabeli "tabela_uvoz":

# Funkcija "ciscenje" vzame določen stolpec v tabeli in ga precisci tako, da ce za katero
# leto ni podatkov (imamo vrednost NA) funkcija za tisto drzavo v doloceni vrstici 
# (kategoriji) za vsa leta vrne NA. Namen funkcije je, da ce nimamo podatkov za drzavo v 
# dolocenem letu (izmed 10let) v doloceni kategoriji potem jih ne rabimo za nobeno leto, 
# saj ne moremo spremljati spremembe skozi leta.

ciscenje <- function(kategorija){
  for (i in 1:length(kategorija)) {
    for (k in 1:9) {
      if ((is.na(kategorija[i]))&(i%%10 == 0)){
        kategorija[(i-9): i] <- c(rep(NA,10))
      }
      else if ((is.na(kategorija[i]))&(i%%10 == k)){
        kategorija[(i-k+1): (i+10-k)] <- c(rep(NA,10))
      }
    }
  }
  return(kategorija)
}

tabela_uvoz$Zelenjava <- ciscenje(tabela_uvoz$Zelenjava)
tabela_uvoz$Vsi_produkti <- ciscenje(tabela_uvoz$Vsi_produkti)
tabela_uvoz$Zivali <- ciscenje(tabela_uvoz$Zivali)
tabela_uvoz$Gorivo <-ciscenje(tabela_uvoz$Gorivo)
tabela_uvoz$Plastika_in_guma<- ciscenje(tabela_uvoz$Plastika_in_guma)
tabela_uvoz$Les <- ciscenje(tabela_uvoz$Les)





## Izvoz ZDA v druge države sveta:

# Funkcija "uvozi.tabelo1" na podlagi naslova (mesta, kjer imamo uvozeno tabelo in 
# njejega naslova) in kategorije izdelkov in storitev vrne tabelo, ki ima 3 stolpce 
# (Partnerska država, Leto, Kategorija) in vsebuje za 10 letno obdobje (2006-2015) 
# podatke o izvozu ZDA po posameznih kategorijah in državah.

uvozi.tabelo1 <- function(naslov, products){
  tabela <- read.csv2(naslov, skip=1, na.strings = ";", 
                      stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                      col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                    "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
  tabela <- melt(tabela[,c(2,6:15)], variable.name = "Leto",
                 value.name = products, na.rm = FALSE)
  tabela$Leto <- tabela$Leto %>% as.character() %>%
    strapplyc("([0-9]+)")
  tabela$Leto <- tabela$Leto %>% as.numeric()
  return(tabela)
}

tabela_izvoz_vseh_produktov <- uvozi.tabelo1("podatki/export_all_product.csv", "Vsi_produkti")
tabela_izvoz_zivali <- uvozi.tabelo1("podatki/export_animal.csv", "Zivali")
tabela_izvoz_zelenjave <- uvozi.tabelo1("podatki/export_vegetable.csv", "Zelenjava")
tabela_izvoz_goriva <- uvozi.tabelo1("podatki/export_fuels.csv", "Gorivo")
tabela_izvoz_plastike_in_gume <- uvozi.tabelo1("podatki/export_plastic_or_rubber.csv", "Plastika_in_guma")
tabela_izvoz_lesa <- uvozi.tabelo1("podatki/export_wood.csv", "Les")



#SESTAVA SKUPNE TABELE "tabela_izvoz":

tabela_izvoz <- merge(tabela_izvoz_vseh_produktov, tabela_izvoz_zivali, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_izvoz <- merge(tabela_izvoz, tabela_izvoz_zelenjave, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_izvoz <- merge(tabela_izvoz, tabela_izvoz_goriva, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_izvoz <- merge(tabela_izvoz, tabela_izvoz_plastike_in_gume, 
                     by = c("Partner", "Leto"), all.x = TRUE)
tabela_izvoz <- merge(tabela_izvoz, tabela_izvoz_lesa, 
                     by = c("Partner", "Leto"), all.x = TRUE)


# Urejanje in čiščenje podatkov v tabeli "tabela_izvoz":

# Uporabimo zgoraj napisano funkcijo "ciscenje":
tabela_izvoz$Zelenjava <- ciscenje(tabela_izvoz$Zelenjava)
tabela_izvoz$Vsi_produkti <- ciscenje(tabela_izvoz$Vsi_produkti)
tabela_izvoz$Zivali <- ciscenje(tabela_izvoz$Zivali)
tabela_izvoz$Gorivo <- ciscenje(tabela_izvoz$Gorivo)
tabela_izvoz$Plastika_in_guma <- ciscenje(tabela_izvoz$Plastika_in_guma)
tabela_izvoz$Les <- ciscenje(tabela_izvoz$Les)





############################### PODATKI V OBLIKI HTML: ###############################

library(rvest)
library(dplyr)
library(gsubfn)

## Izvoz ZDA v druge države sveta:

# Uvoz tabele držav, za katere je ZDA glavni partner v izvozu za leto 2014 v % :

link1 <- "http://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States"
stran1 <- html_session(link1) %>% read_html()
tabela_partnerstvo_izvoz <- stran1 %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% .[[1]] %>% html_table()
tabela_partnerstvo_izvoz <- tabela_partnerstvo_izvoz %>%
  rename(Država = Region, Procent = Percentage)
tabela_partnerstvo_izvoz$Procent <- tabela_partnerstvo_izvoz$Procent %>%
  strapplyc("([0-9.]+)") %>% as.numeric()
tabela_partnerstvo_izvoz$Država <- tabela_partnerstvo_izvoz$Država %>%
  strapplyc("([a-zA-Z ]+)")



## Izvoz ZDA iz drugih držav sveta:

# Uvoz tabele držav, za katere je ZDA glavni partner v uvozu za leto 2014 v % :

link2 <- "http://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States"
stran2 <- html_session(link2) %>% read_html()
tabela_partnerstvo_uvoz <- stran2 %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% .[[2]] %>% html_table()
tabela_partnerstvo_uvoz <- tabela_partnerstvo_uvoz %>%
  rename(Država = Region, Procent = Percentage)
tabela_partnerstvo_uvoz$Procent <- tabela_partnerstvo_uvoz$Procent %>%
  strapplyc("([0-9.]+)") %>% as.numeric()
tabela_partnerstvo_uvoz$Država <- tabela_partnerstvo_uvoz$Država %>%
  strapplyc("([a-zA-Z ]+)")
