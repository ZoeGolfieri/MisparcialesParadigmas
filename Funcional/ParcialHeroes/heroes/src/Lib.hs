module Lib where

import Data.List
import Text.Show.Functions

----Punto 1----

data Heroe = Heroe{
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
} deriving (Show)

cambiarEpiteto funcion heroe = heroe {epiteto = funcion (epiteto heroe)}
cambiarReconomiento funcion heroe = heroe {reconocimiento = funcion (reconocimiento heroe)}
cambiarArtefactos funcion heroe = heroe {artefactos = funcion (artefactos heroe)}
cambiarTareas funcion heroe = heroe {tareas = funcion (tareas heroe)}

data Artefacto = Artefacto{
    nombreArtefacto :: String,
    rarezaArtefacto ::  Int
} deriving (Show)

----Punto 2----

nuevoEpiteto unEpiteto unHeroe = cambiarEpiteto (const unEpiteto) unHeroe
agregarArtefacto unArtefacto unHeroe = cambiarArtefactos (unArtefacto : ) unHeroe
nuevoEpitetoYArtefacto unEpiteto unArtefacto unHeroe = agregarArtefacto unArtefacto . nuevoEpiteto unEpiteto $ unHeroe

heroePasaALaHistoria :: Heroe -> Heroe
heroePasaALaHistoria heroe
    | (reconocimiento heroe) > 1000 = nuevoEpiteto "El mitico" heroe
    | (reconocimiento heroe) >= 500 =  nuevoEpitetoYArtefacto "El magnifico" lanzaDelOlimpo heroe
    | (reconocimiento heroe) > 100  = nuevoEpitetoYArtefacto "Hoplita" xiphos heroe
    | otherwise                     = heroe

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "lanzaDelOlimpo" 100

xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50

----Punto 3----

type Tarea = Heroe -> Heroe

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto unHeroe = agregarArtefacto unArtefacto. sumarReconocimiento (rarezaArtefacto unArtefacto) $ unHeroe

sumarReconocimiento :: Int -> Tarea
sumarReconocimiento unReconocimiento unHeroe = unHeroe {reconocimiento = unReconocimiento + reconocimiento unHeroe}

escalarElOlimpo :: Tarea
escalarElOlimpo unHeroe = agregarArtefacto elRelampagoDeZeus . desecharArtefactosPocaRareza. triplicarRarezaArtefactos. sumarReconocimiento 500 $ unHeroe

elRelampagoDeZeus :: Artefacto
elRelampagoDeZeus = Artefacto "El relampago de Zeus"  500

desecharArtefactosPocaRareza ::  Tarea
desecharArtefactosPocaRareza heroe = cambiarArtefactos (filter muchaRareza) heroe

muchaRareza :: Artefacto -> Bool
muchaRareza artefacto = rarezaArtefacto artefacto >= 1000

triplicarRarezaArtefactos :: Tarea
triplicarRarezaArtefactos heroe = cambiarArtefactos (map triplicarRareza) heroe

triplicarRareza::Artefacto -> Artefacto
triplicarRareza artefacto =  artefacto {rarezaArtefacto = 3 * rarezaArtefacto artefacto }

ayudarACruzarCalle :: Int -> Tarea
ayudarACruzarCalle unasCuadras unHeroe  = nuevoEpiteto ("Gros" ++ replicate unasCuadras 'o') unHeroe

data Bestia = Bestia {
    nombreBestia :: String,
    debilidad :: (Heroe->Bool) 
} deriving (Show)

matarBestia :: Bestia -> Tarea
matarBestia bestia heroe 
    | (debilidad bestia) heroe = nuevoEpiteto ("El asesino de " ++ nombreBestia bestia) heroe
    | otherwise                = nuevoEpiteto ("El cobarde")  .  cambiarArtefactos (drop 1) $ heroe

----Punto 4----

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [ Artefacto "pistola" 1000, elRelampagoDeZeus] [matarAlLeonDeNemea]

----Punto 5----

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea heroe = matarBestia leonDeNemea heroe

leonDeNemea :: Bestia
leonDeNemea = Bestia "Leon de Nemea" (epitetoMayorA20)

epitetoMayorA20 :: Heroe -> Bool
epitetoMayorA20 heroe = length (epiteto heroe) >= 20

----Punto 6----

realizarTarea :: Heroe -> Tarea -> Heroe
realizarTarea heroe tarea = agregarTarea tarea (tarea heroe)

agregarTarea :: Tarea -> Heroe -> Heroe
agregarTarea tarea heroe  = cambiarTareas (tarea : ) heroe

----Punto 7----

presumirLogros heroe1 heroe2
    | reconocimiento heroe1 > reconocimiento heroe2      = (heroe1, heroe2)
    | reconocimiento heroe2 > reconocimiento heroe1      = (heroe2, heroe1)
    | sumatoriaRarezas heroe1 >  sumatoriaRarezas heroe2 = (heroe1, heroe2)
    | sumatoriaRarezas heroe2 >  sumatoriaRarezas heroe1 = (heroe2, heroe1)
    | otherwise                                          = presumirLogros (realizarTareasDe heroe1 heroe2) (realizarTareasDe heroe2 heroe1)

sumatoriaRarezas :: Heroe -> Int
sumatoriaRarezas = (sum). map (rarezaArtefacto). artefactos

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe heroe1 heroe2 = realizarTareas (tareas heroe2) heroe1 

----Punto 8----

--Inifitimaente presumiendo, ya que no tienen tareas por realizar del otro

----Punto 9----

realizarTareas :: [Tarea] -> Heroe -> Heroe
realizarTareas unasTareas unHeroe = foldl (realizarTarea) unHeroe unasTareas

----Punto 10----

--No, porque se quedara infinitamente realizandola.