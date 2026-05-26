#############################################################################################################################################
# Script Name:  app.r
# Description:  Select post-fire management tools
# Author:       Arjan Meddens (& NW CASC project group)
# Date:         Jun 2026
# R-version: 4.5-arm64 (on Mac)
# Note:		Note that the CSV file has comma's in the citations and Excel sometime reads these as delim. 
# Note:		https://shiny.posit.co/r/gallery/
# Note:   https://rstudio.github.io/shinydashboard/get_started.html
# Note:   https://mastering-shiny.org/
# Note: Images (.png) do not show up when running the code line by line, but show up when running the "Run App/Reload App" 
#       button on the top.   
# - - - - 
# Based on
# shinydashboard: rstudio.github.io/shinydashboard/
#
#############################################################################################################################################
# LOAD PACKAGES
options(repos = c(CRAN = "https://cloud.r-project.org/"))
remotes::install_github("dreamRs/shinyWidgets",force = TRUE)
install.packages("shiny",repos = c(CRAN = "https://cloud.r-project.org/"))
install.packages("shinyWidgets")
 library(shinydashboard)
 library(shinyWidgets)
 library(shiny)

require(shinydashboard)

print("check for testing")

# Define list of required packages:
#list_of_packages <- c("shinydashboard", "shinyWidgets", "shiny", "htmltools", "DT")
# Check for packages and install if needed:
new.packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])]
if(length(new.packages) > 0) install.packages(new.packages,repos = "https://cran.rstudio.com/")

# load all packages
vapply(list_of_packages, library, logical(1L),
       character.only = TRUE, logical.return = TRUE)


# Helper function to iterate line breaks (`br()`) of "n" times
linebreaks <- function(n){htmltools::HTML(strrep(htmltools::tags$br(), n))}

# LOAD DATA:
# Load tool table
table_dst = read.csv("DST_table_v5.csv") # update May 26 2026
#names(table_dst)
#dim(table_dst)
phase  = levels(factor(table_dst[,9]))
step = levels(factor(table_dst[,10]))
task   = levels(factor(table_dst[,11]))
#statis = levels(factor(table_dst[,6]))
# Replace phase with <- c("Emergency Stabilization","Rehabilitation & Recovery","Restoration & Adaptation")
overview_txt = c('  (a)	Decision phase: Emergency stabilization, rehabilitation, and climate adaptive phase. (b)	Decision Step, including assess, plan, implement and monitor, and evaluate. This compass can inform resource managers about the availability of diverse types of decision support tools and orient resource managers to the use of available tools.')
head(table_dst)

###--------------------------------------------------------###
## UI
###--------------------------------------------------------###
# Shiny App code
ui <- shinydashboard::dashboardPage(
  
  shinydashboard::dashboardHeader(title = "FireToolMenu"),



  ## Sidebar content
  shinydashboard::dashboardSidebar(collapsed = FALSE,
    shinydashboard::sidebarMenu(
      shinydashboard::menuItem("Overview", tabName = "Overview"),
      shinydashboard::menuItem("Menu of Tools", tabName = "Selecttool"),
      shinydashboard::menuItem("Literature", tabName = "Literature"),
      shinydashboard::menuItem("Funding & Acknowledgements", tabName="FundingAcknowledgement"),
      shinydashboard::menuItem("Contact", tabName = "Contact")
    )
  ),
  

  ## Body content
  shinydashboard::dashboardBody(
    
    # Custom CSS style to place `dashboardHeader()` upper-left
    htmltools::tags$head(
      htmltools::tags$style(
        htmltools::HTML(
            '.navbar-custom-menu {
              position: absolute;
              display: inline-block;
              margin-top: 5px;
            }
            .sidebar-toggle {
            display: none;
            }'
          )
        ), 
                  
      # Favicon (cross-browser support) 
      # PNGs for modern browsers
      htmltools::tags$link(rel = "icon", type = "image/png", href = "favicon-32.png"),
      htmltools::tags$link(rel = "shortcut icon", type = "image/png", href = "favicon-32.png"),             
                    
    ),

    # START TABS
    shinydashboard::tabItems(
      
      ##################################### 
      ## (A) OVERVIEW (Page 1)
      ##################################### 
      shinydashboard::tabItem(
        tabName = "Overview",
        
        shiny::fluidPage(
          htmltools::HTML('<style>
           .box {
            border: 1px solid lightgrey;
            padding: 8px;
           }
            </style>'),htmltools::tags$br(),
          
          shiny::fluidRow(
            shiny::column(width=9, 
              shiny::titlePanel(htmltools::tags$strong("FireToolMenu: Overview")), htmltools::p("This site will enable you to explore different post-fire management tools. See the 'Menu of Tools' tab to explore various post-fire management tools.",style = "font-family: 'arial'; font-si48pt; display: flex;",htmltools::tags$br())),
            shiny::column(width=3,
              htmltools::tags$img(src="FireToolMenu_logo1.png",width=200),alt="Logo for Fire Tool Menu")
          ),
            
          shiny::fluidRow(
            shiny::column(width=12,
              shinydashboard::box(title = htmltools::div(class = 'box-title', htmltools::p('Overview')),

              htmltools::p("In western U.S. forests, the increasing frequency of large, severe wildfires in combination with climate stressors are contributing to projected limitations on reforestation success. Consequent outcomes include vulnerability to a shift from forest to non-forest landcover, a loss in ecosystem resilience, and threats to ecosystem services. The pre-fire forest may not return. In response to the need for improved decision support, an abundance of new decision support tools have recently become available.",style = "font-family: 'arial'; font-si24pt",htmltools::tags$br(),width=12),

              htmltools::p("Here we provide a framework (a Decision Support Compass) and a Menu of Post-Fire Tools (FireToolMenu) to assist managers in navigating Decision Support Tools (DST) complexity, and to identify appropriate decision support tools for postfire management. We reviewed DST for postfire management, generated through an iterative, bottom-up, manager-engaged method. We categorized the tools according to the:",style = "font-family: 'arial'; font-si24pt",htmltools::tags$br(),width=12),

              htmltools::div(
                htmltools::p("(a)	Decision phase: 1: Emergency Stabilization, 2: Rehabilitation, 3: Restoration and Adaptation.",style = "font-family: 'arial'; font-si24pt",htmltools::tags$br(),width=12),
                htmltools::p("(b)	Decision Step, including 1: Assess, 2: Engage, 3: Plan, 4: Implement, 5: Monitor & Evaluate, 6: All.",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br(),width=12),
                htmltools::p("(c)	Decision Task: available decision support tool(s).",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br(),width=12), style='margin-left: 20px'),

              htmltools::p("This compass can inform resource managers about the availability of diverse types of decision support tools and orient resource managers to the use of available tools. Specifically, it can support users in identifying tools for the series of steps of an adaptive management process.",style = "font-family: 'arial'; font-si24pt",htmltools::tags$br(), width=12),
              width=12)),

            shiny::column(width=12,
              shinydashboard::box(title = htmltools::div(class = 'box-title', htmltools::p('Definitions')),
                htmltools::p("Phase = The discrete periods of rehabilitation after wildfire (1:-Emergency Stabilization Phase, 2:-Rehabilitation Phase, 3:-Restoration and Adaptation Phase",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br()), 
                htmltools::p("Step = Post-fire descision-making processes/goals (6 steps: 1: Assess, 2: Engage, 3: Plan, 4: Implement, 5: Monitor & Evaluate, 6: All)",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br()),
                htmltools::p("Tasks = Specific activities of postfire decision-making (13 Tasks that fall under a specific Step (See Figure 1))",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br()),
              htmltools::p("DST = Decision Support Tool",style = "font-family: 'arial'; font-si48pt",htmltools::tags$br()),width=12)
            ),

            shiny::column(width=12,
              shinydashboard::box(title = htmltools::div(class = 'box-title', htmltools::p("Figure 1: Framework for Menu of Tools for Postfire Management, featuring decision stages and tasks")),
              htmltools::div(class = "center-image",
                        htmltools::tags$img(src = "Tools_V1.png", style = "width: 100%")),
                        width=12)),

            shiny::column(width=12,
              shinydashboard::box(title = htmltools::div(class = 'box-title', htmltools::p(htmltools::tags$strong("Post-fire Management Compass"), "(Steen-Adams et al.", htmltools::tags$i("in prep"), ")")),
              htmltools::div(class = "center-image",
                htmltools::tags$img(src = "Compass_v1.png", style = "width: 50%;")),
              width=12)),
            ),
            
          shinydashboard::box(
            shiny::fluidRow( # FLUIDROW  
          
              shiny::column(width=8, 
                htmltools::div(htmltools::tags$strong("Climate Adaptive Management of Post-fire Landscapes in the Blue Mountains"),style = "font-family: 'arial'; font-size: 18pt; display: flex; justify-content: center; align-items: center; height: 10vh;")),
              shiny::column(4, htmltools::div(class = "right-image", a(href="https://environment.wsu.edu/post-fire-management/", target='_blank',htmltools::tags$img(src='BlueMountainsProject_Logo.png', width='50%'))))
            ),
               
            shiny::fluidRow(
              shiny::column(width=12,
                htmltools::tags$br(), 
                htmltools::p("We have compiled relevant map layers for the Blue mountains which might help to inform the use of some of these tools. Layers in the map include fire perimeters, slope, aspect, and elevation, land cover in late summer 2024, and guidance on likelihood of replanting success based on topography.", style = "font-family: 'arial'; font-si48pt"),
                htmltools::p("Link to project website: ", htmltools::tags$a(href="https://environment.wsu.edu/post-fire-management/", target="_blank", "https://environment.wsu.edu/post-fire-management/"), style = "font-family: 'arial'; font-si48pt"), 
                htmltools::p("Download ", htmltools::tags$a(href="https://environment.wsu.edu/post-fire-management/documents/2025/02/instructions-for-testing-interactive-map.pdf/", target="_blank", "instructions"), "to test the map and provide feedback.", style = "font-family: 'arial'; font-si48pt"),
                linebreaks(2),
                shiny::htmlOutput("arcFrame"),
                linebreaks(1),
                htmltools::p(htmltools::tags$a(href="https://experience.arcgis.com/experience/165fb9171b484931a22a7c120ab19f6c#data_s=id%3AdataSource_1-192f98ca0be-layer-65%3A2097&widget_1=active_datasource_id:dataSource_1,center:-13378988.665829409%2C5584771.018644394%2C102100,scale:2868652.0382007803,rotation:0,viewpoint:%7B%22rotation%22%3A0%2C%22scale%22%3A2868652.0382007803%2C%22targetGeometry%22%3A%7B%22spatialReference%22%3A%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D%2C%22x%22%3A-13378988.665829409%2C%22y%22%3A5584771.018644394%7D%7D,layer_visibility:%7B%22widget_1-dataSource_1%22%3A%7B%22widget_1-dataSource_1-1951f4948e7-layer-17%22%3Atrue%2C%22widget_1-dataSource_1-192f98ca0be-layer-65%22%3Afalse%7D%7D&zoom_to_selection=true", target='_blank', "Click here to open map on ArcGIS Experience"))
              )
            ), # FLUIDROW  
        linebreaks(2),
        htmltools::p("Last updated: Aug, 2025")
            
           
          ,width=12) # box width

        ) # FLUIDPAGE
      ),  # TABITEM
      #----- End (A) -------
      #---------------------
    
      
      ##################################### 
      ## (B) Tool selector (Page 2)
      ##################################### 
      shinydashboard::tabItem(
        tabName = "Selecttool",
        shiny::fluidPage(
          htmltools::HTML('<style>
           .box {
            border: 1px solid lightgrey;
            padding: 8px;
           }
            </style>'),htmltools::tags$br(),
          
          shiny::fluidRow(
            shiny::column(width=9,
              shiny::titlePanel(htmltools::tags$strong("FireToolMenu: Tool selector")), 
              htmltools::p("Explore various tools by using the drop down menus below. Select your Desicion Phase and Desicion Step narrow down the eventual tools you might be interested in. When you select the tool, you can inspect the output to learn more about the tool. You can use the compass on the right to guide to the appropriate tool.", style = "font-family: 'arial'; font-si24pt; display: flex; justify-content: center; align-items: center; height: 20vh;")
            ),
            
            shiny::column(width=3,
              htmltools::tags$img(src="FireToolMenu_logo1.png",width=200),title="", style = 'text-align:right;'), 
              htmltools::tags$br()
            ),
          shinydashboard::tabBox(
            id = "UserInputs",
            width = 12,
            tabPanel("Menu of Tools",
              style = "font-family: 'arial'; font-size: 18pt;",
              shiny::fluidRow(
                shiny::column(width=3,
                  pickerInput("dropdown1", h3("Phase (Select your descision phase):"), choices = phase, multiple = T), #-- PHASE --#
                  htmltools::p(linebreaks(3))),
                shiny::column(width=3,
                  uiOutput("dropdown2"), #-- STEP --#
                  htmltools::p(linebreaks(3))),
                shiny::column(width=3,
                  uiOutput("dropdown3"), #-- TOOL --#
                  htmltools::p(linebreaks(3)))),

              shinydashboard::box(
                  htmltools::div(
                    h2(htmltools::tags$strong("OUTPUT:")), style='margin-left: 30px'
                  ),
                  htmltools::tags$br(), 

                  shiny::column(width=12,
                    shinydashboard::box(verbatimTextOutput("selected_var1"),title="Choice:",width=12)
                  ),
                  shiny::column(width=12,
                    shinydashboard::box(div(DT::DTOutput("toolTable"), style="font-size: 80%"),title="Selected Tools",width=12)
                  ),
                  shiny::column(width=12,
                    shinydashboard::box(shiny::downloadButton("downloadTable", "CLICK TO DOWNLOAD TABLE and METADATA"), width=12)
                  ),
                style = "border: 1px solid #000000; background-color: #818589; padding: 6px; border-radius: 5px; color: #000000;", width = 12)
             

            ) # TAB 2 (Multi Tool)
   
          ) # TABBOX
        )   # FLUIDPAGE
      ),    # TABITEM
      #----- End (B) -------
      #---------------------
      
      ##################################### 
      ## (C) Literature (Page 3)
      ##################################### 
      shinydashboard::tabItem(
        tabName = "Literature",
        shiny::fluidPage(
          htmltools::HTML('<style>
           .box {
            border: 1px solid lightgrey;
            padding: 8px;
           }
            </style>'),
          htmltools::tags$br(),

          shiny::fluidRow(
            shiny::column(width=12, 
              shiny::titlePanel(htmltools::tags$strong("Peer-reviewed papers:")))
            ),          
          linebreaks(2),

          shiny::fluidRow(
            shiny::column(width = 7, 
              shinydashboard::box(
                  htmltools::p("Compass/Menu of Tools manuscript:"),
                  htmltools::div(htmltools::p("Steen-Adams, A.T. Stahl, J.V. Celebrezze, R. Andrus, M. Franz, A.J.H. Meddens (in prep). A compass for public lands managers to navigate postfire management tools: accommodating a prospective transition toward climate adaptation, in preparation for Fire Ecology.", htmltools::tags$a(href="DOI/URL/HERE", "DOI/URL/HERE", target="_blank")), style="margin-left: 40px"),
                  htmltools::p(linebreaks(1)),

                  htmltools::p("Research article on tree establishment in the Blue Mountains (Andrus et. al. 2023):"),
                  htmltools::div(htmltools::p("Andrus, R.A., Droske, C.A., Franz, M.C., Hudak, A.T., Lentile, L.B., Lewis, S.A., Morgan, P., Robichaud, P.R., & Meddens, A.J. (2022). Spatial and temporal drivers of post-fire tree establishment and height growth in a managed forest landscape. Fire Ecology, 18, 29.", htmltools::tags$a(href="https://doi.org/10.1186/s42408-022-00153-4", "https://doi.org/10.1186/s42408-022-00153-4", target="_blank")), style="margin-left: 40px"),
                  htmltools::p(linebreaks(1)),

                  htmltools::p("Research article on spectral recovery in relation to forest recovery post-fire (Celebrezze et al. 2024):"),
                  htmltools::div(htmltools::p("Celebrezze, J.V., Franz, M.C., Andrus, R.A., Stahl, A.T., Steen-Adams, M., & Meddens, A.J. (2024). A fast spectral recovery does not necessarily indicate post-fire forest recovery. Fire Ecology, 20, 54.", htmltools::tags$a(href="https://doi.org/10.1186/s42408-024-00288-6", "https://doi.org/10.1186/s42408-024-00288-6", target="_blank")), style="margin-left: 40px"),
                  htmltools::p(linebreaks(1)),

                  htmltools::p("Additional key references: "),
                  htmltools::div(htmltools::p("Krosby M, Davis K, Rozance MA, et al (2020) Managing post-fire, climate-induced vegetation transitions in the Northwest: A synthesis of existing knowledge and research needs. Northwest Climate Adaptation Science Center. University of Washington, Seattle", htmltools::tags$a(href="https://nwcasc.uw.edu/wp-content/uploads/sites/23/2021/03/DEEP_DIVE_2020_REPORT.pdf", "https://nwcasc.uw.edu/wp-content/uploads/sites/23/2021/03/DEEP_DIVE_2020_REPORT.pdf", target="_blank")), style="margin-left: 40px"),
                  htmltools::div(htmltools::p("Schuurman GW, Cole DN, Cravens AE, et al (2022) Navigating Ecological Transformation: Resist–Accept–Direct as a Path to a New Resource Management Paradigm. BioScience 72:16–29. ", htmltools::tags$a(href="https://doi.org/10.1093/biosci/biab067", "https://doi.org/10.1093/biosci/biab067", target="_blank")), style="margin-left: 40px"),
                  htmltools::div(htmltools::p("Cravens AE, Clifford KR, Knapp C, Travis WR (2025) The dynamic feasibility of resisting (R), accepting (A), or directing (D) ecological change. Conservation Biology 39:.", htmltools::tags$a(href="https://doi.org/10.1111/cobi.14331", "https://doi.org/10.1111/cobi.14331", target="_blank")), style="margin-left: 40px"),
                  htmltools::div(htmltools::p("Clifford et al., 2022, Responding to Ecological Transformation: Mental Models, External Constraints, and Manager Decision-Making, Bioscience", htmltools::tags$a(href="https://doi.org/10.1093/biosci/biab086", "https://doi.org/10.1093/biosci/biab086", target="_blank")), style="margin-left: 40px"),
                  htmltools::div(htmltools::p("Davis KT, Wynecoop M, Rozance MA, et al (2024) Centering socioecological connections to collaboratively manage post‐fire vegetation shifts. Frontiers in Ecol & Environ 22:e2739.", htmltools::tags$a(href="https://doi.org/10.1002/fee.2739", "https://doi.org/10.1002/fee.2739", target="_blank")), style="margin-left: 40px"),style = "font-family: 'arial'; font-si24pt",
                width=12)
              ), 
            
            shiny::column(width=5, 
              htmltools::div(class='center-image', 
                htmltools::tags$figure(htmltools::tags$img(src='Celebrezze_Graphical-Abstract.png', width='100%'), 
                  htmltools::tags$figcaption(htmltools::tags$em("Graphical abstract: A fast spectral recovery does not necessarily indicate post-fire forest recovery, "), 
                    htmltools::tags$em(htmltools::tags$a(href='https://doi.org/10.1186/s42408-024-00288-6', target='blank', "Celebrezze et al. 2024"))
                  )
                )
              ),
              htmltools::tags$br(),

                htmltools::div(class='center-image', 
                  htmltools::tags$figure(htmltools::tags$img(src='Andrus_etal_2022.png', width='100%'), 
                    htmltools::tags$figcaption(em("A. Burn severity (MTBS 2021) and locations of salvaged and not salvaged plots (50 plots total) in the School Fire (2005), Umatilla National Forest, southeastern Washington State, USA (inset). B–D. Examples of the three initial post-fire forest trajectories, including (B) dry ponderosa pine, (C) dry mixed conifer (ponderosa pine, Douglas fir, and grand fir), and (D) moist mixed conifer (western larch, lodgepole pine, Engelmann spruce, and dry mixed conifer species). Photo credit: R. Andrus, "), 
                      htmltools::tags$em(htmltools::tags$a(href='https://doi.org/10.1186/s42408-022-00153-4', target='blank', "Andrus et. al. 2023"))
                    )
                  )
                )
              )
        
       
          ) # FLUIDROW  
        ) # FLUIDPAGE

      ),    # TABITEM
    #----- End (C) -------
    #---------------------
       
      ##################################### 
      ## (E) Funding (Page 4)
      ##################################### 
      shinydashboard::tabItem(
        tabName = "FundingAcknowledgement",
        shiny::fluidPage(
          htmltools::HTML('<style>
          .box {
            border: 1px solid lightgrey;
            padding: 8px;
          }
          </style>'),
          htmltools::tags$br(),
          
          shiny::fluidRow(
            shiny::column(width=12, 
              shiny::titlePanel(htmltools::tags$strong("Funding and Acknowledgements")))),

          linebreaks(2),

          shiny::fluidRow(
            shiny::column(width=12,
              shinydashboard::box(solidHeader = TRUE,
                        collapsible = TRUE,
                        title = htmltools::div(class = 'box-title', htmltools::p('Funding')),                          
                          htmltools::div(class="banner-container", 
                              a(href='https://labs.wsu.edu/meddenslab/', target='_blank', img(src="WSU.jpg", width='100%')), 
                              a(href='https://nwcasc.uw.edu/science/project/a-multi-scale-decision-support-platform-for-adaptive-management-of-post-fire-landscapes-in-the-inland-northwest/', target='_blank',img(src="NWCASC.png", width='100%')), 
                              a(href='https://www.firescience.gov', target='_blank', img(src="JFSP.png", width='100%'))
                          ),
                        linebreaks(2),
                        htmltools::p(htmltools::tags$em("* Please click on the images to navigate to their respective websites"), style='text-align:right; color: gray'),
                        linebreaks(2),
                        shinydashboard::box(status = 'warning',htmltools::tags$em("The conclusions and views presented in this work are those of the authors and should not be interpreted as representative of the views or policies of USGS, nor should any commercial products mentioned in the text be misinterpreted as being endorsed by USGS or NWCASC."),  style = "font-family: 'arial'; font-si24pt; border: 2px solid #ff6700;", width = 12), 
                        style = "font-family: 'arial'; font-si24pt",width=12)
              ),

            shiny::column(width=12,
              shinydashboard::box(solidHeader = TRUE,
                        collapsible = TRUE,
                        title = htmltools::div(class = 'box-title', htmltools::p('Acknowledgements')),
                        linebreaks(2),
                        htmltools::p(tags$i("TEXT TO BE PROVIDED BY MICHELE")),style = "font-family: 'arial'; font-si24pt",htmltools::tags$br(),width=12)
            )
        
          ) # FLUIDROW
        ) # FLUIDPAGE
      ), # TABITEM
    
        ##################################### 
        ## (F) Contact (Page 5)
        ##################################### 
        shinydashboard::tabItem(
          tabName = "Contact",
          shiny::fluidPage(
            htmltools::HTML('<style>
            .box {
              border: 1px solid lightgrey;
              padding: 8px;
            }
              </style>'),
            
            htmltools::tags$br(),
          
            shiny::fluidRow(
              shiny::column(width=12, 
                shiny::titlePanel(htmltools::tags$strong("Team and Contact Information")))
              ), 
            linebreaks(2),

            shiny::fluidRow(
              shiny::column(width=6,
              
                shiny::column(width=12,
                  shinydashboard::box(solidHeader = TRUE,
                            collapsible = TRUE,
                            title = htmltools::div(class = 'box-title', htmltools::p('Website and Further Information')),
                              htmltools::p("Check out our project website:"),
                              htmltools::p("-", htmltools::tags$a(href="https://environment.wsu.edu/post-fire-management/sample-page/partners/", target="_blank", "https://environment.wsu.edu/post-fire-management/sample-page/partners/")),
                              htmltools::p(linebreaks(2)),
                              htmltools::p("Contact us if you have a new tool that should be included into the FireToolMenu."),
                              htmltools::p("Send an email to:", htmltools::tags$a(href="mailto:arjan.meddens@wsu.edu", target="_blank", "arjan.meddens@wsu.edu"),  "or",  htmltools::tags$a(href="mailto:m.steen-adams@wsu.edu", target="_blank", "m.steen-adams@wsu.edu")),
                              style = "font-family: 'arial'; font-si24pt",width=12)
                    ),
                shiny::column(width=12,
                  shinydashboard::box(solidHeader = TRUE,
                                      collapsible = TRUE,
                                      title = htmltools::div(class = 'box-title', htmltools::p('Academic Team (WSU)')),
                                      htmltools::p("Principal Investigators:"),
                                      htmltools::p("- Michelle Steen-Adams,", htmltools::tags$a(href="m.steen-adams@wsu.edu", target="_blank","m.steen-adams@wsu.edu")),
                                      htmltools::p("- Arjan Meddens,",  htmltools::tags$a(href="arjan.meddens@wsu.edu", target="_blank","arjan.meddens@wsu.edu")),
                                      htmltools::p(linebreaks(2)),
                                      htmltools::p("Co-Investigators"),
                                      htmltools::p("- Amanda Stahl,", htmltools::tags$a(href="atstahl@wsu.edu", target="_blank","atstahl@wsu.edu")),
                                      htmltools::p("- Robert Andrus,", htmltools::tags$a(href="robert.andrus@wsu.edu",target="_blank","robert.andrus@wsu.edu")),
                                      htmltools::p(linebreaks(2)),
                                      htmltools::p("Researchers"),
                                      htmltools::p("- Joe Celebrezze,", htmltools::tags$a(href="joseph.celebrezze@wsu.edu", target="_blank", "joseph.celebrezze@wsu.edu")),
                                      htmltools::p("- Madeline Franz,", htmltools::tags$a(href="madeline.franz@wsu.edu", target="_blank", "madeline.franz@wsu.edu")),
                                      htmltools::p("- Abhinav Shrestha,", htmltools::tags$a(href="abhinav.shrestha96@gmail.com", target="_blank", "abhinav.shrestha96@gmail.com"))
                                      ,style = "font-family: 'arial'; font-si24pt",width=12)
                  )
                    
              ), 
              
              shiny::column(width=6, 
                htmltools::div(class='center-image', 
                  htmltools::tags$figure(
                    htmltools::tags$a(href = 'https://environment.wsu.edu/post-fire-management/sample-page/decision-support-platform/', target = '_blank', htmltools::tags$img(src='Toolbox_illustrative.png', width='100%')), 
                    htmltools::tags$figcaption(htmltools::tags$em("Source: "), htmltools::tags$em(tags$a(href='https://environment.wsu.edu/post-fire-management/sample-page/decision-support-platform/', target='blank', "WSU Decision Support Platform Project Website")))
                  )
                )
              )                
            
            ) # FLUIDROW
          ) # FLUIDPAGE
        ) # TABITEM
      )  # TABITEMS   
  
    )    # dashboardBody
)   # UI # dashboardPage

###--------------------------------------------------------###
## SERVER
###--------------------------------------------------------###
# server <- shinyServer(function(input, output, session) { 
server <- function(input, output, session) {

  # https://stackoverflow.com/questions/41882658/embed-container-arcgis-online-iframe-using-shiny-r
 output$arcFrame <- shiny::renderUI({
  
  # Define custom styles (classes) for `div()` with CSS under `<style>`
  htmltools::HTML('
    <style>
      .embed-container {
        position: relative;
        padding-bottom: 60%; /* Aspect ratio: adjust as needed (e.g., 56.25% for 16:9) */
        height: 0;
        overflow: hidden;
        max-width: 100%;
      }

      .embed-container iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border: 0;
      }


      .center-image {
        position: relative;
        display: flex;
        justify-content: center;
        top: 0;
        left: 0;
        width: 100%;
        height: auto;
        overflow: hidden;
        max-width: 100%;
      }

      .right-image {
        position: relative;
        display: flex;
        justify-content: right;
        top: 0;
        left: 0;
        width: 100%;
        height: auto;
        overflow: hidden;
        max-width: 100%;
      }
      
      .right-image a {
        position: relative;
        display: flex;
        justify-content: right;
        top: 0;
        left: 0;
        width: 100%;
        height: auto;
        overflow: hidden;
        max-width: 100%;
      }
      
      .box-title p {
        font-family: arial;
        font-size: 16pt;
        font-weight: bold;
      }
    
  
      .banner-container {
        background-color: white;
        display: flex;
        justify-content: center;   /* center logos horizontally */
        align-items: center;       /* center logos vertically */
        flex-wrap: wrap;           /* allow wrapping if too many logos */
        gap: 20px;                  /* space between logos */
        padding: 10px;              /* padding inside the banner */
        width: 100%;
        box-sizing: border-box;     /* include padding in width */
      }

      .banner-container img {
        max-height: 120px;           /* controls banner height */
        height: auto;
        width: auto;
        object-fit: contain;        /* preserve aspect ratio */
      }

    </style>

    <div class="embed-container">
      <iframe
        title="InteractiveMap"
        src="https://experience.arcgis.com/experience/165fb9171b484931a22a7c120ab19f6c#data_s=id%3AdataSource_1-192f98ca0be-layer-65%3A2097&widget_1=active_datasource_id:dataSource_1,center:-13378988.665829409%2C5584771.018644394%2C102100,scale:2868652.0382007803,rotation:0,viewpoint:%7B%22rotation%22%3A0%2C%22scale%22%3A2868652.0382007803%2C%22targetGeometry%22%3A%7B%22spatialReference%22%3A%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D%2C%22x%22%3A-13378988.665829409%2C%22y%22%3A5584771.018644394%7D%7D,layer_visibility:%7B%22widget_1-dataSource_1%22%3A%7B%22widget_1-dataSource_1-1951f4948e7-layer-17%22%3Atrue%2C%22widget_1-dataSource_1-192f98ca0be-layer-65%22%3Afalse%7D%7D&zoom_to_selection=true"
        allowfullscreen
        loading="lazy">
      </iframe>
    </div>
  ')
 })



   ## Dropdown 2 -- Reaction values function 
  values.func2 <- shiny::reactive({
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
  values.func3 <- shiny::reactive({
    req(input$dropdown2)
    if (length(input$dropdown1) == 1) {
      # testing 
      #tmp1_index  = which(table_dst[,3] ==  "Restore & Adapt")
      #tmp_dst  = table_dst[tmp1_index,]
      #tmp2_index  = which(tmp_dst[,4] ==  "Plan")
      #tmp_dst2 = tmp_dst[tmp2_index,]
      if(input$dropdown2 == c("All")) {
        tmp1_index  = which(table_dst[,9] ==  input$dropdown1)
        tmp_dst2 = table_dst[tmp1_index,]
        if(length(c(tmp_dst2[,2]))==0){
          return(c('NO TOOLS AVAILABLE FOR SELECTED OPTIONS'))
        } else {
          input3Choices <<- c(tmp_dst2[,2])
          return(c(tmp_dst2[,2]))  
        }
        
      } else {
        tmp1_index  = which(table_dst[,9] ==  input$dropdown1)
        tmp_dst = table_dst[tmp1_index,]
        tmp2_index  = which(tmp_dst[,10] ==  input$dropdown2)
        tmp_dst2 = tmp_dst[tmp2_index,]
        if(length(c(tmp_dst2[,2]))==0){
          return(c('NO TOOLS AVAILABLE FOR SELECTED OPTIONS'))
        } else {
          return(c(tmp_dst2[,2]))  
        }
        
      }
    }
    if (length(input$dropdown1) == 2) {
      tmp1_index  = which(table_dst[,9] ==  input$dropdown1[1] | table_dst[,9] ==  input$dropdown1[2])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,10] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      if(length(c(tmp_dst2[,2]))==0){
          return(c('NO TOOLS AVAILABLE FOR SELECTED OPTIONS'))
        } else {
          return(c(tmp_dst2[,2]))  
        }
      
    }
    if (length(input$dropdown1) == 3) {
      tmp1_index  = which(table_dst[,9] ==  input$dropdown1[1] | table_dst[,10] ==  input$dropdown1[2] | table_dst[,11] ==  input$dropdown1[3])
      tmp_dst = table_dst[tmp1_index,]
      tmp2_index  = which(tmp_dst[,9] ==  input$dropdown2[1])
      tmp_dst2 = tmp_dst[tmp2_index,]
      if(length(c(tmp_dst2[,2]))==0){
          return(c('NO TOOLS AVAILABLE FOR SELECTED OPTIONS'))
        } else {
          return(c(tmp_dst2[,2]))  
        }
      
    }
  })

 
   
  
  #----------------------------------------------------------------------------------------------
  ## Reactive Dropdown 2 # STEP out
  output$dropdown2 <- renderUI({
    #htmltools::HTML(paste0("Output 1 here", collapse = "<br>"))
    # print("HERE2")
    pickerInput("dropdown2", h3("Step (Select your descision Step):"), choices = values.func2(), options = pickerOptions(
      actionsBox = TRUE,title = "Please select a Descision Step"))
  })
     
  ## Reactive Dropdown 3 # TASK out
  output$dropdown3 <- renderUI({
    pickerInput("dropdown3", h3("Tool (select tool for more Information):"), choices = values.func3(), multiple = T, options = pickerOptions(
      actionsBox = TRUE,title = "Please select a Tool"))
  })

  # Check the outputs of the tool selection, warn user if there are no tools found
  shiny::observe({
    tools <- values.func3()

    if (isTRUE(tools == c('NO TOOLS AVAILABLE FOR SELECTED OPTIONS'))) {
      # noToolsFlag(TRUE)
      shiny::showModal(shiny::modalDialog(title ="NO TOOLS AVAILABLE", "There were no results found for the selected inputs. Please review the options and try again!")) # https://shiny.posit.co/r/reference/shiny/0.14/showmodal.html

    } else {
      # noToolsFlag(FALSE)

    }
  })


# Reactive function that concatenates multiple selection of input$dropdown1 as single string for print
inputdropdown1_selectOpt <- shiny::reactive({  
    if(length(input$dropdown1) > 1){
      strOut <- as.character()
      for(i in 1:length(input$dropdown1)){
        strOut <- cbind(strOut, input$dropdown1[i])
      }
      return(toString(strOut))
    } else{
      return(input$dropdown1)
    }
})
  

# Reactive function that concatenates multiple selection of input$dropdown3 as single string for print
inputdropdown3_selectOpt <- shiny::reactive({  
    if(length(input$dropdown3) > 1){
      strOut <- as.character()
      for(i in 1:length(input$dropdown3)){
        strOut <- cbind(strOut, input$dropdown3[i])
      }
      return(toString(strOut))
    } else{
      return(input$dropdown3)
    }
})


  ## Reactive Output text 1
  output$selected_var1 <- shiny::renderText({
      req(input$dropdown1, input$dropdown2, input$dropdown3) # clears output if user reselects options
      paste("Phase: ", paste("-", inputdropdown1_selectOpt()), "Step: ",  paste("-", input$dropdown2), "Tool: ",  paste("-", inputdropdown3_selectOpt()), sep='\n')
  })


  #  ## Reactive Output text 2
#  output$selected_var2 <- shiny::renderText({
#    paste(input$dropdown2,"Choice")
#  })
#  ## Reactive Output text 3
#  output$selected_var3 <- shiny::renderText({
#    paste(input$dropdown3,"Choice")
#  })
  

  get_SelectedToolTable <- shiny::reactive({
    req(values.func3())  # ensures it’s available before rendering
    selectedTools <- c(input$dropdown3) # pass `values.func()` to output ALL AVAILABLE TOOLS

    # Testing
     #print(paste0('returned values: ', selectedTools)) # Testing
     #selectedTools = "PFS Decision Tree"
     #subsetDF <- table_dst[table_dst$Short.Title %in% selectedTools, ]
    # Testing
     
    subsetDF <- table_dst[table_dst$Short.Title %in% selectedTools, ]
    outDF <- subsetDF[,c(3, 4, 5, 15)]  #- OLD: subsetDF[,c(2, 7:9)]   # outDF only has 4 columns (tool, desc, URL, citation) # UPDATE: 
    colnames(outDF)[colnames(outDF) == "Short.Title"] <- "Tool"
    return(outDF)
    }
  )
  get_SelectedChoicesMetadata <- shiny::reactive({
    req(input$dropdown1, input$dropdown2, input$dropdown3) # clears output if user reselects options
    outMetaTxt <- paste("Phase: ", paste("-", inputdropdown1_selectOpt()), "Step: ",  paste("-", input$dropdown2), "Tool: ",  paste("-", inputdropdown3_selectOpt()), sep='\n')
    return(outMetaTxt)
  })

  # selectedTools <- c('Short BAR guide', 'Data Basin', 'ClimResilToolkit') # replace this is `values.func3()`
  output$toolTable <- DT::renderDT({
      DT::datatable(get_SelectedToolTable(), 
                    extensions = c("FixedColumns","FixedHeader"), # Enables fixed header and column (https://stackoverflow.com/questions/69835894/workaround-for-issues-with-freezing-header-in-dtdatatable-in-r-shiny)
                    rownames = FALSE, 
                    options = list(scrollX = T, scrollY = T, fixedHeader = T, fixedColumns = list(leftColumns = 1)))
      })

    output$downloadTable <- shiny::downloadHandler(
      filename = function() {
        paste('FireToolMenu_OUTPUT_', Sys.Date(), '.zip', sep='')
      },
      content = function(file) {

        # checks if output table exists
        tryCatch({
         get_SelectedToolTable() # check
          # zip output table and metadata (input/choices) https://groups.google.com/g/shiny-discuss/c/zATYJCdSTwk
          tmpdir <- tempdir()
          setwd(tmpdir)
          print(tmpdir)
                    
          outMetaTxt <- get_SelectedChoicesMetadata()
          writeLines(outMetaTxt, paste('FireToolMenu_Metadata_', Sys.Date(), '.txt', sep=''))
          
          write.csv(get_SelectedToolTable(), paste('FireToolMenu_SelectedTools_', Sys.Date(), '.csv', sep=''), row.names=FALSE)
          fileList <- c(paste('FireToolMenu_Metadata_', Sys.Date(), '.txt', sep=''), paste('FireToolMenu_SelectedTools_', Sys.Date(), '.csv', sep=''))

          zip::zip(file, files = fileList)
          
                       
        
        },
          shiny.silent.error = function(e) {
            shiny::showModal(shiny::modalDialog(title ="DOWNLOAD ERROR: no tools selected", "Please use the download button once all inputs are selected and an output table is generated!!!")) # https://shiny.posit.co/r/reference/shiny/0.14/showmodal.html
          }
        )
          
       
      }
    )

  
  #- Testing
  #dropdown3 = c("A guidebook to spatial datasets for conservation planning under climate change in the Pacific Northwest")
  #table_dst[c(which(table_dst[,1] == dropdown3)),8]
  #paste((table_dst[c(which(table_dst[,1] == dropdown3)),8]),"Choice")
  
  #- Update pickerboxes instantaneously
  shiny::observe({
    updateSelectInput(session, "showDrop", label = "Select", choices = values.func2())
    updateSelectInput(session, "showDrop", label = "Select", choices = values.func3())
    
  })

}


###--------------------------------------------------------###
shiny::shinyApp(ui, server)

###--------------------------------------------------------###
## END
###--------------------------------------------------------###