##Tarea 2 Regresion logistica
#Carga paquetes
install.packages("pacman")
pacman::p_load(haven, sjPolt, car, dplyr,magrittr, sjmisc)

##Cargar datos
base_enusc_2020_sav <- read_sav("input/data/base-enusc-2020-sav.sav")

#Explorar datos
modelo1<-Enusc_2020 %>%
    select(P1_1_1, enc_region)
  #Recodificacion

frq(modelo1$P1_1_1)
frq(modelo1$enc_region)

modelo1<- modelo1 %>% mutate(P1_recode = case_when(P1_1_1==1 ~ "Aumentó",
                                                      P1_1_1==3~ "Disminuyó",
                                                      TRUE~NA_character_), 
                             reg_recode =if_else(enc_region ==13, 1,0))
frq(modelo1$P1_recode)
frq(modelo1$reg_recode)
#holaa