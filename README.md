# Install R Libraries Offline 
---
I would like to share with you this code that I used to solve my issues on **Installing R Libraries and its Dependencies on an Office PC with No Internet**. 

This code will not work if you don't have an internet
```{R}
install.packages("shiny")
```

Most large companies discourage having internet on their PC. If your role is a Data Analyst and you would like to apply your knowledge in Data Science using R, it will be difficult for you to install the necessary R libraries and its dependencies in your offline company PC. Not much information on this issue is addressed on the internet. I did thorough research and integrate the codes that work well for this scenario. I hope this code could help you!

----

### Instructions
#### 1. Download Packages in you Personal PC with Internet
```{R}
getPackages <- function(packs){
  packages <- unlist(
    tools::package_dependencies(packs, available.packages(),
                                which=c("Depends", "Imports"), recursive=TRUE)
  )
  packages <- union(packs, packages)
  packages
}

packages <- getPackages("shiny") # insert name of library

setwd(paste0(getwd(),"R/shiny_lib")) # directory for your library and its dependencies

pkgInfo <- download.packages(pkgs = packages, destdir = getwd(), type = "source") # type = "win.binary" for windows

```
#### 2. Create a CSV files of the downloaded libraries
```{R}
write.csv(file = "pkgFilenames.csv", basename(pkgInfo[, 2]), row.names = FALSE)
```

#### 3. Install Libraries in your Offline Company PC
Go to the directory of your packages that you need to install. Try to rerun if a prerequisite libraries is skipped.

```{R}
pkgFilenames <- read.csv("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]
install.packages(rev(pkgFilenames), repos = NULL, type = "source")
```
#### (optional) If a specific library is needed

- download library
```{R}
download.packages(pkgs = 'remotes', destdir = getwd(), type = "source")
```
- install library
```{R}
install.packages(
    pkgs="remotes_2.4.0.tar.gz"
  , repos = NULL
  , type="source", dependencies = TRUE)
```
