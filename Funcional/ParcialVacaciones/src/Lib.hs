module Lib where
import Data.List
import Text.Show.Functions

----Punto 1----
data Turista = Turista {
nivelCansancio   :: Int,
nivelStress      :: Int,
viajaSolo        :: Bool,
idiomasQueHabla  :: [String]
} deriving (Show, Eq)

ana :: Turista
ana = Turista 0 21 False ["Espaniol"]

beto :: Turista
beto = Turista 15 15 True ["Aleman"]

cathi :: Turista
cathi = Turista 15 15 True ["Aleman", "Catalan"]

----Punto 2: Funciones utiles----
type Excursiones = [Excursion]
type Excursion = Turista -> Turista

agregarExcursion :: Excursion -> Excursiones -> Excursiones
agregarExcursion excursion listaexcursiones = excursion : listaexcursiones

cambiarNivelStress funcion turista    = turista {nivelStress = funcion (nivelStress turista)}
restarNivelStress numero turista       = turista {nivelStress = nivelStress turista - numero}

cambiarNivelCansancio funcion turista = turista {nivelCansancio = funcion (nivelCansancio turista)}
restarNivelCansancio numero turista    = turista {nivelCansancio = nivelCansancio turista - numero}

sumarIdiomas idioma turista 
    | notElem (idioma) (idiomasQueHabla turista) =  turista {idiomasQueHabla = idioma : idiomasQueHabla turista}
    | otherwise                                  =  turista

acompaniado turista = turista { viajaSolo = False}

----Punto 2: Excursiones----
irALaPlaya :: Excursion
irALaPlaya turista
                    | viajaSolo turista = cambiarNivelCansancio (max 0) . (restarNivelCansancio 5 ) $ turista
                    | otherwise         = cambiarNivelStress    (max 0) . (restarNivelStress 1 )    $ turista

apreciarElementoPaisaje :: String -> Excursion
apreciarElementoPaisaje elemento = cambiarNivelStress (max 0) . (restarNivelStress (length elemento)) 

salirAHablarIdioma :: String -> Excursion
salirAHablarIdioma idioma turista = sumarIdiomas idioma . acompaniado $ turista

caminarCiertosMinutos :: Int -> Excursion
caminarCiertosMinutos minutos = cambiarNivelCansancio (+ nivelIntensidad minutos) . restarNivelStress (nivelIntensidad minutos) 

nivelIntensidad :: Int -> Int
nivelIntensidad minutos = div minutos 4

paseoEnBarco :: String -> Excursion
paseoEnBarco marea
        | marea == "Fuerte"    = cambiarNivelStress (+ 6) . cambiarNivelCansancio (+ 10 )
        | marea == "Moderada"  = id
        | marea == "Tranquila" = salirAHablarIdioma "Aleman" . apreciarElementoPaisaje "mar" . caminarCiertosMinutos 10 

----Punto 2.a----
hacerExcursion ::  Turista ->  Excursion -> Turista
hacerExcursion turista excursion  = restarNivelStress (div (nivelStress turista * 10)  100). excursion $ turista

----Punto 2.b----
deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

type Indice = Turista -> Int

stress :: Indice
stress turista = nivelStress turista

cansancio :: Indice
cansancio turista = nivelCansancio turista

deltaExcursionSegun indice turista excursion = deltaSegun indice (hacerExcursion turista excursion) (turista) 

----Punto 2.c----
excursionEducativa :: Turista -> Excursion ->  Bool
excursionEducativa  turista = (>= 1) . deltaExcursionSegun (length . idiomasQueHabla) turista  

largoListaIdiomas :: Indice
largoListaIdiomas turista = length (idiomasQueHabla turista)

excursionDesestresante :: Turista -> Excursion ->  Bool
excursionDesestresante turista  = (<= -3). deltaExcursionSegun (stress) turista  

excursionesDesestresantes :: Turista -> Excursiones -> Excursiones
excursionesDesestresantes turista = filter (excursionDesestresante turista)

----Punto 3----
type Tour = Excursiones

completo :: Tour
completo = [caminarCiertosMinutos 20,  apreciarElementoPaisaje "cascada" ,  caminarCiertosMinutos 40, irALaPlaya, salirAHablarIdioma "melmacquiano"]

ladoB :: Excursion -> Tour
ladoB excursion = [ paseoEnBarco "Tranquila", excursion, caminarCiertosMinutos 120]

islaVecina marea = [paseoEnBarco marea, excursionIslaVecina marea, paseoEnBarco marea]

excursionIslaVecina :: String -> Excursion
excursionIslaVecina marea
    | marea == "Fuerte" = apreciarElementoPaisaje "lago"
    | otherwise         = irALaPlaya

----Punto 3.a----

hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour = foldl (hacerExcursion) (cambiarNivelStress (+ (length tour)) turista) tour

----Punto 3.b----
tourConvincente :: Turista -> [Tour] ->  Bool
tourConvincente turista = any (esConvicente turista)

esConvicente :: Turista -> Tour ->  Bool
esConvicente turista = any (dejaAcompaniado turista) . excursionesDesestresantes turista

dejaAcompaniado :: Turista -> Excursion -> Bool
dejaAcompaniado turista = not . viajaSolo . hacerExcursion turista

----Punto 3.c----

efectividadTour :: Tour -> [Turista] -> Int
efectividadTour tour  = sum . map (espiritualidadRecibida tour) . filter (flip esConvicente tour) 

espiritualidadRecibida ::  Tour -> Turista -> Int
espiritualidadRecibida tour  = negate . sum . deltaRutina tour 

deltaRutina :: Tour -> Turista -> [Int]
deltaRutina tour turista =  map (deltaExcursionSegun (indiceStressYCansancio) turista) tour

indiceStressYCansancio :: Indice
indiceStressYCansancio turista = nivelCansancio turista + nivelStress turista

----Punto 4----
{-Construir un tour donde se visiten infinitas playas.
¿Se puede saber si ese tour es convincente para Ana? ¿Y con Beto? Justificar.
¿Existe algún caso donde se pueda conocer la efectividad de este tour? Justificar.
-}
infinitasPlayas = repeat irALaPlaya

--No se puede saber ya que nunca va a terminar de procesarlo
--No, excepto que se consulte con una lista vacia de turistas que dara 0