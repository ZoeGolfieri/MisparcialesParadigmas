object monedero{
	var property cantidadPlata 
	
	method sacarPlata(cantidad){
		self.validarMonto(cantidad)
		if(cantidad > cantidadPlata)
		throw new Exception (message= "No se puede sacar esa plata")
		else cantidadPlata -= cantidad
	}
	method ponerPlata(cantidad){
		self.validarMonto(cantidad)
		cantidadPlata += cantidad	
	}
	method validarMonto(cantidad){
		if(cantidad < 0)
		throw new Exception (message= "La cantidad debe ser positiva")
	}
}