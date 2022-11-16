class Emocion{
	method asentarRecuerdo(persona, unRecuerdo){
	}
	
	method esNegado(unRecuerdo){
		return false
	}
	
	method esAlegre(){
		return false
	}
	
}

object alegria {
	method asentarRecuerdo(persona, unRecuerdo){
		if (persona.buenNivelFelicidad() > 500)
		persona.seConvierteEnPensamientoCentral(unRecuerdo)
	}
	
	method esAlegre(){
		return true
	}
	
	method esNegado(unRecuerdo){
		return not unRecuerdo.esAlegre()
	}
}

object tristeza inherits Emocion{
	override method asentarRecuerdo(persona, unRecuerdo){
		persona.seConvierteEnPensamientoCentral(unRecuerdo)
		persona.disminuirCoeficienteFelicidad(10)
	}
	
	override method esNegado(unRecuerdo){
		return unRecuerdo.esAlegre()
	}
}

object disgusto{}

object furia{}

object temor{}
