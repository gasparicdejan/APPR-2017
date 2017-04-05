# Analiza izvoza in uvoza ZDA

Avtor: Dejan Gašparič

Mentor: Janoš Vidali

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18.

## Tematika

Vsebina, ki jo bom obravnaval pri tem projektu obsega trgovanje ZDA. V obsegu te analize, bom obravnaval izvoz ter uvoz ZDA z drugimi državami sveta v zadnjih petih letih. Za vsako državo s katero ZDA trguje, bom prikazal uvoz ter izvoz nekaj glavnih kategorij produktov ter uvoz in izvoz vseh produktov, ki jih uvaža oziroma izvaža ZDA v te države.  Podatki bodo v velikosti tisoč ameriških dolarjih (USD) na enoto.

Podatke bom pridobil na spletni strani:
- https://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2010/EndYear/2014/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/by-country/Product/Total;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2010/EndYear/2014/TradeFlow/Export/Indicator/XPRT-TRD-VL/Partner/by-country/Product/Total;
- ostale povezave sledijo iz klasifikacije po produktih izmed zadnjih dveh povezav.

## Cilj

Namen analize je ugotoviti v katere države ZDA največ izvaža in uvaža, kaj, koliko ter kako se izvoz in uvoz spreminjata skozi čas v zadnjih petih letih. V analizi podatkov nameravam tudi napovedati gibanje izvoza in uvoza ZDA za leto 2017.

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
