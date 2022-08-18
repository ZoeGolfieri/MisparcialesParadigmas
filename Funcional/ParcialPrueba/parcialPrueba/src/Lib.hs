module Lib where
import Text.Show.Functions
import Data.Char

data Barbaro=Barbaro{
    nombreBarbaro::String,
    fuerzaBarbaro::Int,
    habilidades::Habilidades,
    objetos::[Objetos]
} deriving (Show)

type Objetos=Barbaro->Barbaro

type Habilidades=[String]

dave::Barbaro
dave=Barbaro{
    nombreBarbaro= "Dave",
    fuerzaBarbaro=100,
    habilidades=["tejer"],
    objetos=[varitasDefectuosas]
} 

espadas::Int->Objetos
espadas pesoEspada barbaro=barbaro {fuerzaBarbaro=fuerzaBarbaro barbaro+pesoEspada*2}

amuletosMisticos::String->Objetos
amuletosMisticos habilidad barbaro= barbaro{habilidades=[habilidad]++habilidades barbaro}

varitasDefectuosas::Objetos
varitasDefectuosas barbaro=barbaro {habilidades=["hacer magia"]++habilidades barbaro, objetos=[]}

ardilla::Objetos
ardilla barbaro=barbaro

cuerda::Barbaro->Objetos->Objetos->Barbaro
cuerda barbaro objeto1 objeto2=(objeto1.objeto2) $ barbaro

--Punto 2
megafono::Objetos
megafono barbaro=barbaro{habilidades= [concatMap (hacerMayusculaString) (habilidades barbaro)]}

hacerMayusculaString::String->String
hacerMayusculaString string=map (toUpper) string

--megafonoBarbarico::Objetos
--megafonoBarbarico

--Punto 3
type Evento=Barbaro->Bool
type Aventura=[Evento]

invasionDeSuciosDuendes::Evento
invasionDeSuciosDuendes barbaro= any (=="Escribir poesia atroz") (habilidades barbaro)

cremalleraDelTiempo::Evento
cremalleraDelTiempo barbaro= nombreBarbaro barbaro=="Faffy" || nombreBarbaro barbaro=="Astro"

--ritualDeFechorias::Barbaro->Aventura->Bool
--ritualDeFechorias barbaro aventura= aventura barbaro

saqueo::Evento
saqueo barbaro= fuerzaBarbaro barbaro>80 && any (=="robar") (habilidades barbaro)
gritoDeGuerra::Evento
gritoDeGuerra barbaro=length (concat (habilidades barbaro)) >= 4 * length (objetos barbaro)

caligrafia::Barbaro->Bool
caligrafia barbaro = tieneCaligrafiaPerfecta (habilidades barbaro)
                   
tieneCaligrafiaPerfecta::Habilidades->Bool
tieneCaligrafiaPerfecta unasHabilidades = todasHabilidadesMasDe3Vocales unasHabilidades && todasComienzanConMayuscula unasHabilidades
todasHabilidadesMasDe3Vocales::Habilidades->Bool
todasHabilidadesMasDe3Vocales unasHabilidades = all (tiene3Vocales) unasHabilidades
tiene3Vocales::String->Bool
tiene3Vocales unaHabilidad = length ((filter esVocal ) unaHabilidad)>3

todasComienzanConMayuscula::Habilidades->Bool
todasComienzanConMayuscula unasHabilidades=all (comienzanConMayuscula) unasHabilidades

esVocal :: Char -> Bool
esVocal char = elem char ['a', 'e', 'i', 'o', 'u']

comienzanConMayuscula::String->Bool
comienzanConMayuscula string=elem (head string) ['A'..'Z']

sobrevivientes::[Barbaro]->Aventura->[Barbaro]
sobrevivientes unosBarbaros unaAventura= filter (cumplenPruebas unaAventura) unosBarbaros

cumplenPruebas::Aventura->Barbaro->Bool
cumplenPruebas unaAventura unBarbaro=all (sobreviveAEvento unBarbaro) unaAventura

sobreviveAEvento::Barbaro->Evento->Bool
sobreviveAEvento unBarbaro unEvento=unEvento(unBarbaro)

--Punto 4