module Lib where

import Data.List
import Text.Show.Functions

----Punto 1----

data Personaje = Personaje{
edad :: Int,
energia :: Int,
habilidades :: [String],
nombre :: String,
planeta :: String
} deriving (Show)

data Guantelete = Guantelete{
material :: String,
gemas :: [Gema]
} deriving (Show)

type Gema = Personaje -> Personaje

type Universo = [Personaje]

{-Los fabricantes determinaron que cuando un guantelete está completo -es decir, tiene las 6 gemas 
posibles- y su material es “uru”, se tiene la posibilidad de chasquear un universo que contiene a 
todos sus habitantes y reducir a la mitad la cantidad de dichos personajes-}

guanteleteCompletoYMaterialuru :: Guantelete -> Bool
guanteleteCompletoYMaterialuru guantelete = length (gemas guantelete) == 6 && (material guantelete) == "uru"

reducirMitadUniverso ::  Universo -> Universo
reducirMitadUniverso universo = take  (div (length universo) 2) universo

chasquearUniverso :: Guantelete -> Universo -> Universo
chasquearUniverso guantelete universo 
    | guanteleteCompletoYMaterialuru guantelete = reducirMitadUniverso universo
    | otherwise                                 = universo

----Punto 2a----

universoAptoPendex :: Universo -> Bool
universoAptoPendex universo = any (personajeMenor45Años) universo

personajeMenor45Años::Personaje->Bool
personajeMenor45Años personaje = edad personaje < 45

----Punto 2b----

energiaTotalUniverso :: Universo -> Int
energiaTotalUniverso universo = sumatoriaDeEnergias  . personajesMasDeUnaHabilidad $ universo

personajesMasDeUnaHabilidad :: Universo -> Universo
personajesMasDeUnaHabilidad personajes = filter (masDeUnaHabilidad) personajes

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad personaje = length (habilidades personaje) > 1

sumatoriaDeEnergias :: Universo -> Int
sumatoriaDeEnergias  = (sum) . map (energia) 

----Punto 3----

laMente :: Int -> Gema
laMente = restarEnergia 

elAlma :: String -> Gema
elAlma habilidad personaje = restarEnergia 10 . eliminarHabilidad habilidad $ personaje

restarEnergia :: Int -> Gema
restarEnergia valor personaje = personaje {energia = energia personaje - valor}

eliminarHabilidad :: String -> Gema
eliminarHabilidad habilidad personaje = personaje { habilidades = filter ( /= habilidad) (habilidades personaje) }

elEspacio :: String -> Gema
elEspacio planeta personaje  = restarEnergia 20 . transportarRival planeta $ personaje 

transportarRival:: String -> Gema
transportarRival nuevoPlaneta personaje =  personaje {planeta = nuevoPlaneta}

elPoder :: Gema
elPoder personaje = restarEnergia (energia personaje) . quitarHabilidades $ personaje

quitarHabilidades :: Gema
quitarHabilidades personaje 
        | length (habilidades personaje) <= 2 = personaje { habilidades = [] }
        | otherwise                           = personaje

elTiempo :: Gema
elTiempo personaje = personaje { edad = max 18 (div (edad personaje) 2)}

laGemaLoca :: Gema -> Gema
laGemaLoca gema = gema . gema

----Punto 4----
{-Dar un ejemplo de un guantelete de goma con las gemas tiempo, alma que quita la habilidad de 
“usar Mjolnir” y la gema loca que manipula el poder del alma tratando de eliminar la 
“programación en Haskell”.
-}

guanteleteDeGoma::Guantelete
guanteleteDeGoma = Guantelete "Goma" [elTiempo, elAlma "Usar Mjolnir", laGemaLoca (elAlma "programación en Haskell") ]

----Punto 5----

utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas personaje = foldl (aplicarPoderGema) personaje gemas

aplicarPoderGema :: Personaje -> Gema -> Personaje
aplicarPoderGema personaje gema = gema personaje

----Punto 6----

gemaMasPoderosa  :: Guantelete -> Personaje -> Gema
gemaMasPoderosa guantelete personaje = gemaDelInfinito personaje $ gemas guantelete

gemaDelInfinito ::  Personaje -> [Gema] -> Gema
gemaDelInfinito personaje [gema] = gema
gemaDelInfinito personaje (gema1:gema2:gemas) 
    | energia (aplicarPoderGema personaje gema1)  < energia (aplicarPoderGema personaje gema2)      = gemaDelInfinito personaje (gema1:gemas)
    | otherwise                                                                                     = gemaDelInfinito personaje (gema2:gemas)

personajePrueba :: Personaje
personajePrueba = Personaje 20 50  ["Hola", "Usar algo"] "prueba" "tierra"

----Punto 7----

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

{-
--gemaMasPoderosa personajePrueba guanteleteDeLocos: No se puede ya que nunca va a terminar de procesar la lista de gemas, 
por lo que nunca nos va a dar el valor de la gema mas poderosa
--usoLasTresPrimerasGemas guanteleteDeLocos personajePrueba : Se puede ya que de una lista infinita tomo 3 valores 
y se los aplico al parametro
-}

