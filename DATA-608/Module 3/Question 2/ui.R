#Oluwakemi Omotunde
#DATA 608 
#HW 3 
#Question 2

#Often you are asked whether particular States are improving their mortality rates (per cause)
#faster than, or slower than, the national average. Create a visualization that lets your clients
#see this for themselves for one cause of death at the time. Keep in mind that the national
#average should be weighted by the national population.

library(shiny)

mort.rate <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv")

COD <- unique(mort.rate$ICD.Chapter)

states <- unique(mort.rate$State)

shinyUI(fluidPage(titlePanel("Average Mortality Rate: State vs. Natational"), sidebarLayout(
  sidebarPanel(
  selectInput("cause", "CAUSE: ", COD),
  selectInput("state", "State: ", states)),

mainPanel(h4(textOutput("selected.cause")),
             htmlOutput("view")))))

