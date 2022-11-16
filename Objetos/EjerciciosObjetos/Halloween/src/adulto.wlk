object srMirca {
	var property tolerancia = 21
	
	method loQuiereAsustar(alguien){
		tolerancia -= 1
		return tolerancia < alguien.capacidadDeSusto()
	}
	
	method darCaramelos(alguien){
		if(self.loQuiereAsustar(alguien)){
			var cantidad = (tolerancia - alguien.capacidadDeSusto()).max(0)
			alguien.recibirCaramelos(cantidad)
		}
	}
	
}
