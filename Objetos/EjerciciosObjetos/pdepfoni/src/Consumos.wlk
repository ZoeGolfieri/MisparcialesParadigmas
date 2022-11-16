class Consumo {
	const property fechaRealizado = new Date()
	
	method consumidoEntre(fechaMin, fechaMax){
		return fechaRealizado.between(fechaMin, fechaMax)
	}
	
}

class ConsumoInternet inherits Consumo{
	const property cantidadMB
	
	method costo() = cantidadMB * pdepfoni.costoPorMB()
}

class ConsumoLlamada inherits Consumo{
	const property segundos
	
	method costo() {
		const segundosExtras = segundos - 30
		if(segundosExtras < 0)
			return pdepfoni.costoFijoLlamada()
		else
			return pdepfoni.costoFijoLlamada() + segundosExtras * pdepfoni.costoPorSegundoLlamada()
	}
}

object pdepfoni{
	var property costoFijoLlamada
	var property costoPorSegundoLlamada
	var property costoPorMB
	
}

