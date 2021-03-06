# Clearing workspace
rm(list=ls())

# Setting working directory
if(Sys.info()["user"]=="janus829" | Sys.info()["user"]=="s7m")
{pathMain="~/Research/Rhodium/R";
	pathData='~/Dropbox/Research/Rhodium/Data/';
	pathGraphics="~/Dropbox/Research/Rhodium/Graphics"}

# Setting working directory
if(Sys.info()["user"]=="Ben")
{pathMain="/Users/Ben/Github/Rhodium/R";
 pathGraphics="/Users/Ben/Dropbox/Rhodium/Graphics";
 pathData="/Users/Ben/Dropbox/Rhodium/Data"
}

# Load in panel dataframe
setwd(paste(pathMain,'/BuildingPanelData/',sep=''))
load('panel.rda')

# Loading libraries and functions
loadPkg=function(toLoad){
  for(lib in toLoad){
  if(! lib %in% installed.packages()[,1])
    { install.packages(lib, repos='http://cran.rstudio.com/') }
  suppressMessages( library(lib, character.only=TRUE) )
  }
}

pks = c('abind', 'MASS', 'ggplot2', 'grid', 
  'tikzDevice', 'RColorBrewer', 'sbgcop', 'reshape',
  'foreign', 'doBy', 'lme4', 'shapefiles', 'cshapes',
  'WDI', 'countrycode')
loadPkg(pks)

# gg theme
theme_set(theme_bw())

# Helpful functions
numSM=function(x){as.numeric(as.character(x))}
charSM=function(x){as.character(x)}
contToCat=function(x,by=0.1){ cut(x, breaks=quantile(x,seq(0,1,by),na.rm=T)) }
logTrans=function(x){ log( x + abs(min(x, na.rm=T)) + 1) }

# Lagging vars
lagTS <- function(x,l){
  cuts <- (length(x)-(l-1)):length(x)
  c(rep(NA,l), x[ -cuts ] )
}

lagDataSM <- function(data, country_year, country, varsTOlag, lag=1)
{
  data[,country_year] = numSM(data[,country_year])
  data <- data[order(data[,country_year]),]
  lagData <- apply(data[,varsTOlag], 2,
    function(x){
      unlist(by(x, data[,country], function(y) lagTS(y,lag) ) )
    } )
  colnames(lagData) <- paste('lag', lag, '_', varsTOlag, sep='')
  cbind(data, lagData)
}

# Create model formula
modForm = function(dv='gdpGr_l0', ivs, id='ccode', type='random'){
  base = paste(dv, paste(ivs, collapse=' + '), sep=' ~ ')
  if(type=='random'){
    eff = paste0('(1 |', id, ')')
    if(length(eff)>1){ eff = paste(eff, collapse='+') }
    base = paste(base, eff, sep=' + ')
  }

  if(type=='fixed'){
    eff = paste0('factor(', id, ')')
    if(length(eff)>1){
      eff = paste0( paste(eff, collapse='+'), '- 1') } else {
        eff = paste0(eff, '- 1')
      }    
    base = paste(base, eff, sep=' + ')
  }
  return(formula(base))
}

# http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/#Helper functions
## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
    library(plyr)

    # New version of length which can handle NA's: if na.rm==T, don't count them
    length2 <- function (x, na.rm=FALSE) {
        if (na.rm) sum(!is.na(x))
        else       length(x)
    }

    # This does the summary. For each group's data frame, return a vector with
    # N, mean, and sd
    datac <- ddply(data, groupvars, .drop=.drop,
      .fun = function(xx, col) {
        c(N    = length2(xx[[col]], na.rm=na.rm),
          mean = mean   (xx[[col]], na.rm=na.rm),
          sd   = sd     (xx[[col]], na.rm=na.rm)
        )
      },
      measurevar
    )

    # Rename the "mean" column    
    datac <- rename(datac, c("mean" = measurevar))

    datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean

    # Confidence interval multiplier for standard error
    # Calculate t-statistic for confidence interval: 
    # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
    ciMult <- qt(conf.interval/2 + .5, datac$N-1)
    datac$ci <- datac$se * ciMult

    return(datac)
}