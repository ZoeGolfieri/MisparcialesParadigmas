import banco.*
import propiedad.*
import Jugadores.*

class Campo inherits Propiedad{
	const provincia
	const costoContruccionDeEstancia
	
	const valorRentaFijo
	var property cantidadEstancias
	
	
	method valorRenta(){
		return 2 ** cantidadEstancias * valorRentaFijo
	}
	
	method agregarEstancia(){
		provincia.validarConstruccionDeEstancia(self)
		duenio.pagarA(banco,costoContruccionDeEstancia )
		cantidadEstancias++
	}
	
	method sosEmpresa() {
		return false
	}
	
	method rentaPara(unJugador){
		return 2 ** cantidadEstancias * valorRentaFijo
	}
	
	method cumpleCriterioDeCompraImperialista(unJugador) {
		return provincia.esMismoDuenio(banco) or provincia.esDuenioDeAlgunCampo(unJugador) 
	}
		
	method cumpleCriterioDeCompraGarca(unJugador) {
		return provincia.otroJugadorEsDuenio(unJugador)
	}
}

