##-------------------------##
##------ Halibut SAA ------##
##-------------------------##
##--Survey data 1963-2013--##
##-------------------------##
##---Start date 5/2/2014---##
##-------------------------##

##-----------------------------------------------------------------------------------------##
##  Variable names and explanations 
##-----------------------------------------------------------------------------------------##
## 'survey': the dataframe that includes all IPHC surveys from 1963 through 2013
## 'year': year of survey
## 'length': the total length of fish
## 's.age': surface age
## 'bb.age': break and bake age
## 'lat': the mid-latitude for the station
## 'lon': the mid-longitude for the station
## 'reg': the IPHC regulatory area (e.g. 2A, 2B, etc.)
## 'stat': the IPHC statistical area (Note: most of three digit codes, but they are six digit codes in the Bering Sea)
## 'sex': categorical variable for sex (either M or F)
## 'date': the date of sampling (in the form 5/2/2014)
## 'julian': Julian day of sampling
## 'gear': the gear type used for sampling
## 'maturity': maturity status of the individual
##-----------------------------------------------------------------------------------------##

setwd("~/GitHub/HalibutSAA")

survey <- read.csv("~/GitHub/HalibutSAA/survey.csv")


require(ggplot2)
require(lattice)


library(plyr)
library(reshape2)
survey <- subset(survey, sex!="U")
df <- subset(survey, s.age== 7:18)
melted <- melt(df, id.vars=c("year", "reg", "sex", "s.age", "stat"), measure.vars="length",variable.name="length")

summary <- ddply(melted, c("year", "reg", "stat", "sex", "s.age", "length"), summarize,
      mean = mean(value), sd = sd(value), n = length(value), se = sd(value)/sqrt(length(value)))

summary.reg <- ddply(melted, c("year", "reg", "sex", "s.age"), summarize,
                     mean = mean(value), sd = sd(value), n = length(value), se = sd(value)/sqrt(length(value)))

write.table(summary, file= "summary.csv", sep=",", na="0")

