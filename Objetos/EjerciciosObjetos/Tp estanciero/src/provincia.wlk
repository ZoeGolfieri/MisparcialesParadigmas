import banco.*

class Provincia {
	
	const campos = []
	
	method duenios(){
		return campos.map({campo => campo.duenio()}).asSet()
	}
	
	method validarConstruccionDeEstancia(campo){
		self.validarMismoDuenio(campo.duenio())
		self.validarConstruccionPareja(campo)
	}
	
	method validarMismoDuenio(unDuenio) {
		if (not self.esMismoDuenio(unDuenio)) {
			throw new DomainException(message = "Todos los campos deben ser del mismo duenio")
		}
	}
	
	method esMismoDuenio(unDuenio) {
		return campos.all { campo => campo.esDe(unDuenio) } 
	}
	
	method validarConstruccionPareja(unCampo) {
		if (not self.esConstruccionPareja(unCampo)) {
			throw new DomainException(message = "La construccion de estancias tiene que ser pareja entre los campos")
		}
	}
	
	method esConstruccionPareja(unCampo){
		return campos.all ({ campo => unCampo.cantidadEstancias() <= campo.cantidadEstancias() })
	}
	
	method esDuenioDeAlgunCampo(unJugador) {
		return self.duenios().contains(unJugador)
	}
	
	method otroJugadorEsDuenio(unJugador) {
		return not self.esDuenioDeAlgunCampo(unJugador) && 
		       not self.esDuenioDeAlgunCampo(banco)
	}
	
}
