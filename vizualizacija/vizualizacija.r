# 3. faza: Vizualizacija podatkov in
# 4. faza: Analiza podatkov


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
    theme(plot.title = element_text(lineheight=.8, face="bold"))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  return(narisi)
}

graf1 <- narisi.graf(2006,10)
graf2 <- narisi.graf(2007,10)
graf3 <- narisi.graf(2008,10)
graf4 <- narisi.graf(2009,10)
graf5 <- narisi.graf(2010,10)
graf6 <- narisi.graf(2011,10)
graf7 <- narisi.graf(2012,10)
graf8 <- narisi.graf(2013,10)
graf9 <- narisi.graf(2014,10)
graf10 <- narisi.graf(2015,10)



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
    theme(plot.title = element_text(lineheight=.8, face="bold"))+
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  return(narisi)
}

graf11 <- narisi.graf1(2006,10)
graf12 <- narisi.graf1(2007,10)
graf13 <- narisi.graf1(2008,10)
graf14 <- narisi.graf1(2009,10)
graf15 <- narisi.graf1(2010,10)
graf16 <- narisi.graf1(2011,10)
graf17 <- narisi.graf1(2012,10)
graf18 <- narisi.graf1(2013,10)
graf19 <- narisi.graf1(2014,10)
graf20 <- narisi.graf1(2015,10)






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
  ylab("")+ guides(fill = guide_colorbar(title = "Vsi produkti"))

print(zem1)




# Tabela "Uvoz" bo predstavljalo tabelo podatkov za leto 2015. 
Uvoz <- filter(tabela_uvoz, Leto == 2015)
Uvoz$Partner <- factor(Uvoz$Partner)

# Nastavimo tako, da se v tabeli sv1, stolpec name_long ujema z stolpcem Partner v tabeli Izvoz:
sv1$name_long<- factor(sv1$name_long, levels = levels(Uvoz$Partner))

# NArišemo zemljevid za uvoz ZDA:
zem2 <- ggplot() +
  geom_polygon(data = Uvoz %>%
                 right_join(sv1, by = c("Partner" = "name_long")),
               aes(x=long, y=lat, group = group, fill = Vsi_produkti),
               color = "grey") + ggtitle("Celotni uvoz ZDA iz držav po svetu v letu 2015")+
  scale_fill_gradient(low = "Ghostwhite", high = "brown3", guide = "colourbar")+ xlab("")+
  ylab("")+ guides(fill = guide_colorbar(title = "Vsi produkti"))

print(zem2)


#################### TRGOVINSKA BILANCA: ####################

# Sestavljena tabela po Partnerjih in letu za izvoz in uvoz:
uvoz_izvoz_tabela <- inner_join(tabela_uvoz, tabela_izvoz, by= c("Partner", "Leto"))


# Tabela "trg_bilanca" bo prikazovala trgovinsko bilanco med ZDA in državami za vsako leto:
trg_bilanca <- data.frame(uvoz_izvoz_tabela$Partner, uvoz_izvoz_tabela$Leto, 
                          uvoz_izvoz_tabela$Vsi_produkti.y - uvoz_izvoz_tabela$Vsi_produkti.x)
names(trg_bilanca) <- c("Partner", "Leto", "Trgovinska_bilanca")


# Zemljevid "zem3" bo prikazal trgovinsko bilanco med ZDA in državami za leto 2015:

Bilanca <- filter(trg_bilanca, Leto == 2015)
Bilanca$Partner <- factor(Bilanca$Partner)

sv1$name_long <- factor(sv1$name_long, levels = levels(Bilanca$Partner))

zem3 <- ggplot() +
  geom_polygon(data = Bilanca %>%
                 right_join(sv1, by = c("Partner" = "name_long")),
               aes(x=long, y=lat, group = group, fill = Trgovinska_bilanca),
               color = "grey") + 
  ggtitle("Trgovinska bilanca med ZDA in državami po svetu v letu 2015")+
  scale_fill_gradient(low = "Ghostwhite", high = "blue", guide = "colourbar")+ xlab("")+
  ylab("")+ guides(fill = guide_colorbar(title = "Vsi produkti"))

print(zem3)
