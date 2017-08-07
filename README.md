# Analiza izvoza in uvoza ZDA

Avtor: Dejan Gašparič

Mentor: Janoš Vidali

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18.

## Tematika

Vsebina projekta pri predmetu APPR, ki ga bom izdeloval obsega trgovanje ZDA. V obsegu analize bom obravnaval izvoz in uvoz ZDA z drugimi državami sveta za obdobje 10 let (2006-2015). Za države, ki so med največjimi uvoznicami/izvoznicami z ZDA, bom prikazal uvoz/izvoz nekaj glavnih kategorij produktov in uvoz/izvoz vseh produktov skupaj (celotnega uvoza/izvoza), ki jih uvaža/izvaža ZDA v te države. Podatki bodo v velikosti tisoč ameriških dolarjev (1000 USD).

Podatke bom pridobil na spletnih straneh:
- http://en.wikipedia.org/wiki/List_of_the_largest_trading_partners_of_the_United_States;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2006/EndYear/2015/TradeFlow/Import/Indicator/MPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- http://wits.worldbank.org/CountryProfile/en/Country/USA/StartYear/2006/EndYear/2015/TradeFlow/Export/Indicator/XPRT-TRD-VL/Partner/BY-COUNTRY/Product/Total;
- ostale povezave sledijo iz klasifikacije po produktih izmed zadnjih dveh povezav.

Podatki so v obliki HTML in CSV. 

## Podatkovni model

Podatki bodo predstavljeni posamezno za uvoz in izvoz v večih tabelah. V prvotnih tabelah bodo stolpci predstavljali leta izvoza/uvoza ter vrstice države s katerimi ZDA trguje. Naprej bom sestavil tabeli za celotni uvoz in celotni izvoz, kjer bodo vrstice predstavljale države za vsako leto posebaj, stolpci pa kategorije produktov. Ker podatki ne vsebujejo podatkov za vse države v vseh opazovanih letih, bom podatke očistil tako, da bom poskrbel, da so podatki za vsa leta v določeni kategoriji dosegljivi za določeno državo (kjer v določeni kategoriji manjka podatek za kakšno leto, bom celotno obdobje izključil iz analize v tej kategoriji za to državo, saj če manjka en podatek ne moremo spremljati kako se spreminja uvoz/izvoz skozi leta za tisto kategorijo).


## Plan dela

Namen analize je ugotoviti v katere države ZDA največ izvaža in uvaža, kakšna je trgovska bilanca in koliko ter kako se izvoz in uvoz spreminjata skozi čas v zadnjih letih pri največjih uvoznikih/izvoznikih. Podatke nameravam geografsko tudi prikazati in izvesti analizo razvrščanja na njih.

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
