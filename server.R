#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot and find the slope/intercept of selected points
shinyServer(function(input, output) {
   
  set.seed(100)
  data_set <- reactive({
    data.frame(cbind(xVal = runif(input$n, input$min, input$max),yVal = runif(input$n, input$min, input$max)))
  })
  model<-reactive({
      brushed_data<-brushedPoints(data_set(), input$brush1, xvar = "xVal", yvar="yVal")
      if(nrow(brushed_data)<2){
        return(NULL)
      }
      lm(yVal~ xVal, data= brushed_data)
  })
  avg_x<-reactive({
    brushed_data<-brushedPoints(data_set(), input$brush1, xvar = "xVal", yvar="yVal")
    if(nrow(brushed_data)<2){
      return(NULL)
    }
    mean(brushed_data$xVal)
  })
  avg_y<-reactive({
    brushed_data<-brushedPoints(data_set(), input$brush1, xvar = "xVal", yvar="yVal")
    if(nrow(brushed_data)<2){
      return(NULL)
    }
    mean(brushed_data$yVal)
  })
  
  
  output$slope_out<- renderText({
      if(is.null(model())){
        "No Model Found"
      } else {
        model()[[1]][2]
      }
  })
  output$inter_out<- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      model()[[1]][1]
    }
  })
  output$avg_x<- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      avg_x()
    }
  })
  output$avg_y<- renderText({
    if(is.null(model())){
      "No Model Found"
    } else {
      avg_y()
    }
  })
  output$plot1 <- renderPlot({

    plot(data_set()$xVal,data_set()$yVal, xlab = "", ylab = "")
    if(!is.null(model())){
      abline(model(), col = "green", lwd=2)
    }
  })
})
