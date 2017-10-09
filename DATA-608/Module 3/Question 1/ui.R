#Oluwakemi Omotunde
#DATA 608 
#HW 3

#As a researcher, you frequently compare mortality rates from particular causes across
#different States. You need a visualization that will let you see (for 2010 only) the crude
#mortality rate, across all States, from one cause (for example, Neoplasms, which are
#effectively cancers). Create a visualization that allows you to rank States by crude mortality
#for each cause of death.

library(shiny)


COD <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv")

COD <- subset(COD, Year == 2010)
COD <- COD[c("ICD.Chapter")]

COD <- unique(COD)

shinyUI(fluidPage(titlePanel("2010 CRUDE MORTALITY RATE IN U.S"), sidebarLayout(sidebarPanel(
  selectInput("cause", "CAUSE: ", COD),radioButtons("order", "Order: ", c("Alphabetical - State" = "alpha_state",
                                                                          "Crude Mortality Rate - Descending" = "descending",
                                                                          "Crude Mortality Rate - Ascending" = "ascending"))
), mainPanel(h4(textOutput("selected_cause")),
             htmlOutput("view")))))

