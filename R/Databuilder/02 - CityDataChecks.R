if(Sys.info()["user"]=="janus829"){source('/Users/janus829/Desktop/Research/Rhodium/R/setup.R')}
if(Sys.info()["user"]=="Ben"){source('/Users/Ben/Github/Rhodium/R/setup.R')}

load(paste0(pathData,"/cityTotPopLatLong.rda"))

# Clean up cntCty names and replace special characters
cityPop$cntCty <- gsub("  "," ",cityPop$cntCty)
cityPop$cntCty <- gsub("\x92","i",cityPop$cntCty)
cityPop$cntCty <- gsub("\x87","a",cityPop$cntCty)
cityPop$cntCty <- gsub("\x8e","e",cityPop$cntCty)
cityPop$cntCty <- gsub("\x8c","a",cityPop$cntCty)
cityPop$cntCty <- gsub("\xd5","'",cityPop$cntCty)
cityPop$cntCty <- gsub("\xd5","'",cityPop$cntCty)
cityPop$cntCty <- gsub("\x8e","e",cityPop$cntCty)
cityPop$cntCty <- gsub("_ ","_",cityPop$cntCty)
cityPop$cntCty <- gsub(",","",cityPop$cntCty)
cityPop$cntCty <- gsub("\\.","",cityPop$cntCty)
cityPop$cntCty <- gsub("^\\s+|\\s+$","",cityPop$cntCty)
cityPop$cntCty <- gsub("'","",cityPop$cntCty)

# Fix non-unique city names
cityPop$cntCty[grepl("Mumbai",cityPop$cntCty) | grepl("Bombay",cityPop$cntCty)] <- "India_Mumbai"
cityPop$cntCty <- gsub("Kolkata","Calcutta",cityPop$cntCty)
cityPop$cntCty <- gsub("Dacca","Dhaka",cityPop$cntCty)
cityPop$cntCty <- gsub("-Mount Lavinia","",cityPop$cntCty)
cityPop$cntCty <- gsub("Jafna","Jaffna",cityPop$cntCty)
cityPop$cntCty[grepl("Kotte",cityPop$cntCty)] <- "Sri Lanka_Sri Jayawardenapura Kotte"
cityPop$cntCty <- gsub("Connakry","Conakry",cityPop$cntCty)
cityPop$cntCty <- gsub("Bucuramanga","Bucaramanga",cityPop$cntCty)
cityPop$cname[cityPop$cntCty=="Yugoslavia_Lusaka"] <- "ZAMBIA"
cityPop$cntCty <- gsub("Yugoslavia_Lusaka","Zambia_Lusaka",cityPop$cntCty)
warning("Wrong country!")
cityPop$cntCty <- gsub("Russia_Kazau","Russia_Kazan",cityPop$cntCty)
cityPop$cntCty <- gsub(" \\(Scotland\\)","",cityPop$cntCty)
cityPop$cntCty <- gsub("Cotonu","Cotonou",cityPop$cntCty)
cityPop$cntCty <- gsub("Nizhniy Novgorod","Nizhny Novgorod",cityPop$cntCty)
cityPop$cntCty <- gsub("Nizhny Novogorod","Nizhny Novgorod",cityPop$cntCty)
cityPop$cntCty <- gsub("stPetersburg","St Petersburg",cityPop$cntCty)
cityPop$cntCty <- gsub("Yamaoussoukro","Yamoussoukro",cityPop$cntCty)
cityPop$cntCty <- gsub("Arhus","Aarhus",cityPop$cntCty)
cityPop$cntCty <- gsub("Arthus","Aarhus",cityPop$cntCty)
cityPop$cntCty <- gsub("Arequioa","Arequipa",cityPop$cntCty)
cityPop$cntCty <- gsub("Ciudad del Estate","Ciudade del Este",cityPop$cntCty)
cityPop$cntCty <- gsub("Ciudade del Este","Ciudad del Este",cityPop$cntCty)
cityPop$cntCty <- gsub("Maseur","Maseru",cityPop$cntCty)
cityPop$cntCty <- gsub("Bujumbara","Bujumbura",cityPop$cntCty)
cityPop$cntCty <- gsub("Bujumabura","Bujumbura",cityPop$cntCty)
cityPop$cntCty <- gsub("Vina Del Mar","Vina del Mar",cityPop$cntCty)
cityPop$cntCty <- gsub("Abelaide","Adelaide",cityPop$cntCty)
cityPop$cntCty <- gsub("Temuca","Temuco",cityPop$cntCty)
cityPop$cntCty <- gsub("Kinhasa","Kinshasa",cityPop$cntCty)
cityPop$cntCty <- gsub("Point-Noire","Pointe-Noire",cityPop$cntCty)
cityPop$cntCty <- gsub("Semerang","Semarang",cityPop$cntCty)
cityPop$cntCty <- gsub("Surabaja","Surabaya",cityPop$cntCty)
cityPop$cntCty <- gsub("Barquisimeto","Barquisimento",cityPop$cntCty)
cityPop$cntCty <- gsub("Cartegena","Cartagena",cityPop$cntCty)
cityPop$cntCty <- gsub("Baranquilla","Barranquilla",cityPop$cntCty)
cityPop$cntCty <- gsub("Barraquilla","Barranquilla",cityPop$cntCty)
cityPop$cntCty <- gsub("Barranquila","Barranquilla",cityPop$cntCty)
cityPop$cntCty <- gsub("Narramqiolla","Barranquilla",cityPop$cntCty)
cityPop$cntCty <- gsub("Djbouti","Djibouti",cityPop$cntCty)
cityPop$cntCty <- gsub("NDjamena","Ndjamena",cityPop$cntCty)
cityPop$cntCty <- gsub("Asseb","Assab",cityPop$cntCty)
cityPop$cntCty <- gsub("Madras","Chennai",cityPop$cntCty)
cityPop$cntCty <- gsub("Tiaz","Taiz",cityPop$cntCty)
cityPop$cntCty <- gsub("Taizz","Taiz",cityPop$cntCty)
cityPop$cntCty <- gsub("Bankok","Bangkok",cityPop$cntCty)
cityPop$cntCty <- gsub("Manilla","Manila",cityPop$cntCty)
cityPop$cntCty <- gsub("Hodiedah","Al-Hudaydah",cityPop$cntCty)
cityPop$cntCty <- gsub("Al-Hudayda","Al-Hudaydah",cityPop$cntCty)
cityPop$cntCty[cityPop$cntCty == "Yemen_Sana"] <- "Yemen_Sanaa"
cityPop$cntCty[cityPop$cntCty == "Yemen Arab Republic_Sana"] <- "Yemen Arab Republic_Sanaa"
cityPop$cntCty[cityPop$cntCty == "Republic of Yemen_Sana"] <- "Republic of Yemen_Sanaa"
cityPop$cntCty[cityPop$cntCty == "Yemen_Samaa"] <- "Yemen_Sanaa"
cityPop$cntCty <- gsub("Rangoon","Yangon",cityPop$cntCty)
cityPop$cntCty <- gsub("Puebla de Zaragoza","Puebla",cityPop$cntCty)
cityPop$cntCty <- gsub("Ciudad Netzahualcoyotl","Nezahualcoyotl",cityPop$cntCty)
cityPop$cntCty <- gsub("Federal District \\(Mexico City\\)","Mexico City",cityPop$cntCty)
cityPop$cntCty <- gsub("Ecatepic","Ecatepec",cityPop$cntCty)
cityPop$cntCty <- gsub("Gyadalajara","Guadalajara",cityPop$cntCty)
cityPop$cntCty <- gsub("Chiitagong","Chittagong",cityPop$cntCty)
cityPop$cntCty <- gsub("Ahmadabad","Ahmedabad",cityPop$cntCty)
cityPop$cntCty <- gsub("_Canton","_Guangzhou",cityPop$cntCty)
cityPop$cntCty <- gsub("Nasau","Nassau",cityPop$cntCty)
cityPop$cntCty <- gsub("Monterey","Monterrey",cityPop$cntCty)
cityPop$cntCty <- gsub("Al-Manama","Manama",cityPop$cntCty)
cityPop$cntCty <- gsub("Katmandu","Kathmandu",cityPop$cntCty)
cityPop$cntCty <- gsub("_Delhi","_New Delhi",cityPop$cntCty)
cityPop$cntCty <- gsub("New Dehli","New Delhi",cityPop$cntCty)
cityPop$cntCty <- gsub("_Kuwait City","_Kuwait",cityPop$cntCty)
cityPop$cntCty <- gsub("Chungking","Chongqing",cityPop$cntCty)
cityPop$cntCty <- gsub("Al-Jizah","Giza",cityPop$cntCty)
cityPop$cntCty <- gsub("City of Cairo","Cairo",cityPop$cntCty)
cityPop$cntCty <- gsub("Greater Cairo","Cairo",cityPop$cntCty)
cityPop$cntCty <- gsub("Shubra el Khema","Shubra El-Kheima",cityPop$cntCty)
cityPop$cntCty <- gsub("Subra al-Khaymah","Shubra El-Kheima",cityPop$cntCty)
cityPop$cntCty <- gsub("Kandehar","Kandahar",cityPop$cntCty)
cityPop$cntCty <- gsub("Marrakech","Marrakesh",cityPop$cntCty)
cityPop$cntCty <- gsub("Ciudad Juarez","Juarez",cityPop$cntCty)
cityPop$cntCty <- gsub("TelAviv-Yafo","Tel Aviv",cityPop$cntCty)
cityPop$cntCty <- gsub("Esfahan","Isfahan",cityPop$cntCty)
cityPop$cntCty <- gsub("Rabat-Sale","Rabat",cityPop$cntCty)
cityPop$cntCty <- gsub("Fes","Fez",cityPop$cntCty)
cityPop$cntCty <- gsub("Lefkosia","Nicosia",cityPop$cntCty)
cityPop$cntCty <- gsub("Karkuk","Kirkuk",cityPop$cntCty)
cityPop$cntCty <- gsub("Teheran","Tehran",cityPop$cntCty)
cityPop$cntCty <- gsub("_Arbil","_Erbil",cityPop$cntCty)
cityPop$cntCty <- gsub("_Irbil","_Erbil",cityPop$cntCty)
cityPop$cntCty <- gsub("Mashad","Mashhad",cityPop$cntCty)
cityPop$cntCty <- gsub("Constatine","Constantine",cityPop$cntCty)
cityPop$cntCty <- gsub("Mazare Sharif","Mazar-i-Sharif",cityPop$cntCty)
cityPop$cntCty <- gsub("Mazare-Sharif","Mazar-i-Sharif",cityPop$cntCty)
cityPop$cntCty <- gsub("Algeirs","Algiers",cityPop$cntCty)
cityPop$cntCty <- gsub("Dushaube","Dushanbe",cityPop$cntCty)
cityPop$cntCty <- gsub("Samarkhand","Samarkand",cityPop$cntCty)
cityPop$cntCty <- gsub("Khodzhent \\(Leninabad\\)","Khodzhent",cityPop$cntCty)
cityPop$cntCty <- gsub("Khujand","Khodzhent",cityPop$cntCty)
cityPop$cntCty <- gsub("Gyandzha","Ganja",cityPop$cntCty)
cityPop$cntCty <- gsub("New York City","New York",cityPop$cntCty)
cityPop$cntCty <- gsub("_New York","_New York City",cityPop$cntCty)
cityPop$cntCty <- gsub("Manamah","Manama",cityPop$cntCty)
cityPop$cntCty <- gsub("Shubra al-Khaymah","Shubra El-Kheima",cityPop$cntCty)
cityPop$cntCty <- gsub("Faisalabad \\(Lyallpur\\)","Faisalabad",cityPop$cntCty)
cityPop$cntCty <- gsub("Teshkent","Tashkent",cityPop$cntCty)
cityPop$cntCty <- gsub("Tirane","Tirana",cityPop$cntCty)
cityPop$cntCty <- gsub("Prelep","Prilep",cityPop$cntCty)
cityPop$cntCty <- gsub("Batoumi","Batumi",cityPop$cntCty)
cityPop$cntCty <- gsub("Kutaisa","Kutaisi",cityPop$cntCty)
cityPop$cntCty <- gsub("Sokhumi","Sukhumi",cityPop$cntCty)
cityPop$cntCty <- gsub("Costanta","Constanta",cityPop$cntCty)
cityPop$cntCty <- gsub("Ottowa","Ottawa",cityPop$cntCty)
cityPop$cntCty <- gsub("Brazov","Brasov",cityPop$cntCty)
cityPop$cntCty <- gsub("Rimisoara","Timisoara",cityPop$cntCty)
cityPop$cntCty <- gsub("Haerbin","Harbin",cityPop$cntCty)
cityPop$cntCty <- gsub("Cluj Napoca","Cluj-Napoca",cityPop$cntCty)
cityPop$cntCty <- gsub("Clug-Napoca","Cluj-Napoca",cityPop$cntCty)
cityPop$cntCty <- gsub("Tighina","Bendery",cityPop$cntCty)
cityPop$cntCty <- gsub("Kishnev","Chisinau",cityPop$cntCty)
cityPop$cntCty <- gsub("Chinisau","Chisinau",cityPop$cntCty)
cityPop$cntCty <- gsub("Chisinau \\(Kishinyov\\)","Chisinau",cityPop$cntCty)
cityPop$cntCty <- gsub("Beltsy","Balti",cityPop$cntCty)
cityPop$cntCty <- gsub("Adibjan","Abidjan",cityPop$cntCty)
cityPop$cntCty <- gsub("Samara","Samaria",cityPop$cntCty)
cityPop$cntCty <- gsub("Bernaul","Barnaul",cityPop$cntCty)
cityPop$cntCty <- gsub("Mensk","Minsk",cityPop$cntCty)
cityPop$cntCty <- gsub(" \\(Northern Ireland\\)","",cityPop$cntCty)
cityPop$cntCty[cityPop$cntCty == "United Kingdom_Edinburg"] <- "United Kingdom_Edinburgh"
cityPop$cntCty <- gsub("StPetersburg","St Petersburg",cityPop$cntCty)
cityPop$cntCty <- gsub("Dehiwela","Dehiwala",cityPop$cntCty)
cityPop$cntCty <- gsub("Gorky","Nizhy Novgorod",cityPop$cntCty)
cityPop$cntCty <- gsub("Tblisi","Tbilisi",cityPop$cntCty)
cityPop$cntCty <- gsub("Ecatapec","Ecatepec",cityPop$cntCty)
cityPop$cntCty <- gsub("Calcutta \\(Calcutta\\)","Calcutta",cityPop$cntCty)
cityPop$cntCty <- gsub("as-Salimiyah","Al-Salimiyah",cityPop$cntCty)
cityPop$cntCty <- gsub("Yangon \\(Yangon\\)","Yangon",cityPop$cntCty)
cityPop$cname[cityPop$cntCty=="Peru_Manila"] <- "PHILIPPINES"
cityPop$cntCty <- gsub("Peru_Manila","Philippines_Manila",cityPop$cntCty) 
warning("Wrong country!")
cityPop$cname[cityPop$cntCty=="Peru_Quezon City"] <- "PHILIPPINES"
cityPop$cntCty <- gsub("Peru_Quezon City","Philippines_Quezon City",cityPop$cntCty)
warning("Wrong country!")
cityPop$cname[cityPop$cntCty=="Peru_Cebu"] <- "PHILIPPINES"
cityPop$cntCty <- gsub("Peru_Cebu","Philippines_Cebu",cityPop$cntCty)
warning("Wrong country!")
cityPop$cntCty <- gsub("Saint Petersburg","St Petersburg",cityPop$cntCty)
cityPop$cntCty[cityPop$cntCty == "Sri Lanka_Sri Jayawardenepura"] <- "Sri Lanka_Sri Jayawardenapura Kotte"
cityPop$cntCty[cityPop$cntCty == "Tajikistan_Khodzent (Leninabad)"] <- "Tajikistan_Khodzhent"
cityPop$cntCty[cityPop$cntCty == "Tajikistan_Khodzent"] <- "Tajikistan_Khodzhent"
cityPop$cntCty[cityPop$cntCty == "Bangladesh_Chitaagong"] <- "Bangladesh_Chittagong"
cityPop$cntCty <- gsub(" \\(Falkland Islands and Dependencies Islands\\)","",cityPop$cntCty)
cityPop$cntCty <- gsub(" \\(Cayman Islands\\)","",cityPop$cntCty)
cityPop$cntCty <- gsub("Mashed","Mashhad",cityPop$cntCty)
cityPop$cntCty <- gsub("Leningrad","St Petersburg",cityPop$cntCty)
cityPop$cntCty <- gsub("Nizhy Novgorod","Nizhny Novgorod",cityPop$cntCty)
cityPop$cntCty <- gsub("_Heart","_Herat",cityPop$cntCty)
cityPop$cname[cityPop$cntCty=="Republic of the Congo_Kinshasa"] <- "CONGO, THE DEMOCRATIC REPUBLIC OF"
cityPop$cntCty <- gsub("Republic of the Congo_Kinshasa","Congo, Democratic Republic of_Kinshasa",cityPop$cntCty) 
warning("Wrong country!")

cityPop$cntCty[cityPop$cntCty=="Paraguay_Asunci\U3e37393cn"] <- "Paraguay_Asuncion"
cityPop$cntCty[cityPop$cntCty=="Panama_Col\U3e37393cn"] <- "Panama_Colon"
cityPop$cntCty[cityPop$cntCty=="Mexico_Nezahualc\U3e37393cyotl"] <- "Mexico_Nezahualcoyotl"
cityPop$cntCty[cityPop$cntCty=="Paraguay_Asunci\227n"] <- "Paraguay_Asuncion"
cityPop$cntCty[cityPop$cntCty=="Mexico_Nezahualc\227yotl"] <- "Mexico_Nezahualcoyotl"
cityPop$cntCty[cityPop$cntCty=="Panama_Col\227n"] <- "Panama_Colon"

# Unique latitude and longitude identifier
cityPop$LL <- paste(cityPop$Lat,cityPop$Long,sep="_")

# Fix NA_NA cities
for(i in 1:nrow(cityPop))
{
  if(cityPop$LL[i]=="NA_NA" | cityPop$LL[i]=="Weird String_Weird String" | cityPop$LL[i]=="Not Found_Not Found")
  {
    uniqueID <- cityPop$cntCty[i]
    latlons <- unique(na.omit(cityPop$LL[cityPop$cntCty==uniqueID]))
    latlons <- latlons[latlons!="NA_NA" & latlons!="Weird String_Weird String" & latlons!="Not Found_Not Found"]
    if(is.character(latlons) & length(latlons)!=0)
    {
      cityPop$LL[cityPop$cntCty==uniqueID] <- latlons
    }
  }
}

uniqueCty <- cityPop[!duplicated(cityPop$cntCty),]
ctyTable <- table(uniqueCty$LL,uniqueCty$cntCty)
nonuniqueLL <- rownames(ctyTable)[rowSums(ctyTable)>1]
for(i in nonuniqueLL)
{
  print(paste("======================",i,"=====================",sep=""))
  print(unique(cityPop$cntCty[cityPop$LL==i]))
}

cityPop$cleanCity <- NA
cityPop$cleanCountry <- NA
cityPop$cleanLat <- NA
cityPop$cleanLong <- NA
for(i in 1:nrow(cityPop))
{
  countrycity <- strsplit(cityPop$cntCty[i],"_")
  latlong <- (strsplit(cityPop$LL[i],"_"))
  cityPop$cleanCity[i] <- countrycity[[1]][2]
  cityPop$cleanCountry[i] <- countrycity[[1]][1]
  cityPop$cleanLat[i] <- latlong[[1]][1]
  cityPop$cleanLong[i] <- latlong[[1]][2]
}
cityPop$cleanLat <- as.numeric(cityPop$cleanLat)
cityPop$cleanLong <- as.numeric(cityPop$cleanLong)

# Special cases hand-coded
cityPop[cityPop$cntCty=="Egypt_El Bhalla el Kubra",c("cleanLat","cleanLong")] <- c(30.9670,31.1670)
cityPop[cityPop$cntCty=="Soviet Union_Kuibyshev",c("cleanLat","cleanLong")] <- c(47.3590349,36.6480764)
cityPop[cityPop$cntCty=="Soviet Union_Nizhny Novgorod",c("cleanLat","cleanLong")] <- c(56.29274,43.9267452)
cityPop[cityPop$cntCty=="Soviet Union_Sverdlovsk",c("cleanLat","cleanLong")] <- c(48.0440,39.3850)
cityPop[cityPop$cntCty=="Czechoslovakia_Ostrova",c("cleanLat","cleanLong")] <- c(49.2040603,16.4293455)
cityPop[cityPop$cntCty=="Yugoslavia_Split",c("cleanLat","cleanLong")] <- c(43.5148515,16.4490835)
cityPop[cityPop$cntCty=="Eritrea_the ports of Massawa and Assab",c("cleanLat","cleanLong")] <- c(15.602493,39.4507885)
cityPop[cityPop$cntCty=="Kuwait_Al-Salimiyah",c("cleanLat","cleanLong")] <- c(21.5495764,39.1912036)
cityPop[cityPop$cntCty=="Afghanistan_Herat",c("cleanLat","cleanLong")] <- c(34.353456,62.2109842)
cityPop[cityPop$cntCty=="Yugoslavia_Nis",c("cleanLat","cleanLong")] <- c(43.3161809,21.8933594)
cityPop[cityPop$cntCty=="Serbia & Montenegro_Nis",c("cleanLat","cleanLong")] <- c(43.3161809,21.8933594)
cityPop[cityPop$cntCty=="Tonga_Nukualofa",c("cleanLat","cleanLong")] <- c(-21.1419326,-175.1976012)
cityPop[cityPop$cntCty=="United Kingdom_George Town",c("cleanLat","cleanLong")] <- c(19.2902069,-81.369597)
cityPop[cityPop$cntCty=="United Kingdom_Stanley",c("cleanLat","cleanLong")] <- c(54.8682008,-1.6901179)
cityPop[cityPop$cntCty=="Vietnam_Qui Nhon",c("cleanLat","cleanLong")] <- c(13.7848405,109.216263)

unique(cityPop$cntCty[is.na(cityPop$cleanLat)])

# Fixing SM's fuckup
cityPop[which(cityPop$cname %in% 'DJIBOUTI' & cityPop$YearAlmanac %in% 2006),][1,'YearAlmanac']=2005
cityPop[which(cityPop$cname %in% "COTE D'IVOIRE" & cityPop$YearAlmanac %in% 1992),]=cityPop[which(cityPop$cname %in% "COTE D'IVOIRE" & cityPop$YearAlmanac %in% 1993),]
cityPop[which(cityPop$cname %in% "COTE D'IVOIRE" & cityPop$YearAlmanac %in% 1993),][1,'YearAlmanac']=1992

# Fixing capitals manually
cityPop[which(cityPop$cname %in% "COTE D'IVOIRE" & cityPop$cleanCity=='Yamoussoukro'), 'Capital']=1
cityPop[which(cityPop$cname %in% "COTE D'IVOIRE" & cityPop$cleanCity!='Yamoussoukro'), 'Capital']=0

cityPop[which(cityPop$cleanCity %in% "Santafe de Bogota" ), 'cleanCity'] = 'Bogota'

cityPop[which(cityPop$cname %in% "ISRAEL" & cityPop$cleanCity=='Jerusalem'), 'Capital']=1
cityPop[which(cityPop$cname %in% "ISRAEL" & cityPop$cleanCity!='Jerusalem'), 'Capital']=0

cityPop[which(cityPop$cname %in% "MEXICO" & cityPop$cleanCity=='Mexico City'), 'Capital']=1
cityPop[which(cityPop$cname %in% "MEXICO" & cityPop$cleanCity!='Mexico City'), 'Capital']=0

cityPop[which(cityPop$cname %in% "ISRAEL" & cityPop$cleanCity=='Jerusalem'), 'Capital']=1
cityPop[which(cityPop$cname %in% "ISRAEL" & cityPop$cleanCity!='Jerusalem'), 'Capital']=0

cityPop[which(cityPop$cleanCity %in% "Sri Jayawardenapura Kotte" ), 'cleanCity'] = 'Colombo'

cityPop[which(cityPop$cleanCity %in% "Al-Hudaydahh" ), 'cleanCity'] = 'Al-Hudaydah'

cityPop[which(cityPop$cname %in% "YEMEN" & cityPop$cleanCity!='Sanaa'), 'Capital']=0

cityPop[which(cityPop$cleanCity %in% "Sarajevo (Bosnia)" ), 'cleanCity'] = 'Sarajevo'
cityPop[which(cityPop$cleanCity %in% "Banja Luka (Bosnia)" ), 'cleanCity'] = 'Banja Luka'

# Fixing Philippines
phil2004 <- cityPop[which(cityPop$cname=="PHILIPPINES" & cityPop$YearAlmanac==2004),]
phil2005 <- phil2004
phil2005$YearAlmanac <- 2005
phil2006 <- phil2004
phil2006$YearAlmanac <- 2006
phil2007 <- phil2004
phil2007$YearAlmanac <- 2007
phil2008 <- phil2004
phil2008$YearAlmanac <- 2008
cityPop <- rbind(cityPop,phil2005,phil2006,phil2007,phil2008)

save(cityPop, file=paste0(pathData,"/cityTotPopLatLongv2.rda"))
