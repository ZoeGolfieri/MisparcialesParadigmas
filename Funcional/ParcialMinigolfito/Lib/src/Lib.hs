module Lib where

import Data.List
import Text.Show.Functions

data Participante = Participante {
nombre      :: String,
nombrePadre :: String,
habilidades :: Habilidad
} deriving (Show, Eq)

data Habilidad = Habilidad {
fuerza    :: Int, 
presicion :: Int
} deriving (Show, Eq)

bart = Participante "Bart" "Homero" (Habilidad 25 60)
todd = Participante "Todd" "Ned" (Habilidad 15 80)
rafa = Participante "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = Tiro {
velocidadTiro :: Int,
presicionTiro :: Int,
alturaTiro    :: Int
} deriving (Show, Eq)

-----Punto 1.a-----
type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = Tiro 10 (presicion habilidad * 2 ) 0 

madera :: Palo
madera habilidad = Tiro 100 (div (presicion habilidad) 2) 5 

hierros :: Int->Palo
hierros n habilidad = Tiro  (fuerza habilidad * n) (div (presicion habilidad)  n)  (max 0 (n-3)) 

-----Punto 1.b-----
type Palos = [Palo]

palos :: Palos
palos = [putter, madera ] ++ map hierros [1..10]

-----Punto 2-----
golpe :: Participante -> Palo -> Tiro
golpe persona palo = palo (habilidades persona)

-----Punto 3-----
between n m x = elem x [n..m]

data Obstaculo = Obstaculo {
        superaObstaculo :: Tiro -> Bool,
        efectoObstaculo :: Tiro -> Tiro
}

-----Punto 3.a-----
tunelConRampita :: Obstaculo
tunelConRampita = Obstaculo {superaObstaculo = superaTunel , efectoObstaculo = efectoTunel}

superaTunel :: Tiro -> Bool
superaTunel tiro = presicionTiro tiro > 90 && rasDelSuelo tiro 

efectoTunel :: Tiro -> Tiro
efectoTunel tiro  
        | superaTunel tiro = Tiro (velocidadTiro tiro * 2) 100 0                       
        | otherwise        = reiniciarTiro tiro

-----Punto 3.b-----
laguna :: Int -> Obstaculo
laguna largoLaguna = Obstaculo {superaObstaculo = superaLaguna , efectoObstaculo = efectoLaguna largoLaguna}

superaLaguna :: Tiro -> Bool
superaLaguna tiro = velocidadTiro tiro > 80 && between 1 5  (alturaTiro tiro) 

efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largoLaguna tiro 
        | superaLaguna tiro = Tiro (velocidadTiro tiro) (presicionTiro tiro)  (div (alturaTiro tiro) largoLaguna)
        | otherwise                     = reiniciarTiro tiro

-----Punto 3.c-----
hoyo :: Obstaculo
hoyo = Obstaculo {superaObstaculo = superaHoyo , efectoObstaculo = efectoHoyo}

superaHoyo :: Tiro -> Bool
superaHoyo tiro = between 5 20 (velocidadTiro tiro) && rasDelSuelo tiro && presicionTiro tiro > 95

efectoHoyo :: Tiro -> Tiro
efectoHoyo tiro 
        | superaHoyo tiro = reiniciarTiro tiro
        | otherwise       = reiniciarTiro tiro

-----Funciones punto 3-----
rasDelSuelo :: Tiro -> Bool
rasDelSuelo tiro = alturaTiro tiro == 0 

reiniciarTiro :: Tiro -> Tiro
reiniciarTiro tiro = Tiro 0 0 0

-----Punto 4.a-----
palosUtiles :: Participante -> Obstaculo -> Palos
palosUtiles participante obstaculo = filter (paloSupera participante obstaculo) palos

paloSupera :: Participante -> Obstaculo -> Palo  -> Bool
paloSupera participante obstaculo palo  = superaObstaculo obstaculo (golpe participante palo)

-----Punto 4.b-----
obstaculosConsecutivosSuperar :: Tiro -> [Obstaculo]  -> Int
obstaculosConsecutivosSuperar tiro = length . takeWhile (flip superaObstaculo tiro)

-----Punto 4.c-----
{-Definir paloMasUtil que recibe una persona y una lista de obstáculos y determina 
cuál es el palo que le permite superar más obstáculos con un solo tiro. -}
maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

paloMasUtil :: Participante -> [Obstaculo] -> Palo
paloMasUtil participante obstaculos = maximoSegun (flip obstaculosConsecutivosSuperar obstaculos . golpe participante ) palos

-----Punto 5-----
type Puntos = Int

listaPadresPierden :: [(Participante, Puntos)] -> [String]
listaPadresPierden jugadores = map (nombrePadre.fst) (filter (not . jugadorGano jugadores) jugadores)

jugadorGano :: [(Participante, Puntos)] -> (Participante, Puntos) ->  Bool
jugadorGano jugadores  jugador   = all (< snd jugador ) (map snd ((filter (/= jugador) jugadores)))
