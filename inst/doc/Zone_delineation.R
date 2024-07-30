## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(paar)
library(sf)
require(ggplot2)

## -----------------------------------------------------------------------------
data(wheat, package = 'paar')

wheat_sf <- st_as_sf(wheat,
                     coords = c('x', 'y'),
                     crs = 32720)

## -----------------------------------------------------------------------------
plot(wheat_sf)

## -----------------------------------------------------------------------------
# Run the kmspc function
kmspc_results <- 
  kmspc(wheat_sf,
        number_cluster = 2:4,
        explainedVariance = 70,
        ldist = 0,
        udist = 40,
        center = TRUE)


## -----------------------------------------------------------------------------
kmspc_results$indices

## -----------------------------------------------------------------------------
head(kmspc_results$cluster)

## -----------------------------------------------------------------------------
wheat_clustered <- cbind(wheat_sf, kmspc_results$cluster)

## -----------------------------------------------------------------------------
plot(wheat_clustered[, "Cluster_2"])

## ----eval = !requireNamespace("ggplot2"), echo = FALSE, comment = NA----------
#  message("No package ggplot2 available. Code chunks using that package will not be evaluated.")

## ----eval = requireNamespace("ggplot2")---------------------------------------
ggplot(wheat_clustered) +
  geom_sf(aes(color = Cluster_2)) +
  theme_minimal()

