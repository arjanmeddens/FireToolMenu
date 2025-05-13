#############################################################################################################################################
# Script Name:  Shiny_DST_NWCASC_250512.r
# Description:  Seclect post-fire management tools
# Author:       Arjan Meddens (& NW CASC project group)
# Date:         May 2025
# Note:		https://shiny.posit.co/r/gallery/
# Note:   https://rstudio.github.io/shinydashboard/get_started.html
# Note:   https://mastering-shiny.org/
# - - - - 
# Based on
# shinydashboard: rstudio.github.io/shinydashboard/
#
# - - - - - - - - - 
# Add - Spatial tool -->  (Study landscape)
# Add - Introduction page & definitions (phase/task/..)
# Add - Figures [from Tools paper]
# Add - Literature on the tools (tool specific articles)
# Add - Literature on decision making
# Add - Literature on Case studies (Meyer et al. GTR - Case studies)
# Hold Team meeting on Tool development  
# - Amanda - [hold user-engaged application refinement 20-30 min meetings]
# Representatives [ 2 x 2 ] 
# Malheur NF   | Job titles
# Dechutes NF  | Job titles
# State forests 
# F&W / TNC / 
# Robichot


#############################################################################################################################################
# Load packages
library(shinydashboard)
library(shinyWidgets)
library(shiny)

# Create path to Github file
repo_owner <- "arjanmeddens"   # Put the owner of the Repo here
repo_name <- "PostFireTools-"      # Put the name of the Repo here
branch <- "main"                 # Put the Repo branch here
repo_file <- "DST_table_v1.csv"        # The name of the .csv file you want

url <- paste0(
  "https://raw.githubusercontent.com/",
  repo_owner, "/", repo_name, "/", branch, "/", repo_file
)
response <- GET(url)
table_dst <- read_csv(content(response, "text"))

# Load tool table
#table_dst = read.csv("~/workspace/R/8_Postfire_regen/1_code/4_DST_app_shiny/DST_table_v1.csv")
phase  = levels(factor(table_dst[,3]))
step = levels(factor(table_dst[,4]))
task   = levels(factor(table_dst[,5]))
statis = levels(factor(table_dst[,6]))
# Replace phase with <- c("Emergency Stabilization","Rehabilitation","Adaptation and Restoration")
overview_txt = c('Climate change is contributing to an increase in wildfire activity in the western United States, including the Blue Mountains and Eastern Cascades Slopes and Foothills of the Inland Northwest. Some forest ecosystems are changing from forest to non-forest because of severe fires, a hot and dry climate, and/or the absence of a viable seed source. On sites impacted by wildfire, managers are tasked with maintaining timber value, wildlife, recreation, and the human environment important to society. However, managers contend with multiple constraints in forest restoration.')


# Shiny App code
ui <- dashboardPage(
  dashboardHeader(title = "Post-fire Mngt Tools"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "Overview"),
      menuItem("Menu of Tools", tabName = "Selecttool"),
      menuItem("Literature", tabName = "Literature"),
      menuItem("Contact", tabName = "Contact"),
      menuItem("Further information",
               menuSubItem("Links", tabName = "Links"),
               menuSubItem("Photo gallery", tabName = "Photo gallery"),
               menuSubItem("Partners", tabName = "Partners"))
    )
  ),
  
  ## Body content
  dashboardBody(
    tabItems(
      
      ## (A) OVERVIEW 
      tabItem(
        tabName = "Overview",
        
        fluidPage(
          HTML('<style>
           .box {
            border: 1px solid lightgrey;
            padding: 8px;
           }
            </style>'),br(),
          
          fluidRow(
            titlePanel("Overview of the Menu of Post-Fire Management Tools"),
            p("Explore different post-fire management tools. First read the description here and on the 'Menu of Tools' tab you can explore various tool."),
            
            column(12,box(title ='Overview',overview_txt,br(),width=12)),
            column(12,box(title ='Definitions',p("Phase = Phase"), p("Step = Step"),width=12)),
            
            column((img(src="Compass_v1.png",width=450)),width=12,title="Post-fire Management Compass (Steen-Adams et al. in prep"),
            column((img(src="Tools_v1.png",width=850)),width=12,title="Post-fire Management Compass (Steen-Adams et al. in prep")
           
           ) # FLUIDROW          
        ) # FLUIDPAGE
      ),  # TABITEM
    
      
      
      ## (B) Tool selector
      tabItem(
        tabName = "Selecttool",
        fluidPage(
          fluidRow(
          titlePanel("Menu of Post-Fire Management Tools"),
          p("Explore various tools by using the drop down menus."),
        
        pickerInput("dropdown1", "Phase (Select your descision phase):", choices = phase, multiple = T),
        uiOutput("dropdown2"),
        uiOutput("dropdown3")
          ) # FLUIDROW  
        )   # FLUIDPAGE
      ),    # TABITEM
      
      ## (C) Literature
      tabItem(
        tabName = "Literature",
        fluidRow(
          box(
            h2("Available literature on post-fire tools")
            ),
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        ) # FLUIDROW
      ) # TABITEM
    )  # TABITEMS   
  )    # dashboardBody
)     # dashboardPage

server <- shinyServer(function(input, output, session) { 
#server <- function(input, output, session) {

  ## Dropdown 2 -- Reaction values function 
  values.func2 <- reactive({
    req(input$dropdown1)
    if (length(input$dropdown1) == 1) {
      if (input$dropdown1 == "x") {
        c("Assess","Engage","Plan","Implement","Monitor & Evaluate","All")
      }
      else {
        c("Assess","Engage","Plan","Implement","Monitor & Evaluate","All")
      }
    }
    else {
      c("Assess","Engage","Plan","Implement","Monitor & Evaluate","All")
    }
    
  })

  ## Dropdown 3 -- Reaction values function 
  values.func3 <- reactive({
    req(input$dropdown2)
    if (length(input$dropdown1) == 1) {
      # testing 
      #tmp1_index  = which(table_dst[,3] ==  "Restore & Adapt")
      #tmp_dst  = table_dst[tmp1_index,]
      #tmp2_index  = which(tmp_dst[,4] ==  "Plan")
      #tmp_dst2 = tmp_dst[tmp2_index,]
      if(input$dropdown2 == c("All")) {
        tmp1_index  = which(table_dst[,3] ==  input$dropdown1)
        tmp_dst2 = table_dst[tmp1_index,]
        return(c(tmp_dst2[,1]))
      } else {
         tmp1_index  = which(table_dst[,3] ==  input$dropdown1)
         tmp_dst = table_dst[tmp1_index,]
         tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2)
         tmp_dst2 = tmp_dst[tmp2_index,]
         return(c(tmp_dst2[,1]))
      }
    }
    if (length(input$dropdown1) == 2) {
      tmp1_index  = which(table_dst[,3] ==  input$dropdown1[1] | table_dst[,3] ==  input$dropdown1[2])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      return(c(tmp_dst2[,1]))
      
    }
    if (length(input$dropdown1) == 3) {
      tmp1_index  = which(table_dst[,3] ==  input$dropdown1[1] | table_dst[,3] ==  input$dropdown1[2] | table_dst[,3] ==  input$dropdown1[3])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      return(c(tmp_dst2[,1]))
      
    }
  })
  
  ## Reactive Dropdown 2
  output$dropdown2 <- renderUI({
    pickerInput("dropdown2", "Step (Select your descision Step):", choices = values.func2())
  })  
  
  ## Reactive Dropdown 3
  output$dropdown3 <- renderUI({
    pickerInput("dropdown3", "Tool (select tool for more Information):", choices = values.func3())
  })
  
  ## Reactive Dropdown 4
  ##output$dropdown4 <- renderUI({
  ##  pickerInput("dropdown3", "Tools:", choices = values.func3())
  ##})

  observe({
    updateSelectInput(session, "showDrop", label = "Select", choices =   values.func2())
    updateSelectInput(session, "showDrop", label = "Select", choices =   values.func3())
  })
})

shinyApp(ui, server)
