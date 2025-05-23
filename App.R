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
# Check --> https://shiny.posit.co/r/articles/build/dynamic-ui/
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
linebreaks <- function(n){HTML(strrep(br(), n))}

# Load tool table
#table_dst = read.csv("~/workspace/R/8_Postfire_regen/1_code/6_PostFireTools_App_V1/DST_table_v4.csv")
library(httr)
# Createhttr# Create path to Github file
repo_owner <- "arjanmeddens"   # Put the owner of the Repo here
repo_name <- "FireToolMenu"      # Put the name of the Repo here
branch <- "main"                 # Put the Repo branch here
repo_file <- "DST_table_v4.csv"        # The name of the .csv file you want

url <- paste0(
  "https://raw.githubusercontent.com/",
  repo_owner, "/", repo_name, "/", branch, "/", repo_file
)
table_dst <- read.csv(file=url)

phase  = levels(factor(table_dst[,3]))
step = levels(factor(table_dst[,4]))
task   = levels(factor(table_dst[,5]))
statis = levels(factor(table_dst[,6]))
# Replace phase with <- c("Emergency Stabilization","Rehabilitation & Recovery","Restoration & Adaptation")
overview_txt = c('  (a)	Decision phase: Emergency stabilization, rehabilitation, and climate adaptive phase. (b)	Decision Step, including assess, plan, implement and monitor, and evaluate. This compass can inform resource managers about the availability of diverse types of decision support tools and orient resource managers to the use of available tools.')
head(table_dst)
###--------------------------------------------------------###
## UI
###--------------------------------------------------------###
# Shiny App code
ui <- dashboardPage(
  dashboardHeader(title = "Post-fire Mngt Tools"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "Overview"),
      menuItem("Menu of Tools", tabName = "Selecttool"),
      menuItem("Literature", tabName = "Literature"),
      menuItem("Contact", tabName = "Contact")
    )
  ),
  
  ## Body content
  dashboardBody(
    tabItems(
      
      ##################################### 
      ## (A) OVERVIEW (Page 1)
      ##################################### 
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
            column(9,titlePanel("FireToolMenu: Overview"),
              p(linebreaks(1)),
              p("This site will enable you to explore different post-fire management tools. See the 'Menu of Tools' tab to explore various post-fire management tools.",style = "font-family: 'arial'; font-si48pt",br()),),
              p(linebreaks(1)),
            column(3,img(src="FireToolMenu_logo1.png",width=200),title=""),
              p(""),
              p(""),
            column(12,box(title ='Overview',
              p("In western U.S. forests, the increasing frequency of large, severe wildfires in combination with climate stressors are contributing to projected limitations on reforestation success. Consequent outcomes include vulnerability to a shift from forest to non-forest landcover, a loss in ecosystem resilience, and threats to ecosystem services. The pre-fire forest may not return. In response to the need for improved decision support, an abundance of new decision support tools have recently become available.",style = "font-family: 'arial'; font-si24pt",br(),width=12),
              p("Here we provide a framework (a Decision Support Compass) and a Menu of Post-Fire Tools (FireToolMenu) to assist managers in navigating Desciosion Support Tools (DST) complexity, and to identify appropriate decision support tools for postfire management. We reviewed DST for postfire management, generated through an iterative, bottom-up, manager-engaged method. We categorized the tools according to the:",style = "font-family: 'arial'; font-si24pt",br(),width=12),
              p("(a)	Decision phase: 1: Emergency Stabilization, 2: Rehabilitation, 3: Restoration and Adaptation.",style = "font-family: 'arial'; font-si24pt",br(),width=12),
              p("(b)	Decision Step, including 1: Assess, 2: Engage, 3: Plan, 4: Implement, 5: Monitor & Evaluate, 6: All.",style = "font-family: 'arial'; font-si48pt",br(),width=12),
              p("This compass can inform resource managers about the availability of diverse types of decision support tools and orient resource managers to the use of available tools.",style = "font-family: 'arial'; font-si24pt",br()),width=12)),
            column(12,box(title ='Definitions',
              p("Phase = The discrete periods of rehabilitation after wildfire (1:-Emergency Stabilization Phase, 2:-Rehabilitation Phase, 3:-Restoration and Adaptation Phase",style = "font-family: 'arial'; font-si48pt",br()), 
              p("Step = Post-fire descision-making processes/goals (6 steps: 1: Assess, 2: Engage, 3: Plan, 4: Implement, 5: Monitor & Evaluate, 6: All)",style = "font-family: 'arial'; font-si48pt",br()),
              p("Tasks = Specific activities of postfire decision-making (13 Tasks that fall under a specific Step (See Figure 1))",style = "font-family: 'arial'; font-si48pt",br()),
              p("DST = Desiscion Support Tool",style = "font-family: 'arial'; font-si48pt",br()),
              p(),width=12)),
            column(12,box(img(src="Tools_v1.png",width=850),
                        title="Figure 1: Framework for Menu of Tools for Postfire Management, featuring decision stages and tasks",width=12)),
            #column(12,box(title ='Compass',
            #              p("Tasks = Specific activities of postfire decision-making (13 Tasks that fall under a specific Step (See Figure 1))"),
            #              p(),width=12)),
            column(12,box(img(src="Compass_v1.png",width=550),
                          title="Post-fire Management Compass (Steen-Adams et al. in prep)",width=12)),
            p(""),
            p(""),
            p("Last updated: May, 2025")
            
           
           ) # FLUIDROW          
        ) # FLUIDPAGE
      ),  # TABITEM
      #----- End (A) -------
      #---------------------
    
      
      ##################################### 
      ## (B) Tool selector (Page 2)
      ##################################### 
      tabItem(
        tabName = "Selecttool",
        fluidPage(
          HTML('<style>
           .box {
            border: 1px solid lightgrey;
            padding: 8px;
           }
            </style>'),br(),
          
          fluidRow(
            column(9,
              titlePanel("FireToolMenu: Tool selector"),
              p(linebreaks(1)),
              p("Explore various tools by using the drop down menus below. Select your Desicion Phase and Desicion Step narrow down the eventual tools you might be interested in. When you select the tool, you can inspect the output to learn more about the tool. You can use the compass on the right to guide to the appropriate tool.",style = "font-family: 'arial'; font-si24pt",br())),
              p(linebreaks(1)),
            column(3,img(src="FireToolMenu_logo1.png",width=200),title=""),
            p(linebreaks(2)),
            column(4,pickerInput("dropdown1", "Phase (Select your descision phase):", choices = phase, multiple = T), #-- PHASE --#
              p(linebreaks(3)),
              uiOutput("dropdown2"), #-- STEP --#
              p(linebreaks(3)),
              uiOutput("dropdown3"), #-- TOOL --#
              p(linebreaks(3))),
            column(8,box(img(src="Compass_v1.png",width=450),
                         title="Post-fire Management Compass (Steen-Adams et al. in prep)",width=12)),
            p("---------------------------------------------------------------------------------------------"),
            p("OUTPUT:"),
            p("---------------------------------------------------------------------------------------------"),
            column(12,box(textOutput("selected_var1"),title="Choice:",width=12)),
            #column(12,box(textOutput("selected_var1"),title="Choice:",width=12)),
            column(12,box(textOutput("selected_var4"),title="Tool Description",width=12)),
            column(12,box(textOutput("selected_var5"),title="Website of Tool",width=12)),
            column(12,box(textOutput("selected_var6"),title="Tool Citation",width=12))
   
          ) # FLUIDROW  
        )   # FLUIDPAGE
      ),    # TABITEM
      #----- End (B) -------
      #---------------------
      
      ##################################### 
      ## (C) Literature (Page 3)
      ##################################### 
      tabItem(
        tabName = "Literature",
        fluidRow(
          box(h2("Peer-reviewed papers:"),
              p(linebreaks(2)),
              p("Research article on tree establishment in the Blue Mountains (Andrus et. al. 2023)"),
              p("Andrus, R.A., Droske, C.A., Franz, M.C., Hudak, A.T., Lentile, L.B., Lewis, S.A., Morgan, P., Robichaud, P.R., & Meddens, A.J. (2022). Spatial and temporal drivers of post-fire tree establishment and height growth in a managed forest landscape. Fire Ecology, 18, 29."),
              p(linebreaks(2)),
              p("Research article on spectral recovery in relation to forest recovery post-fire (Celebrezze et al. 2024)"),
              p("Celebrezze, J.V., Franz, M.C., Andrus, R.A., Stahl, A.T., Steen-Adams, M., & Meddens, A.J. (2024). A fast spectral recovery does not necessarily indicate post-fire forest recovery. Fire Ecology, 20, 54."),
              p(linebreaks(2)),style = "font-family: 'arial'; font-si24pt",br(),width=12)
        #----- End (C) -------
        #---------------------
        ) # FLUIDROW  

    ),    # TABITEM
    #----- End (B) -------
    #---------------------
    
        ##################################### 
        ## (D) Contact (Page 4)
        ##################################### 
        tabItem(
          tabName = "Contact",
          fluidRow(
            box(h2("Team and Contact Information"),style = "font-family: 'arial'; font-si24pt",br(),width=12),
            column(12,box(title ='Website and Further Information',
                          p("Check out our project website:"),
                          p("- https://environment.wsu.edu/post-fire-management/sample-page/partners/"),
                          p(linebreaks(2)),
                          p("Contact us if you have a new tool that should be included into the FireToolMenu."),
                          p("Send an email to: arjan.meddens@wsu.edu or m.steen-adams@wsu.edu"),
                          p(linebreaks(2)),style = "font-family: 'arial'; font-si24pt",br(),width=12)),
            column(12,box(title ='Academic Team (WSU)',
                p("Principal Investigators:"),
                p("- Michelle Steen-Adams, m.steen-adams@wsu.edu"),
                p("- Arjan Meddens, arjan.meddens@wsu.edu"),
                p(linebreaks(2)),
                p("Co-Investigators"),
                p("- Amanda Stahl, atstahl@wsu.edu"),
                p("- Robert Andrus, robert.andrus@wsu.edu"),
                p(linebreaks(2)),
                p("Researchers"),
                p("- Joe Celebrezze, joseph.celebrezze@wsu.edu"),
                p("- Madeline Franz, madeline.franz@wsu.edu"),
                p(linebreaks(2)),style = "font-family: 'arial'; font-si24pt",br(),width=12))
                
              #",style = "font-family: 'arial'; font-si24pt",br(),width=12),
         
           
              
            #----- End (D) -------
            #---------------------
            
        ) # FLUIDROW
      ) # TABITEM
    )  # TABITEMS   
  
  )    # dashboardBody
)   # UI # dashboardPage

###--------------------------------------------------------###
## SERVER
###--------------------------------------------------------###
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

  ## Dropdown 3 -- Reaction values function # Tool name
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
        return(c(tmp_dst2[,2]))
      } else {
        tmp1_index  = which(table_dst[,3] ==  input$dropdown1)
        tmp_dst = table_dst[tmp1_index,]
        tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2)
        tmp_dst2 = tmp_dst[tmp2_index,]
        return(c(tmp_dst2[,2]))
      }
    }
    if (length(input$dropdown1) == 2) {
      tmp1_index  = which(table_dst[,3] ==  input$dropdown1[1] | table_dst[,3] ==  input$dropdown1[2])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      return(c(tmp_dst2[,2]))
      
    }
    if (length(input$dropdown1) == 3) {
      tmp1_index  = which(table_dst[,3] ==  input$dropdown1[1] | table_dst[,3] ==  input$dropdown1[2] | table_dst[,3] ==  input$dropdown1[3])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,4] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      return(c(tmp_dst2[,2]))
      
    }
  })
  
  
  #----------------------------------------------------------------------------------------------
  ## Reactive Dropdown 2 # STEP out
  output$dropdown2 <- renderUI({
    #HTML(paste0("Output 1 here", collapse = "<br>"))
    pickerInput("dropdown2", "Step (Select your descision Step):", choices = values.func2(), options = pickerOptions(
      actionsBox = TRUE,title = "Please select a Descision Step",selectedTextFormat = 'static'))
  })
  
  ## Reactive Dropdown 3 # TASK out
  output$dropdown3 <- renderUI({
    pickerInput("dropdown3", "Tool (select tool for more Information):", choices = values.func3(),options = pickerOptions(
      actionsBox = TRUE,title = "Please select a Tool",selectedTextFormat = 'static'))
  })
  
  ## Reactive Output text 1
  output$selected_var1 <- renderText({
    paste("Phase:", input$dropdown1,", Step: ",input$dropdown2,", Tool: ",input$dropdown3)
  })
#  ## Reactive Output text 2
#  output$selected_var2 <- renderText({
#    paste(input$dropdown2,"Choice")
#  })
#  ## Reactive Output text 3
#  output$selected_var3 <- renderText({
#    paste(input$dropdown3,"Choice")
#  })
  
  ## Reactive Output text 4 -- Tool Description
  output$selected_var4 <- renderText({
    paste((table_dst[c(which(table_dst[,2] == input$dropdown3)),7]))
  })

  ## Reactive Output text 5 -- Tool website
  output$selected_var5 <- renderText({
    paste((table_dst[c(which(table_dst[,2] == input$dropdown3)),8]))
  })
  
  ## Reactive Output text 6 -- Tool Citation
  output$selected_var6 <- renderText({
    paste((table_dst[c(which(table_dst[,2] == input$dropdown3)),9]))
  })
  
  
  #- Testing
  #dropdown3 = c("A guidebook to spatial datasets for conservation planning under climate change in the Pacific Northwest")
  #table_dst[c(which(table_dst[,1] == dropdown3)),8]
  #paste((table_dst[c(which(table_dst[,1] == dropdown3)),8]),"Choice")
  
  #- Update pickerboxes instantaneously
  observe({
    updateSelectInput(session, "showDrop", label = "Select", choices = values.func2())
    updateSelectInput(session, "showDrop", label = "Select", choices = values.func3())
  })

})

###--------------------------------------------------------###
shinyApp(ui, server)

###--------------------------------------------------------###
## END
###--------------------------------------------------------###
