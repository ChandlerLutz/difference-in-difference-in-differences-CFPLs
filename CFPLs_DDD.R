
## ----warning=FALSE,message=FALSE-----------------------------------------
#Load packages
library(ggplot2); library(magrittr); library(data.table); library(AER)

#Read in the Data
DT <- fread("https://raw.githubusercontent.com/ChandlerLutz/difference-in-difference-in-differences-CFPLs/master/data-raw/county_forc_cfpl_data.csv")

## ------------------------------------------------------------------------
head(DT)

## ------------------------------------------------------------------------
dd.means <- DT %>%
    #Get the means by the CA and CFPL dummies for the sand states
    .[sand.state == 1,
      .(mean.zillow.forc = weighted.mean(zillow.forc, w = hh2000)),
      by = .(CA, CFPL)]
print(dd.means)

## ------------------------------------------------------------------------
ggplot(data = dd.means, aes(x = CFPL, y = mean.zillow.forc)) +
    geom_line(aes(color = as.factor(CA))) +
    scale_x_continuous(breaks = c(0, 1))

## ------------------------------------------------------------------------
lm(zillow.forc ~ CA * CFPL, data = DT[sand.state == 1], weights = hh2000) %>%
    coeftest(vcov = sandwich)

## ------------------------------------------------------------------------
lm(zillow.forc ~ CFPL * forc.high, data = DT[CA == 1], weights = hh2000) %>%
    coeftest(sandwich)

## ------------------------------------------------------------------------
lm(zillow.forc ~ CA * CFPL, data = DT[forc.high == 1], weights = hh2000) %>%
    coeftest(sandwich)

## ------------------------------------------------------------------------
lm(zillow.forc ~ CFPL * forc.high, data = DT[CA == 1], weights = hh2000) %>%
    coeftest(sandwich)

## ------------------------------------------------------------------------
lm(zillow.forc ~ CFPL * forc.high, data = DT[CA == 0], weights = hh2000) %>%
    coeftest(sandwich)

## ------------------------------------------------------------------------
#We're going to save the model b/c we'll need it later 
ddd.mod <- lm(zillow.forc ~ CFPL * forc.high * CA, data = DT, weights = hh2000)
ddd.mod %>% coeftest(sandwich)

## ------------------------------------------------------------------------
linearHypothesis(ddd.mod, "CA + forc.high:CA = 0", vcov = sandwich)

