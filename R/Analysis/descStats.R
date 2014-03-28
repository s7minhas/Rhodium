# Workspace
if(Sys.info()["user"]=="janus829"){source('/Users/janus829/Desktop/Research/Rhodium/R/setup.R')}
if(Sys.info()["user"]=="Ben"){source('/Users/Ben/Github/Rhodium/R/setup.R')}


########################################################################
# World map of cities and conflicts
setwd(pathData)
load("cityTotPopLatLongvFinal.rda")
setwd(paste0(pathData,'/PRIO - Conflict Site Data'))
prioData=read.csv("ConflictSite 4-2010_v3 Dataset.csv")
prioData$Conflict.territory=charSM(prioData$Conflict.territory)
prioData$Conflict.territory[prioData$Conflict.territory=='Yugoslavia']='Serbia'
prioData$Conflict.territory[prioData$Conflict.territory=='DRC']='Democratic Republic of Congo'
prioData$cname=countrycode(prioData$Conflict.territory, 'country.name','country.name')
cntries=unique(prioData$cname)

# Color Non-Conflict countries
worldmap=cshp(as.Date('2000-1-1'))
worldmap$CNTRY_NAME=charSM(worldmap$CNTRY_NAME)
worldmap$CNTRY_NAME[worldmap$CNTRY_NAME=='Congo, DRC']='Congo, Democratic Republic of'
Wcntries=worldmap$CNTRY_NAME
Wcntries=panel$cname[match(Wcntries, panel$CNTRY_NAME)]
noConfCntries=setdiff(Wcntries, cntries)
mapColors=rep('white',length(Wcntries))
mapColors[which(Wcntries %in% noConfCntries)] = 'grey'

setwd(pathTex)
pdf(file='CityConfMap.pdf', width=6, height=3)
plot(worldmap, col=mapColors)
points(fYrCty$cleanLong, fYrCty$cleanLat, col='blue', pch=18, cex=0.5)
points(prioData$Longitude,prioData$Latitude, col='red', pch=16,cex=0.5)
dev.off()
########################################################################

########################################################################
# Some stats on the city data
setwd(pathData)
load("cityTotPopLatLongvFinal.rda")

# Average cities listed by cntry and year
fYrCty$temp=1
cityStats=summaryBy(temp ~ Country + YearAlmanac, data=fYrCty, FUN=sum)
cityGraph=summaryBy(temp.sum ~ YearAlmanac, data=cityStats, FUN=mean)
temp=ggplot(cityGraph, aes(x=YearAlmanac, y=temp.sum.mean)) + geom_line()
temp
########################################################################