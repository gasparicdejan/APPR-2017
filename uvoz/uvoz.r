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



# PODATKI V OBLIKI csv :
# Uvoz države ZDA iz drugih držav sveta:

tabela_uvoz_vseh_produktov <- read.csv2("podatki/import_all_product.csv", skip=1, na.strings = ";", 
                                        stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                        col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                      "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_vseh_produktov <- melt(tabela_uvoz_vseh_produktov[,c(2,6:15)], variable.name = "Leto",
                                   value.name = "Vsi produkti", na.rm = FALSE)
tabela_uvoz_vseh_produktov$Leto <- tabela_uvoz_vseh_produktov$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_vseh_produktov$Leto <- tabela_uvoz_vseh_produktov$Leto %>% as.numeric()



tabela_uvoz_zivali <- read.csv2("podatki/import_animal.csv", skip=1, na.strings = ";", 
                                stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                              "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_zivali <- melt(tabela_uvoz_zivali[,c(2,6:15)], variable.name = "Leto",
                           value.name = "Živali", na.rm = FALSE)
tabela_uvoz_zivali$Leto <- tabela_uvoz_zivali$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_zivali$Leto <- tabela_uvoz_zivali$Leto %>% as.numeric()



tabela_uvoz_zelenjave <- read.csv2("podatki/import_vegetable.csv", skip=1, na.strings = ";", 
                                   stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                   col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                 "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_zelenjave <- melt(tabela_uvoz_zelenjave[,c(2,6:15)], variable.name = "Leto",
                              value.name = "Zelenjava", na.rm = FALSE)
tabela_uvoz_zelenjave$Leto <- tabela_uvoz_zelenjave$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_zelenjave$Leto <- tabela_uvoz_zelenjave$Leto %>% as.numeric()



tabela_uvoz_goriva <- read.csv2("podatki/import_fuels.csv", skip=1, na.strings = ";", 
                                stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                              "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_goriva <- melt(tabela_uvoz_goriva[,c(2,6:15)], variable.name = "Leto",
                           value.name = "Gorivo", na.rm = FALSE)
tabela_uvoz_goriva$Leto <- tabela_uvoz_goriva$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_goriva$Leto <- tabela_uvoz_goriva$Leto %>% as.numeric()



tabela_uvoz_plastike_in_gume <- read.csv2("podatki/import_plastic_or_rubber.csv", skip=1, na.strings = ";", 
                                          stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                          col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                        "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_plastike_in_gume <- melt(tabela_uvoz_plastike_in_gume[,c(2,6:15)], variable.name = "Leto",
                                     value.name = "Platika in guma", na.rm = FALSE)
tabela_uvoz_plastike_in_gume$Leto <- tabela_uvoz_plastike_in_gume$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_plastike_in_gume$Leto <- tabela_uvoz_plastike_in_gume$Leto %>% as.numeric()



tabela_uvoz_lesa <- read.csv2("podatki/import_wood.csv", skip=1, na.strings = ";", 
                              stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                              col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                            "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_lesa <- melt(tabela_uvoz_lesa[,c(2,6:15)], variable.name = "Leto",
                         value.name = "Les", na.rm = FALSE)
tabela_uvoz_lesa$Leto <- tabela_uvoz_lesa$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_lesa$Leto <- tabela_uvoz_lesa$Leto %>% as.numeric()



#SESTAVA SKUPNE TABELE 'tabela_uvoz':

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


# Urejanje in čiščenje podatkov v tabeli 'tabela_uvoz':
for (i in 1:length(tabela_uvoz$Zelenjava)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$Zelenjava[i]))&(i%%10 == 0)){
      tabela_uvoz$Zelenjava[(i-9): i] <- c(rep(NA,10))
      }
    else if ((is.na(tabela_uvoz$Zelenjava[i]))&(i%%10 == k)){
      tabela_uvoz$Zelenjava[(i-k+1): (i+10-k)] <- c(rep(NA,10))
      }
  }
}

for (i in 1:length(tabela_uvoz$`Vsi produkti`)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$`Vsi produkti`[i]))&(i%%10 == 0)){
      tabela_uvoz$`Vsi produkti`[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_uvoz$`Vsi produkti`[i]))&(i%%10 == k)){
      tabela_uvoz$`Vsi produkti`[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_uvoz$Živali)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$Živali[i]))&(i%%10 == 0)){
      tabela_uvoz$Živali[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_uvoz$Živali[i]))&(i%%10 == k)){
      tabela_uvoz$Živali[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_uvoz$Gorivo)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$Gorivo[i]))&(i%%10 == 0)){
      tabela_uvoz$Gorivo[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_uvoz$Gorivo[i]))&(i%%10 == k)){
      tabela_uvoz$Gorivo[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_uvoz$`Platika in guma`)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$`Platika in guma`[i]))&(i%%10 == 0)){
      tabela_uvoz$`Platika in guma`[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_uvoz$`Platika in guma`[i]))&(i%%10 == k)){
      tabela_uvoz$`Platika in guma`[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_uvoz$Les)) {
  for (k in 1:9) {
    if ((is.na(tabela_uvoz$Les[i]))&(i%%10 == 0)){
      tabela_uvoz$Les[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_uvoz$Les[i]))&(i%%10 == k)){
      tabela_uvoz$Les[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}






# Izvoz ZDA:

tabela_izvoz_vseh_produktov <- read.csv2("podatki/export_all_product.csv", skip=1, na.strings = ";", 
                                         stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                         col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                       "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_vseh_produktov <- melt(tabela_izvoz_vseh_produktov[,c(2,6:15)], variable.name = "Leto",
                                    value.name = "Vsi produkti", na.rm = FALSE)
tabela_izvoz_vseh_produktov$Leto <- tabela_izvoz_vseh_produktov$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_vseh_produktov$Leto <- tabela_izvoz_vseh_produktov$Leto %>% as.numeric()



tabela_izvoz_zivali <- read.csv2("podatki/export_animal.csv", skip=1, na.strings = ";", 
                                 stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                 col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                               "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_zivali <- melt(tabela_izvoz_zivali[,c(2,6:15)], variable.name = "Leto",
                            value.name = "Živali", na.rm = FALSE)
tabela_izvoz_zivali$Leto <- tabela_izvoz_zivali$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_zivali$Leto <- tabela_izvoz_zivali$Leto %>% as.numeric()



tabela_izvoz_zelenjave <- read.csv2("podatki/export_vegetable.csv", skip=1, na.strings = ";", 
                                    stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                    col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                  "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_zelenjave <- melt(tabela_izvoz_zelenjave[,c(2,6:15)], variable.name = "Leto",
                               value.name = "Zelenjava", na.rm = FALSE)
tabela_izvoz_zelenjave$Leto <- tabela_izvoz_zelenjave$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_zelenjave$Leto <- tabela_izvoz_zelenjave$Leto %>% as.numeric()



tabela_izvoz_goriva <- read.csv2("podatki/export_fuels.csv", skip=1, na.strings = ";", 
                                 stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                 col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                               "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_goriva <- melt(tabela_izvoz_goriva[,c(2,6:15)], variable.name = "Leto",
                            value.name = "Gorivo", na.rm = FALSE)
tabela_izvoz_goriva$Leto <- tabela_izvoz_goriva$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_goriva$Leto <- tabela_izvoz_goriva$Leto %>% as.numeric()



tabela_izvoz_plastike_in_gume <- read.csv2("podatki/export_plastic_or_rubber.csv", skip=1, na.strings = ";", 
                                           stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                           col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                         "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_plastike_in_gume <- melt(tabela_izvoz_plastike_in_gume[,c(2,6:15)], variable.name = "Leto",
                                      value.name = "Plastika in guma", na.rm = FALSE)
tabela_izvoz_plastike_in_gume$Leto <- tabela_izvoz_plastike_in_gume$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_plastike_in_gume$Leto <- tabela_izvoz_plastike_in_gume$Leto %>% as.numeric()



tabela_izvoz_lesa <- read.csv2("podatki/export_wood.csv", skip=1, na.strings = ";", 
                               stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                               col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                             "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_lesa <- melt(tabela_izvoz_lesa[,c(2,6:15)], variable.name = "Leto",
                          value.name = "Les", na.rm = FALSE)
tabela_izvoz_lesa$Leto <- tabela_izvoz_lesa$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_lesa$Leto <- tabela_izvoz_lesa$Leto %>% as.numeric()



#SESTAVA SKUPNE TABELE 'tabela_izvoz':

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


# Urejanje in čiščenje podatkov v tabeli 'tabela_izvoz':

for (i in 1:length(tabela_izvoz$Zelenjava)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$Zelenjava[i]))&(i%%10 == 0)){
      tabela_izvoz$Zelenjava[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$Zelenjava[i]))&(i%%10 == k)){
      tabela_izvoz$Zelenjava[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_izvoz$`Vsi produkti`)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$`Vsi produkti`[i]))&(i%%10 == 0)){
      tabela_izvoz$`Vsi produkti`[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$`Vsi produkti`[i]))&(i%%10 == k)){
      tabela_izvoz$`Vsi produkti`[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_izvoz$Živali)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$Živali[i]))&(i%%10 == 0)){
      tabela_izvoz$Živali[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$Živali[i]))&(i%%10 == k)){
      tabela_izvoz$Živali[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_izvoz$Gorivo)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$Gorivo[i]))&(i%%10 == 0)){
      tabela_izvoz$Gorivo[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$Gorivo[i]))&(i%%10 == k)){
      tabela_izvoz$Gorivo[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_izvoz$`Plastika in guma`)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$`Plastika in guma`[i]))&(i%%10 == 0)){
      tabela_izvoz$`Plastika in guma`[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$`Plastika in guma`[i]))&(i%%10 == k)){
      tabela_izvoz$`Plastika in guma`[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}

for (i in 1:length(tabela_izvoz$Les)) {
  for (k in 1:9) {
    if ((is.na(tabela_izvoz$Les[i]))&(i%%10 == 0)){
      tabela_izvoz$Les[(i-9): i] <- c(rep(NA,10))
    }
    else if ((is.na(tabela_izvoz$Les[i]))&(i%%10 == k)){
      tabela_izvoz$Les[(i-k+1): (i+10-k)] <- c(rep(NA,10))
    }
  }
}






# PODATKI V OBLIKI xml :

library(rvest)
library(dplyr)
library(gsubfn)

# uvoz tabele držav, za katere je ZDA glavni partner v izvozu 2014 v % :

link1 <- "http://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States"
stran1 <- html_session(link1) %>% read_html()
tabela_partnerstvo_izvoz <- stran1 %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% .[[1]] %>% html_table()
tabela_partnerstvo_izvoz <- tabela_partnerstvo_izvoz %>%
  rename(Država = Region, Procent = Percentage)
tabela_partnerstvo_izvoz$Procent <- tabela_partnerstvo_izvoz$Procent %>%
  strapplyc("([0-9.]+)") %>% as.numeric()
tabela_partnerstvo_izvoz$Država <- tabela_partnerstvo_izvoz$Država %>%
  strapplyc("([a-zA-Z ]+)")



# uvoz tabele držav, za katere je ZDA glavni partner v uvozu 2014 v % :
link2 <- "http://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States"
stran2 <- html_session(link2) %>% read_html()
tabela_partnerstvo_uvoz <- stran2 %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>% .[[2]] %>% html_table()
tabela_partnerstvo_uvoz <- tabela_partnerstvo_uvoz %>%
  rename(Država = Region, Procent = Percentage)
tabela_partnerstvo_uvoz$Procent <- tabela_partnerstvo_uvoz$Procent %>%
  strapplyc("([0-9.]+)") %>% as.numeric()
tabela_partnerstvo_uvoz$Država <- tabela_partnerstvo_uvoz$Država %>%
  strapplyc("([a-zA-Z ]+)")
