import riley.*

object asentamiento {
	method apply(persona){
		persona.asentarRecuerdosDelDia()
	}
}

class AsentamientoSelectivo{
	const palabraClave
	
	method apply(persona){
		persona.asentarSiContienePalabra(palabraClave)
	}
}

object profundizacion{
	method apply(persona){
		persona.profundizarRecuerdos()
	}
}

object controlHormonal{
	method apply(persona){
		if (persona.puedeDesequilibrarse())
		persona.desequilibrate()
	}
}

class RestauracionCognitiva{
	const puntosDeFelicidad
	method apply(persona){
		persona.aumentarCoeficienteFelicidad(puntosDeFelicidad)
	}
}

object liberarRecuerdosDelDia{
	method apply(persona){
		persona.seLiberanRecuerdosDelDia()
	}
}



