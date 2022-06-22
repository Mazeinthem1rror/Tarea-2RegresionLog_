##Tarea 2 Regresion logistica
#Estudiantes: Josefa Espinoza, Mistian Herrera, Maximiliano Levenier y Macarena Pol.
#Carga paquetes
install.packages("pacman")
pacman::p_load(haven, sjPlot, car, dplyr,magrittr, sjmisc, 
               ResourceSelection,DescTools, performance)

options(scipen = 999) 

##Cargar datos----------------------------------------------------------------
base_enusc_2020_sav <- read_sav("input/data/base-enusc-2020-sav.sav")


#Variables a trabajar----------------------------------------------------------
#P3-> ¿Cree ud que será victima de un delito en los proximos 12 meses?
#R3-> Edad
#R4-> Sexo
#enc_region-> Región
#A1-> Durante los últimos doce meses, ¿usted o algún miembro de su hogar fue asaltado usando violencia, amenaza o intimidación? ¿Cuántas veces?
#P1_3_1-> (Barrio)pensando en la delincuencia,¿ud diria que la delincuencia en su barrio aumentó disminuyó o se mantuvo?
#P1_1_1-> (Pais) pensando en la delincuencia,¿ud diria que la delincuencia en su barrio aumentó disminuyó o se mantuvo?

#Recodificacion----------------------------------------------------------------

reg_recode =if_else(enc_region ==13, 1,0)
frq(reg_recode)

