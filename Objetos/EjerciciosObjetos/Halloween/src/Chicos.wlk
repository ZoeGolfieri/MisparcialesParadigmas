import disfraces.*

object macaria{
	var nivelDeIra = 10
	const property disfraces = []
	var property cantidadCaramelos
	
	method disfrazar(elemento) {
		disfraces.add(elemento)
	}

	method quitarDisfraz(elemento) {
		disfraces.remove(elemento)
	}
	
	method recibirCaramelos(cantidad){
		cantidadCaramelos += 0.75 * cantidad
	}
	method capacidadDeSusto(){
		return nivelDeIra + disfraces.sum{disfraz => disfraz.capacidadSusto()}
	}
	
	method dejarDeUsarTrajeMenorSusto(){
		disfraces.quitarDisfraz(self.menosEfectivo())
	}
	method menosEfectivo(){
		return disfraces.min({disfraz => disfraz.capacidadSusto()})
	}
}

object pancracio{
	var disfraz = mascaraDracula
	var grito
	var cantidadCaramelos
	
	method recibirCaramelos(cantidad){
		cantidadCaramelos += cantidad
	}
	method capacidadDeSusto(){
		var letrasGrito= grito.length()
		return grito.substring(1, letrasGrito).length() + disfraz.capacidadSusto()
		
		//return grito.size() - 1 + disfraz.nivelSusto()
	}
	
	method dejarDisfraz(){
		grito += "uu"
	}
	
	method ofrecerDisfraz(disfrazNuevo){
		disfraz = disfrazNuevo
	}
	
	method disfraces(){
		return [disfraz]
	}
}
