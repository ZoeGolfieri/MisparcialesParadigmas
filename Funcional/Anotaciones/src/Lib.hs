module Lib where
import Data.List
import Text.Show.Functions

doble numero = numero * 2
----FUNCIONES PRINCIPIO UTILES----
{-
cambiarEpiteto funcion heroe = heroe {epiteto = funcion (epiteto heroe)}
----------------------------------------------------------------------------------------------------------------
restarEnergia :: Int -> Gema
restarEnergia valor personaje = personaje {energia = energia personaje - valor}
----------------------------------------------------------------------------------------------------------------
eliminarHabilidad :: String -> Gema
eliminarHabilidad habilidad personaje = personaje { habilidades = filter ( /= habilidad) (habilidades personaje) }
----------------------------------------------------------------------------------------------------------------
agregarArtefacto unArtefacto unHeroe = cambiarArtefactos (unArtefacto : ) unHeroe
-}


----FUNCIONES UTILES PARCIALES HECHOS----
{-
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista
--------------------------------------------------------------------------------------------
zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _  []   []   = []
zipWithIf _ _  _    []   = []
zipWithIf _ _  [] (y:ys) = (y:ys)
zipWithIf operador condicion (x:xs) (y:ys)
        | (not . condicion) y = y : zipWithIf operador condicion (x:xs) ys
        | otherwise           = (operador x y) : zipWithIf operador condicion xs ys
---------------------------------------------------------------------------------------------
between n m x = elem x [n..m]
---------------------------------------------------------------------------------------------
maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b
---------------------------------------------------------------------------------------------
  takeWhile :: (a -> Bool) -> [a] -> [a] creates a list from another one, it inspects the 
  original list and takes from it its elements to the moment when the condition fails, then it stops processing
---------------------------------------------------------------------------------------------
deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2
-}

----DEFINIR---
{-
heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [ Artefacto "pistola" 1000, elRelampagoDeZeus] [matarAlLeonDeNemea]
----------------------------------------------------------------------------------------------------------------
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)
---------------------------------------------------------------------------------------------
data PowerUp= PowerUp {
criterioPower::Auto->Auto->Bool,
efectoPower::Auto->Auto} 
-}

{-
http://aprendehaskell.es/main.html
http://aprendehaskell.es/content/Recursion.html#unas-cuantas-funciones-recursivas-mas
http://aprendehaskell.es/content/OrdenSuperior.html#composicion-de-funciones
http://aprendehaskell.es/content/OrdenSuperior.html
http://aprendehaskell.es/content/Funciones.html#ajuste-de-patrones
-}





