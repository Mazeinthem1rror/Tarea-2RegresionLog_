##Tarea 2 Regresion logistica
#Estudiantes: Josefa Espinoza, Mistian Herrera, Maximiliano Levenier y Macarena Pol.
#Carga paquetes
install.packages("pacman")
pacman::p_load(haven, sjPlot, car, dplyr,magrittr, sjmisc, 
               ResourceSelection,DescTools, performance)
install.packages("haven")
install.packages("ResourceSelection")
install.packages("DescTools")
install.packages("performance")
install.packages("sjPlot")
install.packages("car")
library("car")
library("haven")
library("ResourceSelection")
library("DescTools")
library("performance")
library("sjPlot")
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


Sexorecode = recode(data_proc$rph_sexo, "2=1 ; 1=0")
table(Sexorecode)

RegionesTarapaca = recode(data_proc$enc_region, "1=1;else=0")
table(RegionesTarapaca)

RegionesMetropolitana = recode(data_proc$enc_region, "13=1;else=0")
table(RegionesMetropolitana)

RegionesConcepcion = recode(data_proc$enc_region, "8=1;else=0")
table(RegionesConcepcion)

VICefectiva = recode(data_proc$A1_1_1, "1=1; 2=0; else=NA")
table(VICefectiva)

Percepcionseguridad = recode(data_proc$P3_1_1, "1=1; 2=0; else=NA")
table(Percepcionseguridad)

Delbarrio = recode(data_proc$P1_3_1, "1=1; 2=0; 3=0; else=NA")
table(Delbarrio)

DELpais = recode(data_proc$P1_1_1, "1=1; 2=0; 3=0; else=NA")
table(DELpais)

#Modelo regresi�n log�stica----------------------------------------

modelo_0 <- glm(Percepcionseguridad~1, data = data_proc, family = binomial)
modelo_1 <- glm(Percepcionseguridad~rph_edad+Sexorecode+VICefectiva, data = data_proc, family = binomial)
summary(modelo_1)
summary(modelo_0)
modelo_2 <- glm(Percepcionseguridad~rph_edad+Sexorecode+VICefectiva+RegionesConcepcion+RegionesTarapaca+RegionesMetropolitana+Delbarrio+DELpais, data = data_proc, family = binomial)
summary(modelo_2)

exp(modelo_0$coefficients)
exp(modelo_1$coefficients)
exp(modelo_2$coefficients)

##Bondad de ajuste-------------------------------------------

##Chi cuadrado y Likelihood ratio
### Tabla bonita, pero sin bondad de ajuste :(
sjPlot::tab_model(list(modelo_0, modelo_1, modelo_2), 
                  show.ci=FALSE,
                  show.loglik = TRUE,
                  auto.label = TRUE,
                  transform = 'exp', 
                  p.style = "stars",
                  show.p = TRUE,
                  df.method = 'wald',
                  dv.labels = c("Modelo nulo", "Modelo 1","Modelo 2"),
                  string.pred = "Predictores", string.est = "??",
                  encoding =  "UTF-8")

##Porcentaje de casos predichos


