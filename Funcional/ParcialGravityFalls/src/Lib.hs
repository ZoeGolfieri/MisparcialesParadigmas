module Lib where
import Data.List
import Text.Show.Functions

----Punto 1----

{-Modelar a las personas, de las cuales nos interesa la edad, cuáles son los ítems que tiene y 
la cantidad de experiencia que tiene; y a las criaturas teniendo en cuenta lo descrito anteriormente, y 
lo que queremos hacer en el punto siguiente.
criaturas, de las cuales nos interesa poder determinar cuál es su nivel de peligrosidad y qué tiene que cumplir 
una persona para deshacerse de ellas.
-}
data Persona = Persona {
    edad :: Int,
    items :: [Item],
    cantidadExperiencia :: Int
} deriving (Show, Eq)

data Criatura = Criatura {
    nivelPeligrosidad ::  Int,
    debilidades :: [Debilidad]
} deriving (Show)

type Debilidad = Persona -> Bool
type Item = String

personaTieneItem :: Item -> Debilidad
personaTieneItem item  = elem item . items 

siempredetras :: Criatura
siempredetras   = Criatura 0 []

gnomos :: Int -> Criatura
gnomos cantidad = Criatura (2 ^ cantidad) [personaTieneItem "Soplador de hojas"]

fantasma :: Int -> [Debilidad] -> Criatura
fantasma categoria debilidades     = Criatura (20 * categoria) debilidades

----Punto 2----
cambiarExperiencia funcion persona = persona {cantidadExperiencia = funcion (cantidadExperiencia persona)}

superaDebilidad :: Persona -> Debilidad -> Bool
superaDebilidad persona debilidad = debilidad persona

superaDebilidades :: Persona -> Criatura -> Bool
superaDebilidades persona criatura = all (superaDebilidad persona) (debilidades criatura)

enfrentamiento :: Persona -> Criatura -> Persona
enfrentamiento persona criatura 
        | superaDebilidades persona criatura = cambiarExperiencia (nivelPeligrosidad criatura +) persona
        | otherwise                          = cambiarExperiencia (1+)                           persona

----Punto 3.a----
experienciaQueGana :: Persona -> [Criatura] -> Int
experienciaQueGana persona criaturas = cantidadExperiencia (enfrentarSucesivasCriaturas persona criaturas) - cantidadExperiencia persona

enfrentarSucesivasCriaturas :: Persona -> [Criatura] -> Persona
enfrentarSucesivasCriaturas persona criaturas = foldl (enfrentamiento) persona criaturas

----Punto 3.b----
personaMenorQue :: Int -> Debilidad
personaMenorQue ciertaEdad = (< ciertaEdad) . edad

experienciaMayorA :: Int -> Debilidad
experienciaMayorA numero = (> numero) . cantidadExperiencia

listaCriaturas = [siempredetras,  gnomos 10, fantasma 3 [personaMenorQue 13, personaTieneItem "Disfraz de oveja"], fantasma 1 [experienciaMayorA 10] ]

personaPrueba = Persona 14 ["Disfraz de oveja", "Soplador de hojas"] 20

----Segunda parte----

----Punto 1----

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _  []   []   = []
zipWithIf _ _  _    []   = []
zipWithIf _ _  [] (y:ys) = (y:ys)
zipWithIf operador condicion (x:xs) (y:ys)
        | (not . condicion) y = y : zipWithIf operador condicion (x:xs) ys
        | otherwise           = (operador x y) : zipWithIf operador condicion xs ys

----Punto 2.a----

abecedario :: [Char]
abecedario = ['a'..'z']

cantidadHastaLetra letra  = length ['a'..letra]
abecedarioDesde :: Char -> [Char]
abecedarioDesde letra = drop ((cantidadHastaLetra letra)-1) abecedario ++ take ((cantidadHastaLetra letra)-1) abecedario

----Punto 2.b----

desencriptarLetra :: Char -> Char -> Char
desencriptarLetra letraClave letra = head (drop (distanciaLetraClave letraClave) (abecedarioDesde letra))

distanciaLetraClave :: Char -> Int
distanciaLetraClave letraClave =  length (drop (cantidadHastaLetra letraClave - 1) abecedario)

----Punto 2.c----
cesar :: Char -> String -> String
cesar letraClave = zipWithIf (desencriptarLetra) (esletra) (repeat letraClave)

esletra caracter = elem caracter abecedario

----Punto 2.d----
consulta :: String -> [String]
consulta textoADesencriptar = map (flip cesar textoADesencriptar) abecedario

----Punto 3----
vigenere :: String -> String -> String
vigenere textoClave  = zipWithIf (desencriptarLetra) (esletra) (cycle textoClave)

