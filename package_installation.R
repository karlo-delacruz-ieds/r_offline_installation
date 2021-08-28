### download packages ###
getPackages <- function(packs){
  packages <- unlist(
    tools::package_dependencies(packs, available.packages(),
                                which=c("Depends", "Imports"), recursive=TRUE)
  )
  packages <- union(packs, packages)
  packages
}

packages <- getPackages("shiny") # insert name of library

getwd() # check
setwd(paste0(getwd(),"R/shiny_lib")) # modify library
getwd() # check


pkgInfo <- download.packages(pkgs = packages, destdir = getwd(), type = "source") # type = "win.binary"
# Save just the package file names (basename() strips off the full paths leaving just the filename)
write.csv(file = "pkgFilenames.csv", basename(pkgInfo[, 2]), row.names = FALSE)

### install packages
getwd() # check
setwd("/home/cdsw/R/DBI_lib") # modify library
getwd() # check
pkgFilenames <- read.csv("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]
install.packages(rev(pkgFilenames), repos = NULL, type = "source")

#### simple installation if internet available
install.packages("shiny") # easy if it has internet; downloads dependencies

### manual uninstall library
remove.packages(c("httpuv", "xtable"))

### install packages
download.packages(pkgs = 'remotes', destdir = getwd(), type = "source")
install.packages(
    pkgs="remotes_2.4.0.tar.gz"
  , repos = NULL
  , type="source", dependencies = TRUE
)
######
library(DBI)
library(RPostgres)





