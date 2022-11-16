import Jugadores.*
import banco.*

class Propiedad {
	const precioDeCompra
	var property duenio = banco
	
	method esDe(unDuenio){
		return duenio.equals(unDuenio)
	}
	
	method cayo(unJugador){
		duenio.cayoEn(self, unJugador)
	}
	
	method paso(unJugador) {
	}
}
