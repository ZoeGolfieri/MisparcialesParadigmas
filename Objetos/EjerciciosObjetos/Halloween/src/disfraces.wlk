object trajeDeBruja {
	
	method capacidadSusto(){
		return 10
	}
}

object barba {
	
	var longitud
	
	method capacidadSusto(){
		return 5 * longitud
	}
	
	method perderPelos(cantidad){
		longitud -= cantidad
	}
	
	method sumarPelos(cantidad){
		longitud += cantidad
	}
}

object mascaraDracula{
	const tamanio = 10
	
	method capacidadSusto(){
		return 3 * tamanio
	}
}

object masacaraFrankestein{
	
	method capacidadSusto(){
		return 22
	}
}

object masacaraLiderPolitico{
	var cantidadPromesas 
	
	method capacidadSusto(){
		return cantidadPromesas
	}
}





