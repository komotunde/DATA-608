#Oluwakemi Omotunde
#DATA 608 
#Module 2

#This is the code I used to combine the five different csv files for Module 2

BK.data <- read.csv("https://github.com/komotunde/DATA-608/blob/master/BK.csv?raw=true")
BX.data <- read.csv("https://github.com/komotunde/DATA-608/blob/master/BX.csv?raw=true")
MN.data <- read.csv("https://github.com/komotunde/DATA-608/blob/master/MN.csv?raw=true")
QN.data <- read.csv("https://github.com/komotunde/DATA-608/blob/master/QN.csv?raw=true")
SI.data <- read.csv("https://github.com/komotunde/DATA-608/blob/master/SI.csv?raw=true")

NYC.data <- rbind(BK.data, BX.data, MN.data, QN.data, SI.data)

head(NYC.data)
tail(NYC.data)

write.csv(NYC.data, file = "all_PLUTO_Data.csv")
