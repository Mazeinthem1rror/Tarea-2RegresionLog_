##Tarea 2 Regresion logistica
#Estudiantes: Josefa Espinoza, Mistian Herrera, Maximiliano Levenier y Macarena Pol.
#Carga paquetes
install.packages("pacman")
pacman::p_load(haven, sjPlot, car, dplyr,magrittr, sjmisc, 
               ResourceSelection,DescTools, performance)
install.packages("car")
library("car")

options(scipen = 999) 

##Cargar datos----------------------------------------------------------------
base_enusc_2020_sav <- read_sav("input/data/base-enusc-2020-sav.sav")


#Variables a trabajar----------------------------------------------------------
#P3_1_1-> ¿Cree ud que será victima de un delito en los proximos 12 meses?
#rph_edad-> Edad
#rph_sexo-> Sexo
#enc_region-> Región
#A1_1_1-> Durante los últimos doce meses, ¿usted o algún miembro de su hogar fue asaltado usando violencia, amenaza o intimidación? ¿Cuántas veces?
#P1_3_1-> (Barrio)pensando en la delincuencia,¿ud diria que la delincuencia en su barrio aumentó disminuyó o se mantuvo?
#P1_1_1-> (Pais) pensando en la delincuencia,¿ud diria que la delincuencia en su barrio aumentó disminuyó o se mantuvo?

#Recodificacion----------------------------------------------------------------
 data_proc = base_enusc_2020_sav %>%
  select(P3_1_1, rph_edad, rph_sexo, enc_region, A1_1_1, P1_3_1, P1_1_1)

reg_recode =if_else(enc_region ==13, 1,0)
frq(reg_recode)

Sexorecode = recode(data_proc$rph_sexo, "2=1 ; 1=0")
table(Sexorecode)
