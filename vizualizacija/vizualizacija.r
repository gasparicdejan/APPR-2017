# 3. faza: Vizualizacija podatkov

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


################################# GRAFI: #################################

## GRAF UVOZA ZDA IZ PARTNERSKIH DRŽAV PO LETIH:

# Funkcija "narisi.graf" narise graf uvoza ZDA v letu, ki ga podamo v spremenljivki 
#"leto". Spremenljivka "stev" pa pove koliko drzav hocemo imeti prikazanih (torej 
# stevilo najvecjih uvoznic v ZDA, vrstni red je določen glede na kategorijo 
# vseh produktov, torej celotnega uvoza).

narisi.graf <- function(leto, stev){
  Partnerji <- (tabela_uvoz %>% filter(Leto == leto) %>% 
                  arrange(desc(Vsi_produkti)) %>% head(stev))[(1:stev),1]
  narisi <- ggplot(tabela_uvoz %>% filter(Leto == leto) %>%
                     arrange(desc(Vsi_produkti)) %>% head(stev))+ 
    aes(x= Partnerji , y= Vsi_produkti)+
    geom_bar(stat = "identity", fill = "red")+
    ggtitle(paste(stev,"drzav, iz katerih je ZDA najvec uvazala v letu",leto))+
    theme(plot.title = element_text(lineheight=.8, face="bold"))
  return(narisi)
}

graf1 <- narisi.graf(2015,10)



## GRAF IZVOZA ZDA V PARTNERSKE DRŽAVE PO LETIH:

# Funkcija "narisi.graf1" narise graf izvoza ZDA v letu, ki ga podamo v spremenljivki 
#"leto". Spremenljivka "stev" pa pove koliko drzav hocemo imeti prikazanih (torej 
# stevilo najvecjih izvoznic iz ZDA, vrstni red je določen glede na kategorijo 
# vseh produktov, torej celotnega izvoza).

narisi.graf1 <- function(leto, stev){
  Partnerji <- (tabela_izvoz %>% filter(Leto == leto) %>% 
                  arrange(desc(Vsi_produkti)) %>% head(stev))[(1:stev),1]
  narisi <- ggplot(tabela_izvoz %>% filter(Leto == leto) %>%
                     arrange(desc(Vsi_produkti)) %>% head(stev))+ 
    aes(x= Partnerji , y= Vsi_produkti)+
    geom_bar(stat = "identity", fill = "green")+
    ggtitle(paste(stev,"drzav, v katere je ZDA najvec izvazala v letu",leto))+
    theme(plot.title = element_text(lineheight=.8, face="bold"))
  return(narisi)
}

graf2 <- narisi.graf1(2015,10)






############################## ZEMLJEVIDI: ##############################

# Uvozimo zemljevid in ga pretvorimo:
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                        "ne_50m_admin_0_countries", encoding = "Windows-1252")
sv1 <- pretvori.zemljevid(svet)


# Zemljevid v pretvorjeni obliki ima za določene države druga imena, kot so v podatkih, zato
# za vsako državo, ki ima drugo ime prilagodimo tako, da se imeni ujemata.

sv1$name_long <- as.character(sv1$name_long)
sv1$name_long[sv1$name_long == "Anguilla"] <- "Anguila"
sv1$name_long[sv1$name_long == "Bahamas"] <- "Bahamas, The"
sv1$name_long[sv1$name_long == "Republic of COngo"] <- "Congo, Rep."
sv1$name_long[sv1$name_long == "Democratic Republic of the Congo"] <- "Congo, Dem. Rep."
sv1$name_long[sv1$name_long == "Ethiopia"] <- "Ethiopia(excludes Eritrea)"
sv1$name_long[sv1$name_long == "Egypt"] <- "Egypt, Arab Rep."
sv1$name_long[sv1$name_long == "Falkland Islands"] <- "Falkland Island"
sv1$name_long[sv1$name_long == "The Gambia"] <- "Gambia, The"
sv1$name_long[sv1$name_long == "Hong Kong"] <- "Hong Kong, China"
sv1$name_long[sv1$name_long == "Heard I. and McDonald Islands"] <- "Heard Island and McDonald Isla"
sv1$name_long[sv1$name_long == "Iran"] <- "Iran, Islamic Rep."
sv1$name_long[sv1$name_long == "Republic of Korea"] <- "Korea, Rep."
sv1$name_long[sv1$name_long == "Kyrgyzstan"] <- "Kyrgyz Republic"
sv1$name_long[sv1$name_long == "Macedonia"] <- "Macedonia, FYR"
sv1$name_long[sv1$name_long == "Netherlands"] <- "Netherlands Antilles"
sv1$name_long[sv1$name_long == "Pitcairn Islands"] <- "Pitcairn"
sv1$name_long[sv1$name_long == "Saint Maarten"] <- "Saint Maarten (Dutch part)"
sv1$name_long[sv1$name_long == "Sao Tomé and Principe"] <- "Sao Tome and Principe"
sv1$name_long[sv1$name_long == "Serbia"] <- "Serbia, FR(Serbia/Montenegro)"
sv1$name_long[sv1$name_long == "Turks and Caicos Islands"] <- "Turks and Caicos Isl."
sv1$name_long[sv1$name_long == "Wallis and Futura Islands"] <- "Wallis and Futura Isl."
sv1$name_long[sv1$name_long == "French Southern and Antarctic Lands"] <- "Fr. So. Ant. Tr"
sv1$name_long[sv1$name_long == "Brunei Durassalam"] <- "Brunei"
sv1$name_long[sv1$name_long == "British Indian Ocean Territory"] <- "British Indian Ocean Ter."
sv1$name_long[sv1$name_long == "Saint Kitts and Nevis"] <- "St. Kitts and Nevis"
sv1$name_long[sv1$name_long == "Dem.Rep.Korea"] <- "Korea, Dem. Rep."
sv1$name_long[sv1$name_long == "Saint Lucia"] <- "St. Lucia"
sv1$name_long[sv1$name_long == "Côte d'Ivoire"] <- "Cote d'Ivoire"
sv1$name_long[sv1$name_long == "American Samoa"] <- "Samoa"
sv1$name_long[sv1$name_long == "Slovakia"] <- "Slovak Republic"
sv1$name_long[sv1$name_long == "Syria"] <- "Syrian Arab Republic"
sv1$name_long[sv1$name_long == "South Sudan"] <- "Fm Sudan"
sv1$name_long[sv1$name_long == "Timor-Leste"] <- "East Timor"
sv1$name_long[sv1$name_long == "Federated States of Micronesia"] <- "Micronesia, Fed. Sts."
sv1$name_long[sv1$name_long == "Cook Islands"] <- "Cocos (Keeling) Islands"
sv1$name_long[sv1$name_long == "Saint Vincent and the Grenadines"] <- "St. Vincent and the Grenadines"



# Tabela "Izvoz" bo predstavljalo tabelo podatkov za leto 2015. 
Izvoz <- filter(tabela_izvoz, Leto == 2015)
Izvoz$Partner <- factor(Izvoz$Partner)

# Nastavimo tako, da se v tabeli sv1, stolpec name_long ujema z stolpcem Partner v tabeli Izvoz:
sv1$name_long <- factor(sv1$name_long, levels = levels(Izvoz$Partner))

# NArišemo zemljevid za izvoz ZDA:
zem1 <- ggplot() +
  geom_polygon(data = Izvoz %>%
                 right_join(sv1, by = c("Partner" = "name_long")),
               aes(x=long, y=lat, group = group, fill = Vsi_produkti),
               color = "grey") + ggtitle("Celotni izvoz ZDA v države po svetu v letu 2015")+
  scale_fill_gradient(low = "Ghostwhite", high = "green", guide = "colourbar") + xlab("")+
  ylab("")

print(zem1)



# Zemljevid pretvorimo in ker ima v pretvorjeni obliki za določene države druga imena, kot so 
# v podatkih, za vsako državo, ki ima drugo ime prilagodimo tako, da se imeni ujemata.

sv2 <- pretvori.zemljevid(svet)

sv2$name_long <- as.character(sv1$name_long)
sv2$name_long[sv2$name_long == "Anguilla"] <- "Anguila"
sv2$name_long[sv2$name_long == "Bahamas"] <- "Bahamas, The"
sv2$name_long[sv2$name_long == "Republic of COngo"] <- "Congo, Rep."
sv2$name_long[sv2$name_long == "Democratic Republic of the Congo"] <- "Congo, Dem. Rep."
sv2$name_long[sv2$name_long == "Ethiopia"] <- "Ethiopia(excludes Eritrea)"
sv2$name_long[sv2$name_long == "Egypt"] <- "Egypt, Arab Rep."
sv2$name_long[sv2$name_long == "Falkland Islands"] <- "Falkland Island"
sv2$name_long[sv2$name_long == "The Gambia"] <- "Gambia, The"
sv2$name_long[sv2$name_long == "Hong Kong"] <- "Hong Kong, China"
sv2$name_long[sv2$name_long == "Heard I. and McDonald Islands"] <- "Heard Island and McDonald Isla"
sv2$name_long[sv2$name_long == "Iran"] <- "Iran, Islamic Rep."
sv2$name_long[sv2$name_long == "Republic of Korea"] <- "Korea, Rep."
sv2$name_long[sv2$name_long == "Kyrgyzstan"] <- "Kyrgyz Republic"
sv2$name_long[sv2$name_long == "Macedonia"] <- "Macedonia, FYR"
sv2$name_long[sv2$name_long == "Netherlands"] <- "Netherlands Antilles"
sv2$name_long[sv2$name_long == "Pitcairn Islands"] <- "Pitcairn"
sv2$name_long[sv2$name_long == "Saint Maarten"] <- "Saint Maarten (Dutch part)"
sv2$name_long[sv2$name_long == "Sao Tomé and Principe"] <- "Sao Tome and Principe"
sv2$name_long[sv2$name_long == "Serbia"] <- "Serbia, FR(Serbia/Montenegro)"
sv2$name_long[sv2$name_long == "Turks and Caicos Islands"] <- "Turks and Caicos Isl."
sv2$name_long[sv2$name_long == "Wallis and Futura Islands"] <- "Wallis and Futura Isl."
sv2$name_long[sv2$name_long == "French Southern and Antarctic Lands"] <- "Fr. So. Ant. Tr"
sv2$name_long[sv2$name_long == "Brunei Durassalam"] <- "Brunei"
sv2$name_long[sv2$name_long == "British Indian Ocean Territory"] <- "British Indian Ocean Ter."
sv2$name_long[sv2$name_long == "Saint Kitts and Nevis"] <- "St. Kitts and Nevis"
sv2$name_long[sv2$name_long == "Dem.Rep.Korea"] <- "Korea, Dem. Rep."
sv2$name_long[sv2$name_long == "Saint Lucia"] <- "St. Lucia"
sv2$name_long[sv2$name_long == "Côte d'Ivoire"] <- "Cote d'Ivoire"
sv2$name_long[sv2$name_long == "American Samoa"] <- "Samoa"
sv2$name_long[sv2$name_long == "Slovakia"] <- "Slovak Republic"
sv2$name_long[sv2$name_long == "Syria"] <- "Syrian Arab Republic"
sv2$name_long[sv2$name_long == "South Sudan"] <- "Fm Sudan"
sv2$name_long[sv2$name_long == "Timor-Leste"] <- "East Timor"
sv2$name_long[sv2$name_long == "Federated States of Micronesia"] <- "Micronesia, Fed. Sts."
sv2$name_long[sv2$name_long == "Cook Islands"] <- "Cocos (Keeling) Islands"
sv2$name_long[sv2$name_long == "Saint Vincent and the Grenadines"] <- "St. Vincent and the Grenadines"


# Tabela "Uvoz" bo predstavljalo tabelo podatkov za leto 2015. 
Uvoz <- filter(tabela_uvoz, Leto == 2015)
Uvoz$Partner <- factor(Uvoz$Partner)

# Nastavimo tako, da se v tabeli sv1, stolpec name_long ujema z stolpcem Partner v tabeli Izvoz:
sv2$name_long<- factor(sv2$name_long, levels = levels(Uvoz$Partner))

# NArišemo zemljevid za uvoz ZDA:
zem2 <- ggplot() +
  geom_polygon(data = Uvoz %>%
                 right_join(sv2, by = c("Partner" = "name_long")),
               aes(x=long, y=lat, group = group, fill = Vsi_produkti),
               color = "grey") + ggtitle("Celotni uvoz ZDA iz držav po svetu v letu 2015")+
  scale_fill_gradient(low = "Ghostwhite", high = "brown3", guide = "colourbar")+ xlab("")+
  ylab("")

print(zem2)
