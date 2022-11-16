class Recuerdo {
	const descripcion
	const fecha
	const property emocion
	
	method esDificilDeExplicar(){
		return self.cantPalabras() > 10
	}
	
	method cantPalabras(){
		return descripcion.words().size() 
	}
	
	method esAlegre(){
		return emocion.esAlegre()
	}
	
	method contienePalabra(palabra){
		return descripcion.words().contains(palabra)
	}
	
	method esCentral(unaPersona){
		unaPersona.pensamientosCentrales().contains(self)
	}
}
