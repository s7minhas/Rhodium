if(Sys.info()["user"]=="janus829"){source('/Users/janus829/Desktop/Research/Rhodium/R/setup.R')}
if(Sys.info()["user"]=="Ben"){source('/Users/Ben/Github/Rhodium/R/setup.R')}

library(shapefiles)

# Load City pop data
setwd(pathData)
load("cityTotPopLatLongvFinal.rda")
source(paste0(pathMain,"/geodistance.R"))

# Load PRIO data and clean
# Clean PRIO data
setwd(paste0(pathData,'/PRIO - Conflict Site Data'))
prioData=read.csv("ConflictSite 4-2010_v3 Dataset.csv")
prioData$Conflict.territory=charSM(prioData$Conflict.territory)
prioData$Conflict.territory[prioData$Conflict.territory=='Yugoslavia']='Serbia'
prioData$Conflict.territory[prioData$Conflict.territory=='DRC']='Democratic Republic of Congo'
prioData$cname=countrycode(prioData$Conflict.territory, 'country.name','country.name')

prioAC=read.csv('ucdp.prio.armed.conflict.v4.2013.csv')

prioData$idyear=paste0(prioData$ID, prioData$Year)
prioAC$idyear=paste0(prioAC$ID, prioAC$YEAR)
prioAC=merge(prioAC, prioData[,3:ncol(prioData)], by='idyear', all.x=T, all.y=T)
prioAC = prioAC[which(prioAC$ID %in% unique(prioData$ID)),]
prioAC=prioAC[which(prioAC$YEAR %in%  1989:2008),]
##################################################################

##################################################################
# Calc distances from conflict sites
prioAC$cname[prioAC$Location=="Ethiopia"] <- "ETHIOPIA"
prioAC$cname[prioAC$Location=="Rwanda"] <- "RWANDA"
prioAC$cname[prioAC$Location=="Sierra Leone"] <- "SIERRA LEONE"
prioAC$cname[prioAC$Location=="Chad"] <- "CHAD"
prioAC <- prioAC[!is.na(prioAC$Latitude),]
prioAC <- prioAC[!prioAC$Latitude<(-360),]
prioAC$minDist <- minDist(prioAC$Latitude, prioAC$Longitude, prioAC$cname, prioAC$YEAR, fYrCty$cleanLat, fYrCty$cleanLong, fYrCty$cname, fYrCty$YearAlmanac)
prioAC$inRadius <- inRadius(prioAC$Latitude, prioAC$Longitude, prioAC$cname, prioAC$YEAR, fYrCty$cleanLat, fYrCty$cleanLong, fYrCty$cname, fYrCty$YearAlmanac, prioAC$Radius)
prioAC$capDist <- minDist(prioAC$Latitude, prioAC$Longitude, prioAC$cname, prioAC$YEAR, fYrCty$cleanLat[fYrCty$Capital==1], fYrCty$cleanLong[fYrCty$Capital==1], fYrCty$cname[fYrCty$Capital==1], fYrCty$YearAlmanac[fYrCty$Capital==1])
##################################################################

##################################################################
# Calc distances from natural resources
# setwd(paste0(pathData,'/Horn - Giant Fields Data'))
# oil <- read.shapefile("Giant_Fields_Data")
# oil <- as.data.frame(oil)
# newoil <- data.frame(stringsAsFactors=F)
# for(i in 1:nrow(oil))
# {
#   row <- data.frame(oil[i,])
#   dates <- oil$dbf.dbf.DISC_YR[i]:2014
#   newrows <- row[rep(1,length(dates)),]
#   newrows$dbf.dbf.DISC_YR <- dates
#   newoil <- rbind(newoil,newrows)
#   cat("\r",i)
# }
# newoil <- newoil[,c("dbf.dbf.LAT_DD","dbf.dbf.LON_DD","dbf.dbf.FIELD_TYPE","dbf.dbf.SIZE_CLASS","dbf.dbf.COUNTRY","dbf.dbf.DISC_YR")]
# names(newoil) <- c("lat","long","type","size","country","year")
# newoil <- newoil[newoil$year%in%1988:2009,]
# newoil$country <- as.character(newoil$country)
# newoil$country[newoil$country=="Sierre Leone"] <- "Sierra Leone"
# newoil$country[which(newoil$country=="UAE")] <- "United Arab Emirates"
# newoil$country <- countrycode(newoil$country,"country.name","country.name")
# prioAC$oilRadius <- inRadius(prioAC$Latitude, prioAC$Longitude, prioAC$cname, prioAC$YEAR, newoil$lat, newoil$long, newoil$country, newoil$year, prioAC$Radius)

##################################################################

##################################################################
# Aggregate to the country-year
prioAC$territorial <- as.numeric(prioAC$Incomp%in%c(1,3))
prioAC <- prioAC[,c("ID","Incomp","Int","CumInt","territorial","Conflict.area","Type","StartDate2","EpEndDate","Region","minDist","inRadius","capDist","cname","YEAR")]
prioAC$ccode=panel$ccode[match(prioAC$cname,panel$cname)]
prioAC$cyear=paste0(prioAC$ccode, prioAC$YEAR)
prioAC=prioAC[prioAC$Type!=2,]

# Aggregation options
aggAll=summaryBy(. ~ cyear, data=prioAC, FUN=c(mean,sum,min,max))

# Create country year
yData=aggAll[ ,c('cyear', 'YEAR.mean', 'ccode.mean',
                    'Int.mean', 'Int.max', 'CumInt.mean', 'CumInt.max', 'Type.mean','territorial.max','Conflict.area.mean','Conflict.area.max','Region.mean', 'minDist.mean', 'minDist.min', 'inRadius.sum', 'inRadius.max', 'capDist.min') ]
colnames(yData)[2:3] = c('year', 'ccode')
##################################################################

##################################################################
# Saving aggregation of conflict data to country-year level
setwd(pathData)
save(yData, file='countryYear_ConflictData.rda')
##################################################################