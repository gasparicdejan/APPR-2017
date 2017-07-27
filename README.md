# Analiza izvoza in uvoza ZDA

Avtor: Dejan Gašparič

Mentor: Janoš Vidali

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18.

## Tematika

Vsebina, ki jo bom obravnaval pri tem projektu obsega trgovanje ZDA. V obsegu analize bom obravnaval izvoz in uvoz ZDA z drugimi državami sveta od leta 2011 do vključno z letom 2015. Za večje države, s katerimi ZDA trguje, bom prikazal uvoz in izvoz nekaj glavnih kategorij produktov ter uvoz in izvoz vseh produktov skupaj, ki jih uvaža oziroma izvaža ZDA v te države. Podatki bodo v velikosti tisoč ameriških dolarjih (USD) na enoto.

Podatke bom pridobil na spletnih straneh:
- https://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2011/EndYear/2015/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2006/EndYear/2010/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2011/EndYear/2015/TradeFlow/Export/Indicator/XPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2006/EndYear/2010/TradeFlow/Export/Indicator/XPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- ostale povezave sledijo iz klasifikacije po produktih izmed zadnjih dveh povezav.

Podatki so v obliki HTML in CSV. 

## Podatkovni model

Podatki bodo predstavljeni posamično za uvoz, izvoz v večih tabelah. V vsaki tabeli bodo stolpci predstavljali leta izvoza oz. uvoza ter vrstice države s katerimi ZDA trguje. Ker podatki ne vsebujejo vseh držav v vseh opazovanih letih, bom podatke očistil tako, da bom med vsemi državami izbral samo tiste, za katere bom imel na voljo podatke za vsa leta in med le temi samo največje.

## Plan dela

Namen analize je ugotoviti v katere države ZDA največ izvaža in uvaža, kakšna je trgovinska bilanca in koliko ter kako se izvoz in uvoz spreminjata skozi čas v zadnjih letih. Podatke nameravam geografsko tudi prikazati in napovedati gibanje izvoza in uvoza ZDA za leto 2016 s pomočjo regresije ter poiskati podatke (če bodo le na voljo) in jih primerjati s svojo napovedjo na podlagi podatkov, ki jih bom obravnaval.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
