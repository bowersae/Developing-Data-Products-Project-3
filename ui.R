#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a plot and allows for user selections on the chart
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Random Data Slope and Intercept"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       h1("Input Panel"),
       h3("Select the data range and number of values for the graph."),
       numericInput("min","Enter the minimum value",value = 50, min=1, max=1000, step = 1),
       numericInput("max","Enter the maximum value",value = 500, min=1, max=1000, step = 1),
       sliderInput("n",
                   "Enter the number of points to plot:",
                   min = 100,
                   max = 1000,
                   value = 500,
                   step = 10),

       h1("Output Panel"),
       h3("Slope and Intercept of selected values within the graph"),
       h4("Slope"),
       textOutput("slope_out"),
       h4("Intercept"),
       textOutput("inter_out"),
       h4("Average X value"),
       textOutput("avg_x"),
       h4("Average Y value"),
       textOutput("avg_y")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h1("Use your mouse to select points on the graph and view their slope and intercept."),
      plotOutput("plot1", brush = brushOpts(id = "brush1"))
    )
  )
))
