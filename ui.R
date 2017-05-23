library(shiny)
shinyUI(fluidPage(
  titlePanel("Character page"),
  sidebarLayout(
    sidebarPanel(
            h2("Characteristics"),
            textInput("Name","Set your Name:", value = ""),
            selectInput("Gender", "Set your gender:",c("","Male", "Female")),
            p("No impact on the statistics. We are all equal my friend ^^"),
            sliderInput("Age", "Set your age:", 18, 99, 18),
            p("Age have direct impact on you health and your magic power"),
            selectInput("Class", "Set your class:",
                        c("","Warrior", "Sorcerer", "Ranger")),
            p("Each class has his own characteristic."),
            p("For Instance, if you choose to be a Warrior, you will be stronger, have a huge level stamina and agility, but you also be less intelligent. The muscle before the head."),
            p("On the contrary, if you chosse to be a Sorceler, your level of Intelligence and Spirituality will be high, but you will be weak (low strength and stamina)"),
            p("The last class, Ranger, is for you, if you are more careful and want to have a more balanced skil trees. In Ranger you are good for Away and quick damages"),
            h2("Skills"),
            p("All skills level depend on your class. You will start with good level in one skill but not in another. Moreover the level of skill will be limited by your class."),
            p("Again a warrior will start with an high level of strength and a low level of Spirituality, and so for the other class"),
            p("",strong("you can set the level of each following as you want below")),
            numericInput("Strength", "Strength:", 
                         value = 1, min = 1, max = 1),
            p("Strength impacts directly your level of physical damages. You can hit very strongly. What's more it made you more resistant to physical attacks"),
            numericInput("Stamina", "Stamina:", 
                         value = 1, min = 1, max = 1),
            p("Stamiana is usefull if you want to have high physical and away damages. Without stamina you can't do anything"),
            numericInput("Agility", "Agility:", 
                         value = 1, min = 1, max = 1),
            p("Agility it's important to move quickly. Very usefull if you want hit the enemy keeping your ditance with him"),
            numericInput("Vitality", "Vitality:", 
                         value = 1, min = 1, max = 1),
            p("Vitality it's good for the health. Without it you surely die"),
            numericInput("Intelligence", "Intelligence:", 
                         value = 1, min = 1, max = 1),
            p("Intelligence allow you to learn more and more spell. What's more it help you to use them well and also improve their power"),
            numericInput("Spirituality", "Spirituality:", 
                         value = 1, min = 1, max = 1),
            p("Spirtaulity set the level of the spell you can use. More you have spirituality, more you can use powerfull and dangerous spells"),
            h2("Outfit & Objects"),
            p("Choose one of this object to obtain bonus"), 
            fluidRow(
                    column(3,checkboxInput("Sword", "Sword", value = FALSE)),
                    column(3,checkboxInput("Bow", "Bow", value = FALSE)),
                    column(3,checkboxInput("Armor", "Armor", value = FALSE)),
                    column(3,checkboxInput("Magicr", "Magical ring", value = FALSE))
            ),
            p("Sword gives you a bonus in physical damages, Bow gives you a bonus in away damages, Armor improve your resistance and the Magical ring increase your magical damage resistance as weel as the power of your spell")
            ),
    mainPanel(
            p("Do you love RPG ? Do you love game Dungeons & Dragons ? Or do you just want to test a funny app for Coursera Course ?", strong("So that app is for you"), align ="center"),
            p("This app allow you to create an character page as the at the beginning of a new aventure. It displays in the rigth panel, the statistics of your character depending on the features you have selected on the left pannel", align = "center"),
            p("You can chose : its name, its gender, its class, its skill level and some objects to change its statistics", align ="center"),
            p("The statistics are gather in 3 categories (each in one tab) : Damages, Health and Mana (Magic)",align = "center"),
            p("You can play with all features and see how it change the stats of your character", align = "center"),
            p("",strong("Have fun !"), align = "center"),
            h2(textOutput("chara_name")),
            h3(textOutput("age_number")),
            tabsetPanel(type ="tabs",
                        tabPanel("Damages",
                                 p("In that tab are gather all stats related to the damages. According to the kind of damage Strength, Agility, or Spirituality are important"),
                                 plotOutput("Damages"),
                                 p("Heavy infighting damages mainly depend on Strength and Stamina level"),
                                 p("Fast infighting damages mainly depend on Agility and stamina level"),
                                 p("Away damages mainly depend on Agility and Intelligence level"),
                                 p("Magical damages mainly depend on Spirituality and Intelligence level"),
                                 p("",strong("Use the differents objects to increase the damages"))),
                        tabPanel("Health",
                                 p("In that tab are gather all stats related to your Health and resitance. Basically, if your want to increase both you have to have a good", strong("Strength, Stamina and Vitality")),
                                 fluidRow(
                                         column(12,plotOutput("Health_bar"),
                                                p("Vitality and Strenght improve the health bar. Be carefull if you are", strong("older than 80 years old")),
                                                fluidRow(
                                                        column(4,plotOutput("Pdmg_resistance"),
                                                               p("Stamina and Strenght improve the physical resistance", align = "center")),
                                                        column(4, plotOutput("Admg_resitance"),
                                                               p("Stamina and Agility improve the Away resistance", align = "center")),
                                                        column(4, plotOutput("Magic_resitance"),
                                                               p("Spirituality and Intelligence imporve Magical resistance", align = "center")
                                                               )
                                                        )
                                                ),
                                         p("",strong("Use the differents objects to increase the resistance", align = "center"))
                                         )
                                 ),
                        tabPanel("Mana",
                                 p("In that tab are gather all stats related to your Magical power"), 
                                 p("When you earn", strong("10 points in Intelligence"),"you can learn", strong("1 spell more"), "(if your Intelligence is already greater than 10)"),
                                 p("When you earn", strong("1 points in Spirituality"), "you can use", strong("1 level more powerfull spell"), "(if your Spirituality is already greater than 10)"),
                                 fluidRow(
                                         column(12,plotOutput("Mana_bar"),
                                                p("Spirituality and Intelligence improve Magical bar"),
                                                fluidRow(
                                                  column(6, plotOutput("Mana_cons"),
                                                         p("The above plot show you for a level of spell how much you have to use of magiacal energy",
                                                           strong("The more you are powerfull, the less you consume our magical energy"), br(),
                                                           strong("Use the Magiacl to increase your magical power", align = "center"))),
                                                  column(6,
                                                         fluidRow(
                                                                 column(6,"Number of spell", br(), h4(textOutput("Nb_spell"), align = "center"),
                                                                        "Level of spell", br(), h4(textOutput("Level_spell"), align = "center"))
                                                         )
                                                  )
                                                )
                                         )
                                 )
                        )
            )
    )
  )
)
)

            
  
