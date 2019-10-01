# Configurar cada N periodo con CronR a través de Rstudio Server  
# La librerái 


#Librerías
	library(cronR); library(twitteR);library(tidyverse)

#Log CronR
	#system.file("extdata", "Consulta Twitter.log", package = "cronR")

#Acceso a Twitter 
	consumerkey <- "CONSUMERKEY"
	consumersecret <- "CONSUMERSECRET"
	accesstoken <- "ACCESSTOKEN"
	accessTokenSecret <- "ACCESSTOKENSECRET"
 	setup_twitter_oauth(consumerkey, consumersecret, accesstoken, accessTokenSecret)


#Busquedas
	search1 = twitteR::searchTwitter('BUSQUEDA 1', #Busqueda 1
										n = 1e4,  
										retryOnRateLimit = 200)  
	search2 = twitteR::searchTwitter('BUSQUEDA 2', #Busqueda 2
										n = 1e4,  
										retryOnRateLimit = 200)  
	search3 = twitteR::searchTwitter('BUSQUEDA 3', #Busqueda 3
										n = 1e4,  
										retryOnRateLimit = 200)  

# Estructuración Data 
	Data1 = twitteR::twListToDF(search1)
	Data2 = twitteR::twListToDF(search2)
	Data3 = twitteR::twListToDF(search3)

	Data_Consolidada <- Data1 %>% 
	  bind_rows(Data2) %>% 
	  bind_rows(Data3) 
  
    
#Juntar con data anterior y eliminar duplicados 
	new <- readRDS("/Monitoreo.RDS") #Lee data anterior
	new <- bind_rows(new,Data_Consolidada) %>%   #elimina tweets duplicados 
  	distinct()

#Limpieza 
	remove(newc,Data1,Data2,Data3,search1,search2,search3,accesstoken,
	       accessTokenSecret,consumerkey,consumersecret)

#Guardado Data
saveRDS(new, "/Monitoreo.RDS")
saveRDS(new, "/Monitoreo_respaldo.RDS")