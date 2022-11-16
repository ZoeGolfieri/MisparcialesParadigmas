object shrek{
	const misiones = [liberarAFiona, buscarPiedraFilosofal]
	
	method agregasMision(mision){
		misiones.add(mision)
	}
	method misionesDificiles()=
		return misiones.filter({mision => mision.esDificil()})
	
	method solicitantesMisiones(){
		return misiones.map({mision => mision.solicitante()})
	}
	
	method totalPuntosRecompensa(){
		return misiones.sum({mision => mision.puntosRecompensa()})
	}
}
object liberarAFiona {
	var custodiodaPorCantidadDeTrolls = 4
	var property solicitante = "Lord Farquaad"
	
	method esDificil(){
		return custodiodaPorCantidadDeTrolls.between(4,5)
	}
	method puntosRecompensa()=
		 custodiodaPorCantidadDeTrolls * 2
}
object buscarPiedraFilosofal {
	var distancia = 40
	var property solicitante = "Mr.DumblecofcofDore"
	
	method esDificil(){
		return distancia > 100
	}
	method puntosRecompensa() =
		if (distancia > 50)  10 else  5
}