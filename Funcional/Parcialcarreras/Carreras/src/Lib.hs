module Lib where

import Data.List

--1
data Auto= Auto {
    color:: Color,
    velocidad::Int,
    distanciaRecorrida::Int
} deriving (Show, Eq)

type Carrera=[Auto]

autoPrueba::Auto
autoPrueba = Auto {
    color= "rojo",
    velocidad=60,
    distanciaRecorrida=10
} 
 
--1a
estaCerca::Auto->Auto->Bool 
estaCerca auto otroAuto=((<10).distanciaEntre auto) otroAuto && auto /= otroAuto !!

 distanciaEntre::Auto->Auto->Int
distanciaEntre auto otroAuto= abs (distanciaRecorrida auto - distanciaRecorrida otroAuto)

--1b
vaTranquilo::Auto->Carrera->Bool
vaTranquilo auto carrera= (not. any (estaCerca auto)) carrera && leVaGanandoATodos auto carrera

leVaGanandoATodos::Auto->Carrera->Bool
leVaGanandoATodos auto=all (leVaGanando auto). filter (/= auto)

leVaGanando::Auto->Auto->Bool
leVaGanando auto otroAuto= distanciaRecorrida auto > distanciaRecorrida otroAuto

--1c
puestoAuto:: Carrera->Auto->Int
puestoAuto carrera auto =1 + cantAutosQueLeGananA auto carrera

cantAutosQueLeGananA::Auto->Carrera->Int
cantAutosQueLeGananA auto carrera= (length.leGananAlAuto auto) carrera

leGananAlAuto::Auto->Carrera->Carrera
leGananAlAuto auto carrera= filter (flip leVaGanando auto) carrera

--2a
correrCiertoTiempo::Int->Auto->Auto
correrCiertoTiempo tiempo auto= auto {distanciaRecorrida=distanciaRecorrida auto + tiempo * velocidad auto}

--2b
type Modificador=Int->Int

modificador::Modificador
modificador=  max 0

alterarVelocidad::Auto->Modificador->Auto
alterarVelocidad auto modificador = auto{velocidad = modificador (velocidad auto)}

bajarVelocidad::Int->Auto->Auto
bajarVelocidad cantidad auto = auto {velocidad=modificador (velocidad auto-cantidad)}

--3
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

data PowerUp= PowerUp {
criterioPower::Auto->Auto->Bool,
efectoPower::Auto->Auto
} 

usarPowerUp::PowerUp->Auto->Carrera->Carrera
usarPowerUp powerUp auto carrera= afectarALosQueCumplen (criterioPower powerUp auto) (efectoPower powerUp) carrera

terremoto::PowerUp
terremoto=PowerUp {criterioPower=estaCerca,  efectoPower=efectoTerremoto}
efectoTerremoto::Auto->Auto
efectoTerremoto auto= bajarVelocidad 50 auto 

miguelitos::Int->PowerUp
miguelitos cantidad=PowerUp{criterioPower=leVaGanando, efectoPower=efectoMiguelitos cantidad}
efectoMiguelitos::Int->Auto->Auto
efectoMiguelitos cantidad auto= bajarVelocidad cantidad auto

jetPack::Int->PowerUp
jetPack tiempo=PowerUp{criterioPower=sonIguales, efectoPower=efectoJetPack tiempo}
efectoJetPack::Int->Auto->Auto
efectoJetPack tiempo auto= dividirVelocidad (correrCiertoTiempo tiempo auto{velocidad=velocidad auto*2})
sonIguales::Auto->Auto->Bool
sonIguales auto otroAuto= color auto==color otroAuto
dividirVelocidad :: Auto -> Auto
dividirVelocidad auto = bajarVelocidad (div (velocidad auto) 2) auto

--4
type Evento = Carrera -> Carrera

--4.a
simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera carrera eventos = (puestosYColoresEn.carreraPostEventos carrera) eventos

type Color= String
puestoYColor::Carrera->Auto->(Int, Color)
puestoYColor carrera auto = (puestoAuto carrera auto , color auto)
puestosYColoresEn :: Carrera -> [(Int,Color)]
puestosYColoresEn carrera = map (puestoYColor carrera) carrera

carreraPostEventos :: Carrera -> [Evento] -> Carrera
carreraPostEventos carrera eventos = foldl (\race event -> event race) carrera eventos

--4.b
correnTodos::Int->Carrera->Carrera
correnTodos tiempo carrera= map (correrCiertoTiempo tiempo)  carrera

usaPowerUp::PowerUp->Color->Carrera->Carrera
usaPowerUp powerUp color carrera= usarPowerUp powerUp (autoColor color carrera) carrera

autoColor::Color->Carrera->Auto
autoColor colorBuscado carrera=(head .filter ((==colorBuscado).color)) carrera

--4.c
autoRojo :: Auto
autoRojo = Auto {velocidad = 120, distanciaRecorrida = 0, color = "Rojo"}
autoBlanco :: Auto
autoBlanco = Auto {velocidad = 120, distanciaRecorrida = 0, color = "Blanco"}
autoAzul :: Auto
autoAzul = Auto {velocidad = 120, distanciaRecorrida = 0, color = "Azul"}
autoNegro :: Auto
autoNegro = Auto {velocidad = 120, distanciaRecorrida = 0, color = "Negro"}

carreraLista :: Carrera
carreraLista = [autoRojo,autoBlanco,autoAzul,autoNegro]

eventosCarrera::[Evento]
eventosCarrera = [correnTodos 30, usaPowerUp (jetPack 3) "Azul" , usaPowerUp terremoto "Blanco" ,
   correnTodos 40, usaPowerUp (miguelitos 20) "Blanco" , usaPowerUp (jetPack 6) "Negro" , correnTodos 10]