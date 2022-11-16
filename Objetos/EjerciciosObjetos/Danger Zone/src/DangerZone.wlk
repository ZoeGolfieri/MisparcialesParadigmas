class Empleado {
	var salud
	var saludCritica
	var property habilidades = []
	const property subordinados = []
	var equipoActual
	const misionesCompletadas = []
	var property puesto
	
	method saludCritica(){
		return saludCritica
	}
	method estaIncapacitado(){
		return salud < self.saludCritica()
	}
	
	method puedeUsarHabilidad(unaHabilidad){
		return not self.estaIncapacitado() && self.poseeHabilidad(unaHabilidad)
	}
	
	method poseeHabilidad(unaHabilidad){
		if(not self.esJefe())
		return self.puedeUsarHabilidad(unaHabilidad)
		else
		return self.puedeUsarHabilidad(unaHabilidad) or self.algunoDeSusSubordinadosLaPuedeUsar(unaHabilidad)
	}
	
	method algunoDeSusSubordinadosLaPuedeUsar(unaHabilidad){
		return subordinados.any({subordinado => subordinado.puedeUsarHabilidad(unaHabilidad)})
	}
	method contieneHabilidad(unaHabilidad){
		return habilidades.contains(unaHabilidad)
	}
	
	method esJefe(){
		return not subordinados.isEmpty()
	}
	
	method puedeCumplirMision(unaMision){
		const unasHabilidades = unaMision.habilidadesRequeridas()
		return unasHabilidades.all({unaHabilidad => self.contieneHabilidad(unaHabilidad)})
	}
	
	method seCumplioLaMision(unaMision){
		if (self.puedeCumplirMision(unaMision)){
			self.recibirDanio(unaMision.peligrosidad())
		}
		self.agregarMisionCompletada(unaMision)
		
	}
	
	method recibirDanio(cantidad){
		salud -= cantidad
	}
	
	method sobrevive(){
		return salud > 0
	}
	
	method esParteDeUnEquipo(unEquipo){
		if(unEquipo.integrantes().contains(self))
		equipoActual = unEquipo
	}
	method agregarMisionCompletada(unaMision){
		if(self.sobrevive())
		misionesCompletadas.add(unaMision)
		puesto.realizarAccionLuegoDeFinalizacion(unaMision, self)
	}

	method habilidadesQueNoPosee(unasHabilidades) =
		unasHabilidades.filter({unaHabilidad => not self.poseeHabilidad(unaHabilidad)})

	method aprenderHabilidadesNoSabidas(unasHabilidades){
		habilidades.addAll(self.habilidadesQueNoPosee(unasHabilidades))
	}
}

class Equipo{
	const property integrantes = []
	method puedeCumplirMision(unaMision){
		return integrantes.any({integrante => integrante.cumplirMision(unaMision)})
	}
	
	method seCumplioLaMision(unaMision){
		if (self.puedeCumplirMision(unaMision)){
			integrantes.map({
				unIntegrante => unIntegrante.recibirDanio(unaMision.peligrosidad() * (1/3)) 
				&& unIntegrante.agregarMisionCompletada(unaMision)
			})
		}
	}
	
}


object espia{
	
	const property saludCritica = 15
	
	method realizarAccionLuegoDeFinalizacion(unaMision, unEmpleado){
		unEmpleado.aprenderHabilidadesNoSabidas(unaMision.habilidadesRequeridas())
	}
	
}
class Oficinista inherits Empleado{
	var cantidadEstrellas
	
	override method saludCritica(){
		return 40 - 5 * cantidadEstrellas
	}
	
	 method realizarAccionLuegoDeFinalizacion(unaMision, unEmpleado){
		cantidadEstrellas++
		if (cantidadEstrellas >= 3)
		unEmpleado.puesto(espia)
	}
	
}

class Mision{
	const property habilidadesRequeridas = []
	var property peligrosidad
	
	method finalizoLaMision(alguien){
		return alguien.cumplioLaMision(self)
	}
	
}