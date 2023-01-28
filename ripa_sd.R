library("tidyverse")

## uploading database of all traffic stops
ripa_master <- read_csv("~/documents/U-T/sd_police/ripa_stops_datasd.csv") 

## uploading race data that corresponds to each stop
ripa_race <- read_csv("~/documents/U-T/sd_police/ripa_race_datasd (1).csv")

## merging the two
ripa_new <- merge(x = ripa_master, y = ripa_race, by = "stop_id") %>%
  view()

## ordering police beats by how many stops there were in each one
arrange(as.data.frame(table(ripa_new$beat_name)), desc(Freq))

## the different races that are included in the data
as.data.frame(table(ripa_new$race))

## function that calculates what percentage of stops a given race accounted for in a select police beat 
sdpd_stops <- function(x){
ripa_beat <- ripa_new[ripa_new$beat_name == "Carmel Valley 934",] 
beat_data <- arrange(as.data.frame(table(ripa_beat$race)), desc(Freq))
stops <- sum(beat_data$Freq)
race <- beat_data[beat_data$Var1 == "Black/African American",]
print((race$Freq)/stops)*100
}

sdpd_stops(ripa_new)
