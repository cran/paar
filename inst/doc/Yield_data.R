## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = !requireNamespace("ggplot2"), echo = FALSE, comment = NA----------
#  message("No package ggplot2 available. Code chunks using that package will not be evaluated.")

## ----setup--------------------------------------------------------------------
library(paar)
library(sf)
require(ggplot2)

data("barley", package = 'paar')

## -----------------------------------------------------------------------------
barley_sf <- st_as_sf(barley, 
                      coords = c("X", "Y"),
                      crs = 32720)

## -----------------------------------------------------------------------------
plot(barley_sf["Yield"])

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_sf) +
  geom_sf(aes(color = Yield)) +
  scale_color_viridis_c() +
  theme_minimal()

## -----------------------------------------------------------------------------
hist(barley_sf$Yield, main = 'Yield values distribution')

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_sf) +
  geom_histogram(aes(x = Yield)) +
  theme_minimal()

## -----------------------------------------------------------------------------
barley_clean_paar <-
  depurate(barley_sf, 
           y = 'Yield',
           toremove = c("edges", "outlier", "inlier"))



## -----------------------------------------------------------------------------
barley_clean_paar

## -----------------------------------------------------------------------------
summary_table <- summary(barley_clean_paar)
summary_table

## -----------------------------------------------------------------------------
barley_clean <- barley_clean_paar$depurated_data

## -----------------------------------------------------------------------------
plot(barley_clean["Yield"])

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_clean) +
  geom_sf(aes(color = Yield)) +
  scale_color_viridis_c() +
  theme_minimal()

## ----eval = !requireNamespace("ggplot2"), echo = FALSE, comment = NA----------
#  message('Package ggplot2 is not available.')

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_sf) +
  geom_sf(aes(color = Yield)) +
  scale_color_viridis_c() +
  theme_minimal()

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_clean) +
  geom_sf(aes(color = Yield)) +
  scale_color_viridis_c() +
  theme_minimal()

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_sf, aes(x = Yield)) +
  geom_histogram()

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_clean, aes(x = Yield)) +
  geom_histogram()

## -----------------------------------------------------------------------------
barley_sf <- cbind(barley_clean_paar, barley_sf)

## -----------------------------------------------------------------------------
plot(barley_sf[,'condition'], col = as.numeric(as.factor(barley_sf$condition)))
legend("topright", legend = levels(as.factor(barley_sf$condition)), fill = 1:4)

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(barley_sf) +
  geom_sf(aes(color = condition)) +
  scale_fill_viridis_d() +
  scale_color_discrete(
    labels = function(k) {k[is.na(k)] <- "normal"; k},
    na.value = "#44214234") +
  theme_minimal()

