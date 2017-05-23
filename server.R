library(shiny)
shinyServer(function(input, output, session) { 

# age outputs
output$chara_name <- renderText(
  paste(
  if(input$Gender == "Male"){
          "Sir"
  } else if(input$Gender == "Female"){ 
          "Lady"
  } else {""},
  input$Name, sep = " ")
  )

output$age_number <- reactive({if(input$Age > 18){
        (paste(input$Age, "years old", sep =" "))
}else{""}
})

# Skill condition tree          
observe({if(input$Class == 'Warrior') {
        updateSliderInput(session, inputId = "Strength",
                          value = 12, min = 12, max = 120, step = 1)
        updateSliderInput(session, inputId = "Stamina",
                          value = 10, min = 10, max = 120, step = 1)
        updateSliderInput(session, inputId = "Agility",
                          value = 8, min = 8, max = 84, step = 1)
        updateSliderInput(session, inputId = "Vitality",
                          value = 6, min = 6, max = 84, step = 1)
        updateSliderInput(session, inputId = "Intelligence",
                          value = 4, min = 4, max = 60, step = 1)
        updateSliderInput(session, inputId = "Spirituality",
                          value = 2, min = 2, max = 60, step = 1)
        } else if(input$Class =='Sorcerer'){
        updateNumericInput(session, inputId = "Strength",
                          value = 2, min = 2, max = 60, step = 1)
        updateSliderInput(session, inputId = "Stamina",
                          value = 4, min = 4, max = 60, step = 1)
        updateSliderInput(session, inputId = "Agility",
                          value = 6, min = 6, max = 84, step = 1)
        updateSliderInput(session, inputId = "Vitality",
                          value = 8, min = 8, max = 84, step = 1)
        updateSliderInput(session, inputId = "Intelligence",
                          value = 10, min = 10, max = 120, step = 1)
        updateSliderInput(session, inputId = "Spirituality",
                          value = 12, min = 12, max = 120, step = 1)
        } else if(input$Class == 'Ranger') {
        updateSliderInput(session, inputId = "Strength",
                          value = 4, min = 4, max = 60, step = 1)
        updateSliderInput(session, inputId = "Stamina",
                          value = 8, min = 8, max = 84, step = 1)
        updateSliderInput(session, inputId = "Agility",
                          value = 10, min = 10, max = 120, step = 1)
        updateSliderInput(session, inputId = "Vitality",
                          value = 12, min = 12, max = 120, step = 1)
        updateSliderInput(session, inputId = "Intelligence",
                          value = 6, min = 6, max = 84, step = 1)
        updateSliderInput(session, inputId = "Spirituality",
                          value = 2, min = 2, max = 60, step = 1)
                } 
})

# Damage tab outputs
Slow_CAC_dmg <- reactive({
        if(input$Sword == TRUE){
                input$Strength*5 + input$Stamina*3 + input$Agility + 75
        } else {
                input$Strength*5 + input$Stamina*3 + input$Agility
        }
})

Fast_CAC_dmg <- reactive({
        if(input$Sword == TRUE){
                input$Strength + input$Stamina*3 + input$Agility*5 + 75
        } else {
                input$Strength + input$Stamina*3 + input$Agility*5
        }
})


Away_dmg <- reactive({
        if(input$Bow == TRUE){
                input$Intelligence + input$Stamina*3 + input$Agility*5 + 75
        } else {
                input$Intelligence + input$Stamina*3 + input$Agility*5
        }
})

Pw_spell_dmg <- reactive({
        if(input$Magicr == TRUE){
                input$Stamina + input$Intelligence*3 + input$Spirituality*5 + 75
        } else {
                input$Stamina + input$Intelligence*3 + input$Spirituality*5
        }
})

Lw_spell_dmg <- reactive({
        if(input$Magicr == TRUE){
                input$Intelligence*2 + input$Spirituality*5 + 75
        } else {
                input$Intelligence*2 + input$Spirituality*5
        }
})

Dmg_grp <- reactive({
        c(Slow_CAC_dmg(),Fast_CAC_dmg(),Away_dmg(),Pw_spell_dmg(), Lw_spell_dmg())
})

Dmg_type <- c("Heavy infighting damages","Fast infighting damages",
              "Away damages", "Powerfull spell", "Simple spell")

output$Damages <- renderPlot({barplot(Dmg_grp(),
                                      names.arg = Dmg_type, ylim = c(0,max(Dmg_grp()+50)),
                                 main = "Damages by type")
        text(0.70, Slow_CAC_dmg(), round(Slow_CAC_dmg()), pos = 3, cex =1)
        text(1.90, Fast_CAC_dmg(), round(Fast_CAC_dmg()), pos = 3, cex = 1)
        text(3.10, Away_dmg(), round(Away_dmg()), pos = 3, cex = 1)
        text(4.30, Pw_spell_dmg(), round(Pw_spell_dmg()), pos = 3, cex = 1)
        text(5.50, Lw_spell_dmg(), round(Lw_spell_dmg()), pos = 3, cex = 1)
 })

  
# Health tab outputs
Health_point <- reactive({
        100 * (1+((if(input$Age > 80){-1}else{1})*(input$Age/100))) +
                2*input$Vitality +
                0.5*input$Strength
})

output$Health_bar <- renderPlot({barplot(Health_point(), horiz=TRUE,
                                         xlim = c(0,Health_point()+100), col = "red",
                                         main = "Health Bar")
                text(Health_point(), 0.7, round(Health_point()), pos = 4, cex = 1)
})

Pr <- reactive({if(input$Armor == TRUE){
        ((input$Stamina + input$Strength + 75) / 
                         (input$Stamina + input$Strength + 75 + input$Vitality))*100
} else {
        ((input$Stamina + input$Strength) / 
                 (input$Stamina + input$Strength + input$Vitality))*100       
        }
})

Ar <- reactive({if(input$Armor == TRUE){
        ((input$Agility + input$Stamina + 50) / 
                         ((input$Agility + input$Stamina) + 50 + input$Vitality))*100
} else {
        ((input$Agility + input$Stamina) / 
                 ((input$Agility + input$Stamina) + input$Vitality))*100
        }
})

Mr <- reactive({if(input$Armor == TRUE & input$Magicr == TRUE){
        ((input$Intelligence + input$Spirituality + 25) / 
                         (input$Intelligence + input$Spirituality + 25 + input$Vitality))*100
} else if(input$Armor == TRUE & input$Magicr == FALSE){
        ((input$Intelligence + input$Spirituality + 5) / 
                 (input$Intelligence + input$Spirituality + 5 + input$Vitality))*100
} else if(input$Armor == FALSE & input$Magicr == TRUE){
        ((input$Intelligence + input$Spirituality + 20) / 
                 (input$Intelligence + input$Spirituality + 20 + input$Vitality))*100
} else { 
        ((input$Intelligence + input$Spirituality) / 
                 (input$Intelligence + input$Spirituality + input$Vitality))*100
        }
        
})

output$Pdmg_resistance <- renderPlot({pie(c(Pr(), 100-Pr()), 
                          main = paste("Physical Damage Resistance :", 
                                       round(Pr())," %", sep = " "), 
                                          col = c("red","white"),
                          labels = c("",""))
})

output$Admg_resitance <- renderPlot({pie(c(Ar(), 100-Ar()), 
                                          main = paste("Away Damage Resistance :", 
                                                       round(Ar())," %", sep = " "), 
                                          col = c("green","white"),
                                         labels = c("",""))
})


output$Magic_resitance <- renderPlot({pie(c(Mr(), 100-Mr()), 
                                           main = paste("Magical Damage Resistance :", 
                                                        round(Mr())," %", sep = " "), 
                                           col = c("blue","white"),
                                          labels = c("",""))
}) 

# Magic tab ouptus 
Mana_point <- reactive({
        100 * (1+((if(input$Age > 50){1}else{-1})*(input$Age/100))) +
                3*input$Spirituality +
                2*input$Intelligence
})

output$Mana_bar <- renderPlot({barplot(Mana_point(), horiz=TRUE,
                                         xlim = c(0,Mana_point() + 100), col = "blue",
                                         main = "Mana Bar")
        text(Mana_point(), 0.7, round(Mana_point()), pos = 4, cex = 1)
})


output$Nb_spell <- renderText({if(input$Intelligence >= 10){
        round(input$Intelligence / 10)
}else{0}
        
})

Lvl_spell <- reactive({if(input$Spirituality >= 10){
        round((input$Intelligence + 3*input$Spirituality) / 2)
}else{2}})

Spl <- reactive({seq(Lvl_spell())})

Cons <- reactive({if(input$Magicr == TRUE){
        Spl()*100/(0.5*input$Spirituality) - 100
}else{
        Spl()*100/(0.5*input$Spirituality)
        }
})

output$Level_spell <- renderText({Lvl_spell()})

output$Mana_cons <- renderPlot({plot(as.factor(Spl()), Cons(), type ="o", 
                                     lwd = 2, pch = 1, ylim = c(0,500),
                                     main = "Mana cost by level of spell",
                                     xlab = "Level of spell", ylab = "Mana cost")
        })
        
    
})
