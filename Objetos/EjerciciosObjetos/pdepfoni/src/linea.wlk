import Consumos.*

class Linea{
	const consumosRealizados = []
	const packsActivos = []
	
	method costoPromedioConsumosRealizadosEn(fechaMin, fechaMax){
		return self.totalConsumosEn(fechaMin, fechaMax) / self.cantidadDeConsumosEn(fechaMin, fechaMax)
	}
	
	method totalConsumosEn(fechaMin, fechaMax){
		return self.consumosEnUnaFecha(fechaMin, fechaMax).sum({consumo => consumo.costo()})
	}
	
	method consumosEnUnaFecha(fechaMin, fechaMax){
		return consumosRealizados.filter({consumo => consumo.consumidoEntre(fechaMin, fechaMax)})
	}
	
	method cantidadDeConsumosEn(fechaMin, fechaMax){
		return self.consumosEnUnaFecha(fechaMin, fechaMax).size()
	}
	
	method costoTotalEnLosUltimos30Dias(){
		const unaFecha = new Date()
		return self.totalConsumosEn(unaFecha.minusDays(30), unaFecha)
	}
	
}


