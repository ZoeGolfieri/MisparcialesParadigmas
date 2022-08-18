import Text.Show.Functions()
-- para ver [ <function>, <function>, <function>]
type Color = String
type Tiempo = Int

data Auto = UnAuto {
    color :: Color,
    velocidad :: Int,
    distancia :: Int
} deriving (Show)

type Carrera = [Auto]

autoVioleta :: Auto
autoVioleta = UnAuto {color= "Violeta",velocidad = 50, distancia = 100}

autoRapido :: Auto
autoRapido = UnAuto {color= "Amarillo",velocidad = 5000, distancia = 2000}

autoLento :: Auto
autoLento = UnAuto {color= "Esmeralda",velocidad = 10, distancia = 99}

carreraGenerica :: Carrera
carreraGenerica = [autoRapido,autoVioleta,autoLento]

-- Funciones para delegar

sonIguales :: Auto -> Auto -> Bool
sonIguales auto1 auto2 = color auto1 == color auto2 

distanciaEntre :: Auto -> Auto -> Int
distanciaEntre auto1 auto2 = abs (distancia auto1 - distancia auto2)

estaPrimero :: Auto -> Carrera -> Bool
estaPrimero auto carrera = all (auto `leGanaA`) carrera

estaSolo :: Auto -> Carrera -> Bool
estaSolo auto carrera = all (not.estaCerca auto) carrera

leGanaA :: Auto -> Auto -> Bool
leGanaA auto1 auto2 = distancia auto1 > distancia auto2

cantAutosQueLeGananA :: Auto -> Carrera -> Int
cantAutosQueLeGananA auto carrera = (length . leGananA auto) carrera

leGananA :: Auto -> Carrera -> Carrera
leGananA auto carrera = filter (flip leGanaA auto) carrera

aumentarDistancia :: Int -> Auto -> Auto
aumentarDistancia delta auto = auto {distancia = distancia auto + delta}

duplicarVelocidad :: Auto -> Auto
duplicarVelocidad auto = alterarVelocidad (bajarVelocidad (-(velocidad auto))) auto

dividirVelocidad :: Auto -> Auto
dividirVelocidad auto = alterarVelocidad (bajarVelocidad (div (velocidad auto) 2)) auto


carreraPostEventos :: Carrera -> [Evento] -> Carrera
carreraPostEventos carrera eventos = foldl (\race event -> event race) carrera eventos

puestosYColoresEn :: Carrera -> [(Int,Color)]
puestosYColoresEn carrera = map (puestoYColor carrera) carrera

puestoYColor :: Carrera -> Auto -> (Int,Color)
puestoYColor carrera auto = (puesto auto carrera, color auto)


autoDeColor :: Color -> Carrera -> Auto
autoDeColor c carrera = (head . filter ((==c).color)) carrera


-- RESOLUCION EJERCICIOS

-- 1A
estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = ((<10).distanciaEntre auto1) auto2 && (not.sonIguales auto1) auto2

-- 1B
vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = estaPrimero auto carrera && estaSolo auto carrera

-- 1C
puesto :: Auto -> Carrera -> Int
puesto auto carrera = 1 + cantAutosQueLeGananA auto carrera

-- 2

correr :: Tiempo -> Auto -> Auto
correr tiempo auto = aumentarDistancia (((tiempo*).velocidad) auto) auto


type Modificador = Int -> Int

alterarVelocidad :: Modificador -> Auto -> Auto
alterarVelocidad modificador auto = auto {velocidad = modificador (velocidad auto)}


bajarVelocidad :: Int -> Modificador
bajarVelocidad delta speed = max 0 (speed - delta)

-- No entendí bien la consigna creo, así que probablemente este punto de la alterarVelocidad no esté bien hecho.



-- 3

-- Función dada por la consigna
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista


data PowerUp = UnPowerUp {
    criterioPower :: Auto -> Auto -> Bool,
    efectoPower :: Auto -> Auto
}

-- Funcion super pro para usarPowerUp
usarPU :: PowerUp -> Auto -> Carrera -> Carrera
usarPU power auto carrera = afectarALosQueCumplen (criterioPower power $ auto) (efectoPower power) carrera

-- 3a

terremoto :: PowerUp
terremoto = UnPowerUp {criterioPower = estaCerca, efectoPower = efectoTerremoto}

efectoTerremoto :: Auto -> Auto
efectoTerremoto auto = alterarVelocidad (bajarVelocidad 50) auto

-- 3b

miguelitos :: Int -> PowerUp
miguelitos speed = UnPowerUp {criterioPower = leGanaA, efectoPower = efectoMiguelitos speed}

efectoMiguelitos :: Int -> Auto -> Auto
efectoMiguelitos speed auto = alterarVelocidad (bajarVelocidad speed) auto

-- 3c

jetpack :: Tiempo -> PowerUp
jetpack tiempo = UnPowerUp {criterioPower = sonIguales, efectoPower = efectoJetpack tiempo}

efectoJetpack :: Tiempo -> Auto -> Auto
efectoJetpack tiempo auto = (dividirVelocidad.correr tiempo.duplicarVelocidad) auto


-- 4
type Evento = Carrera -> Carrera

simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera carrera eventos = (puestosYColoresEn.carreraPostEventos carrera) eventos

-- b

correnTodos :: Tiempo -> Carrera -> Carrera
correnTodos tiempo carrera = map (correr tiempo) carrera

usaPowerUP :: PowerUp -> Color -> Carrera -> Carrera
usaPowerUP power c carrera = usarPU power (autoDeColor c carrera) carrera

-- c

autoRojo :: Auto
autoRojo = UnAuto {velocidad = 120, distancia = 0, color = "Rojo"}
autoBlanco :: Auto
autoBlanco = UnAuto {velocidad = 120, distancia = 0, color = "Blanco"}
autoAzul :: Auto
autoAzul = UnAuto {velocidad = 120, distancia = 0, color = "Azul"}
autoNegro :: Auto
autoNegro = UnAuto {velocidad = 120, distancia = 0, color = "Negro"}

carreraPro :: Carrera
carreraPro = [autoRojo,autoBlanco,autoAzul,autoNegro]

eventosCarrera :: [Evento]
eventosCarrera = [correnTodos 30, usaPowerUP (jetpack 3) "Azul", usaPowerUP terremoto "Blanco",
  correnTodos 40, usaPowerUP (miguelitos 20) "Blanco", usaPowerUP (jetpack 6) "Negro",
  correnTodos 10]