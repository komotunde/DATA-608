#Oluwakemi Omotunde
#DATA 608 
#HW 3

#As a researcher, you frequently compare mortality rates from particular causes across
#different States. You need a visualization that will let you see (for 2010 only) the crude
#mortality rate, across all States, from one cause (for example, Neoplasms, which are
#effectively cancers). Create a visualization that allows you to rank States by crude mortality
#for each cause of death.

library(shiny)
library(googleVis)

mort.rate <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv")
head(mort.rate)

#Since we are only interested in 2010, we will subset our data for YEAR == 2010.

mort.2010 <- subset(mort.rate, Year == 2010)

mort.2010 <- mort.2010[c("ICD.Chapter", "State", "Crude.Rate")]

head(mort.2010)

#Now to order our data by cause and crude rate from largest to smallest and vice versa for viewing. 

mort2010.descend <- mort.2010[order(mort.2010$ICD.Chapter, -mort.2010$Crude.Rate), ] 

mort2010.ascend <- mort.2010[order(mort.2010$ICD.Chapter, mort.2010$Crude.Rate), ]

shinyServer(function(input, output) {  
  
  showcause.input <- reactive({paste(input$cause)})
  
  cause.input <- reactive({switch(input$order,
           "alpha_state" = mort.2010[mort.2010$ICD.Chapter == input$cause, c("State", "Crude.Rate")],
           
           "descending" = mort2010.descend[mort2010.descend$ICD.Chapter == input$cause, c("State", "Crude.Rate")],
           
           "ascending" = mort2010.ascend[mort2010.ascend$ICD.Chapter == input$cause, c("State", "Crude.Rate")]) })
  
  output$selected.cause <- renderText({showcause.input()})   
  
  #output$view <- renderGvis({gvisBubbleChart(cause_input(),idvar = input$cause, 
                                               #xvar = "Crude.Rate",
                                               #yvar = "State")
  output$view <- renderGvis({gvisBarChart(cause.input(), options = list(height = 1500, 
                                             chartArea = "{top: 10}",
                                             vAxis = "{title: 'State'}",
                                             hAxis = "{title: 'Crude Mortality Rate'}"))
  
    
  })
  

})
#I initially tried to do a Bubble Chart but thought better of it when it didn't work like I wanted. I commented it out.