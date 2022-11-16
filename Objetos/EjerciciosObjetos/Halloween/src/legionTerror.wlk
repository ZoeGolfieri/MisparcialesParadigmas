import Chicos.*

class LegionTerror {
	
	const integrantes = []
	
	method capacidadDeSusto(){
		return integrantes.sum({integrante => integrante.capacidadDeSusto()})
	}
	
	method recibirCaramelos(cantidad){
		self.lider().recibirCaramelos(cantidad)
	}
	
	method agregarIntegrantes(unosIntegrantes){
		integrantes.addAll(unosIntegrantes)
	}
	
	method lider(){
		return integrantes.sortedBy({int1, int2 => int1.cantidadCaramelos() > int2.cantidadCaramelos()}).first()
	}
	
	method todosLosDisfraces() {
		return integrantes.flatMap({ chico => chico.disfraces()}).asSet() 
	}

	method disfracesRepetidos() {
		return self.todosLosDisfraces().filter({ x => self.todosLosDisfraces().occurrencesOf(x) > 1 })
	}

	method sacarseloATodos(disfraz) {
		integrantes.forEach({ x => x.quitarDisfraz(disfraz) })
	}

	method normaSinRepetidos() {
		self.disfracesRepetidos().forEach({ disfraz => self.sacarseloATodos(disfraz) })
	}
}

object barrio{
	var chicos = []
	method chicosConMasCaramelos(cantidad) {
		return chicos.sortedBy({ x, y => x.caramelos() > y.caramelos()}).take(cantidad)
	}
	
	method chicos(nuevosChicos) {
		chicos = nuevosChicos
	}

	method algunoMuyAsustador() {
		return chicos.any({ chico => chico.capacidadSusto() > 42 })
	}
	
}
