require(foreign)
library(mgsub)
library(dplyr)
### India  data 
dat.Ind<-read.spss("Data/INDO-DANISH & IAEA-B12_n=248_Pradeep.sav",
                       use.value.labels = T,to.data.frame = T)

dat.Ind<-dat.Ind[,c(1,3,11:16)] ## retain only HOMA B and HOMA-S data 

colnames(dat.Ind)[1]<-"ID"

dat.Ind$cohort<-rep("India",nrow(dat.Ind))

dat.IndLong<-reshape(dat.Ind, idvar = "ID", 
                     varying = list(c(3:5),c(6:8)), direction="long",
                     v.names = c('HOMAB','HOMAS'),sep="_")

### Danish Data 
dat.Danish<-read.spss("Data/LIP data for Pradeep n=266.sav",
                      use.value.labels = T,to.data.frame = T)

dat.Danish<-dat.Danish[,c(1,2,5,6,9,10,13,14)]

dat.Danish$cohort<-rep("Europe",nrow(dat.Danish))

dat.DanishLong<-reshape(dat.Danish, idvar = "ID", 
                        varying = list(c(3,5,7),c(4,6,8)), direction="long",
                        v.names = c('HOMAB','HOMAS'),sep="_")

### USA data (Pat catlano)

dat.USA<-read.spss("Data/Catalano Data.sav",to.data.frame = T,use.value.labels = T)

dat.USA<-dat.USA[,c(2:9)]

dat.USA$cohort<-rep("USA",nrow(dat.USA))

dat.USALong<-reshape(dat.USA, idvar = "ID", 
                        varying = list(c(3,5,7),c(4,6,8)), direction="long",
                        v.names = c('HOMAB','HOMAS'),sep="_")

dat.USALong$time<-mgsub(as.character(dat.USALong$time),c("1","2","3"),
                        c("Pre-pregnancy","Early-Pregnancy","Late-pregnancy"))

### Fit for 2 (Netherlands data)
dat.Ned<-read.spss("Data/FITFOR2_study_Pradeep.sav",to.data.frame = T,use.value.labels = T)

dat.Ned<-dat.Ned[,c(1,14,8:13)]

colnames(dat.Ned)[1]<-"ID"

dat.Ned$cohort<-rep("Europe",nrow(dat.Ned))

dat.NedLong<-reshape(dat.Ned, idvar = "ID", 
                     varying = list(c(3:5),c(6:8)), direction="long",
                     v.names = c('HOMAB','HOMAS'),sep="_")

### Mexican data
dat.Mex<-read.spss("Data/Mexican Study for Pradeep.sav",to.data.frame = T,use.value.labels = T)

dat.Mex<-dat.Mex[,c(1,14,4,5,8,9,12,13)]

colnames(dat.Mex)[1]<-"ID"

dat.Mex$cohort<-rep("Mexico",nrow(dat.Mex))

dat.MexLong<-reshape(dat.Mex, idvar = "ID", 
                     varying = list(c(3,5,7),c(4,6,8)), direction="long",
                     v.names = c('HOMAB','HOMAS'),sep="_")

### All data (5 Populations) combined together 

dat.AllLong<-rbind(dat.IndLong,dat.DanishLong,dat.NedLong,dat.MexLong,dat.USALong)

dat.AllLong$time<-mgsub(dat.AllLong$time,c("1","2","3"),
                        c("Early-Pregnancy","Mid-pregnancy","Late-pregnancy"))

colnames(dat.AllLong)[4]<-"PregnancyVisits"

dat.AllLong$PregnancyVisits<-factor(dat.AllLong$PregnancyVisits,
                                    levels = c("Pre-pregnancy","Early-Pregnancy",
                                               "Mid-pregnancy","Late-pregnancy"))


### Dali data (Europe)

dat.Dali<-read.spss("./Data/DALI_Study_ n=526_Pradeep.sav",to.data.frame = T,use.value.labels = T)

dat.Dali<-na.omit(dat.Dali)

dat.Dali<-na.omit(dat.Dali)

dat.Dali$st_preg<-NA

dat.Dali<-dat.Dali[,c(1,15,4,5,8,9,12,13)]

colnames(dat.Dali)[1]<-"ID"

#dat.Dali$cohort<-rep("DALI",nrow(dat.Dali))

dat.Dali$cohort<-rep("Europe",nrow(dat.Dali))

dat.DaliLong<-reshape(dat.Dali, idvar = "ID", 
                     varying = list(c(3,5,7),c(4,6,8)), direction="long",
                     v.names = c('HOMAB','HOMAS'),sep="_")

colnames(dat.DaliLong)[4]<-"PregnancyVisits"

dat.DaliLong$PregnancyVisits<-mgsub(dat.DaliLong$PregnancyVisits,c("1","2","3"),
                        c("Early-Pregnancy","Mid-pregnancy","Late-pregnancy"))
### All data combined 

dat.AllLong<-rbind(dat.AllLong,dat.DaliLong)

### data sets of mean value for plot 
#options(pillar.sigfig=4)

dat.plot<-data.frame(dat.AllLong %>% ## data.frame prints all the decimal values, tibble prints only 3 by default
                       group_by(cohort, PregnancyVisits) %>%
                       summarise_at(.vars = vars(HOMAB,HOMAS),
                                    .funs = c(mean="mean")))


dat.plot$cohort<-factor(dat.plot$cohort)



