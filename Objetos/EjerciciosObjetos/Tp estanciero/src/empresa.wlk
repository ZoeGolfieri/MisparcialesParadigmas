import banco.*
import propiedad.*
import Tablero.*

class Empresa inherits Propiedad {
	
	method sosEmpresa() {
		return true
	}
	
	method rentaPara(unJugador){
		return unJugador.tirarDados() * self.duenio().cantidadEmpresas() * 30000
	}
	
	method cumpleCriterioDeCompraImperialista(unJugador) {
		return tablero.todasLasEmpresasSonPropiedadDelBanco()
	}

	method cumpleCriterioDeCompraGarca(unJugador) {
		return tablero.otroJugadorEsDuenio(unJugador)
	}	
}
