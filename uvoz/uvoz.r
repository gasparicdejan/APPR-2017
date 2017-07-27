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
tabela_uvoz_vseh_produktov <- melt(tabela_uvoz_vseh_produktov[,c(2,6:14)], variable.name = "Leto",
                                   value.name = "Vsi produkti", na.rm = TRUE)
tabela_uvoz_vseh_produktov$Leto <- tabela_uvoz_vseh_produktov$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_vseh_produktov$Leto <- tabela_uvoz_vseh_produktov$Leto %>% as.numeric()



tabela_uvoz_zivali <- read.csv2("podatki/import_animal.csv", skip=1, na.strings = ";", 
                                stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                              "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_zivali <- melt(tabela_uvoz_zivali[,c(2,6:14)], variable.name = "Leto",
                           value.name = "Živali", na.rm = TRUE)
tabela_uvoz_zivali$Leto <- tabela_uvoz_zivali$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_zivali$Leto <- tabela_uvoz_zivali$Leto %>% as.numeric()



tabela_uvoz_zelenjave <- read.csv2("podatki/import_vegetable.csv", skip=1, na.strings = ";", 
                                   stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                   col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                 "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_zelenjave <- melt(tabela_uvoz_zelenjave[,c(2,6:14)], variable.name = "Leto",
                              value.name = "Zelenjava", na.rm = TRUE)
tabela_uvoz_zelenjave$Leto <- tabela_uvoz_zelenjave$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_zelenjave$Leto <- tabela_uvoz_zelenjave$Leto %>% as.numeric()



tabela_uvoz_goriva <- read.csv2("podatki/import_fuels.csv", skip=1, na.strings = ";", 
                                stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                              "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_goriva <- melt(tabela_uvoz_goriva[,c(2,6:14)], variable.name = "Leto",
                           value.name = "Gorivo", na.rm = TRUE)
tabela_uvoz_goriva$Leto <- tabela_uvoz_goriva$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_goriva$Leto <- tabela_uvoz_goriva$Leto %>% as.numeric()



tabela_uvoz_plastike_in_gume <- read.csv2("podatki/import_plastic_or_rubber.csv", skip=1, na.strings = ";", 
                                          stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                          col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                        "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_plastike_in_gume <- melt(tabela_uvoz_plastike_in_gume[,c(2,6:14)], variable.name = "Leto",
                                     value.name = "Platika in guma", na.rm = TRUE)
tabela_uvoz_plastike_in_gume$Leto <- tabela_uvoz_plastike_in_gume$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_plastike_in_gume$Leto <- tabela_uvoz_plastike_in_gume$Leto %>% as.numeric()



tabela_uvoz_lesa <- read.csv2("podatki/import_wood.csv", skip=1, na.strings = ";", 
                              stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                              col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                            "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_uvoz_lesa <- melt(tabela_uvoz_lesa[,c(2,6:14)], variable.name = "Leto",
                         value.name = "Les", na.rm = TRUE)
tabela_uvoz_lesa$Leto <- tabela_uvoz_lesa$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_uvoz_lesa$Leto <- tabela_uvoz_lesa$Leto %>% as.numeric()





# Izvoz ZDA:

tabela_izvoz_vseh_produktov <- read.csv2("podatki/export_all_product.csv", skip=1, na.strings = ";", 
                                         stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                         col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                       "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_vseh_produktov <- melt(tabela_izvoz_vseh_produktov[,c(2,6:14)], variable.name = "Leto",
                                    value.name = "Vsi produkti", na.rm = TRUE)
tabela_izvoz_vseh_produktov$Leto <- tabela_izvoz_vseh_produktov$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_vseh_produktov$Leto <- tabela_izvoz_vseh_produktov$Leto %>% as.numeric()



tabela_izvoz_zivali <- read.csv2("podatki/export_animal.csv", skip=1, na.strings = ";", 
                                 stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                 col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                               "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_zivali <- melt(tabela_izvoz_zivali[,c(2,6:14)], variable.name = "Leto",
                            value.name = "Živali", na.rm = TRUE)
tabela_izvoz_zivali$Leto <- tabela_izvoz_zivali$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_zivali$Leto <- tabela_izvoz_zivali$Leto %>% as.numeric()



tabela_izvoz_zelenjave <- read.csv2("podatki/export_vegetable.csv", skip=1, na.strings = ";", 
                                    stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                    col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                  "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_zelenjave <- melt(tabela_izvoz_zelenjave[,c(2,6:14)], variable.name = "Leto",
                               value.name = "Zelenjava", na.rm = TRUE)
tabela_izvoz_zelenjave$Leto <- tabela_izvoz_zelenjave$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_zelenjave$Leto <- tabela_izvoz_zelenjave$Leto %>% as.numeric()



tabela_izvoz_goriva <- read.csv2("podatki/export_fuels.csv", skip=1, na.strings = ";", 
                                 stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                 col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                               "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_goriva <- melt(tabela_izvoz_goriva[,c(2,6:14)], variable.name = "Leto",
                            value.name = "Gorivo", na.rm = TRUE)
tabela_izvoz_goriva$Leto <- tabela_izvoz_goriva$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_goriva$Leto <- tabela_izvoz_goriva$Leto %>% as.numeric()



tabela_izvoz_plastike_in_gume <- read.csv2("podatki/export_plastic_and_rubber.csv", skip=1, na.strings = ";", 
                                           stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                                           col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                                         "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_plastike_in_gume <- melt(tabela_izvoz_plastike_in_gume[,c(2,6:14)], variable.name = "Leto",
                                      value.name = "Plastika in guma", na.rm = TRUE)
tabela_izvoz_plastike_in_gume$Leto <- tabela_izvoz_plastike_in_gume$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_plastike_in_gume$Leto <- tabela_izvoz_plastike_in_gume$Leto %>% as.numeric()



tabela_izvoz_lesa <- read.csv2("podatki/export_wood.csv", skip=1, na.strings = ";", 
                               stringsAsFactors = FALSE, fileEncoding = "Windows-1250", 
                               col.names = c("ZDA", "Partner", "Vrsta trgovanja", "Produkti", "Indikator","2006", "2007", 
                                             "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015"))
tabela_izvoz_lesa <- melt(tabela_izvoz_lesa[,c(2,6:14)], variable.name = "Leto",
                          value.name = "Les", na.rm = TRUE)
tabela_izvoz_lesa$Leto <- tabela_izvoz_lesa$Leto %>% as.character() %>%
  strapplyc("([0-9]+)")
tabela_izvoz_lesa$Leto <- tabela_izvoz_lesa$Leto %>% as.numeric()








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














# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi občine iz Wikipedije
uvozi.obcine <- function() {
  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in colnames(tabela)) {
    tabela[tabela[[col]] == "-", col] <- NA
  }
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    if (is.numeric(tabela[[col]])) {
      next()
    }
    tabela[[col]] <- gsub("[.*]", "", tabela[[col]]) %>% as.numeric()
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function(obcine) {
  data <- read_csv2("podatki/druzine.csv", col_names = c("obcina", 1:4),
                    locale = locale(encoding = "Windows-1250"))
  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
                        value.name = "stevilo.druzin")
  data$velikost.druzine <- as.numeric(data$velikost.druzine)
  data$obcina <- factor(data$obcina, levels = obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
