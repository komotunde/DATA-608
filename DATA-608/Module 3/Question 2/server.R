#Oluwakemi Omotunde
#DATA 608 
#HW 3 
#Question 2

#Often you are asked whether particular States are improving their mortality rates (per cause)
#faster than, or slower than, the national average. Create a visualization that lets your clients
#see this for themselves for one cause of death at the time. Keep in mind that the national
#average should be weighted by the national population.

library(shiny)
library(plyr)
suppressPackageStartupMessages(library(googleVis))

mort.rate <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv")

#I want to subset our data for only the columns we need to work with 

mort.rate <- mort.rate[c("ICD.Chapter", "State", "Year", "Deaths", "Population", "Crude.Rate")]

mort.year <- unique(mort.rate$Year)

shinyServer(function(input, output) {
  
    cause.input <- reactive({
    
    paste(input$state, "-", input$cause, "vs.", "National Ave.", "-", input$cause)
    
  })
  
  output$selected_cause <- renderText({
    
    cause.input()
    
  })  
  
  nat.state <- reactive({
    
    nat.rate <- ddply(
      mort.rate[mort.rate$ICD.Chapter == input$cause, ],
      "Year",
      
      function(x) sum(as.numeric(x$Deaths))/sum(as.numeric(x$Population)))    
    
    names(nat.rate)[2] <- paste("National Ave.", "-", input$cause)
    
    natmort.year <- data.frame(mort.year)
    
    names(natmort.year)[1] <- paste("Year")
    
    nat.rate <- merge(nat.rate, natmort.year, all.y = TRUE)
                                     
    
    state.rate <- mort.rate[mort.rate$State == input$state & mort.rate$ICD.Chapter == input$cause,
                                             c("Year", "Crude.Rate")]
    
    names(state.rate)[2] <- paste(input$state, "-", input$cause)
    
    statemort.year <- data.frame(mort.year)
    
    names(statemort.year)[1] <- paste("Year")
    
    state.rate <- merge(state.rate, statemort.year,all.y = TRUE)
                                  
    
    cbind(mort.year, nat.rate[2], state.rate[2]/100000)
    
  })
  
  output$view <- renderGvis({
    
    gvisLineChart(nat.state(), 
                  options = list(legend = "{position: 'right'}",
                                 vAxis = "{title: 'Crude Mortality Rate'}",
                                 hAxis = "{title: 'Year'}"))
    
  })
  
})
