import propiedad.*
import banco.*
import estadoDeLibertad.*
import prision.*

class Jugador{
	var dinero = 5000
	const property propiedades = []
	
	var casilleroActual
	
	var estadoDeLibertad = libre
	var property cantidadDeTirosDoblesSeguidos = 0
	
	method cantidadEmpresas(){
		propiedades.count({propiedad => propiedad.sosEmpresa()})
	}
	
	method pagarA(alguien, precio){
		self.validarDinero(precio)
		alguien.recibirDinero(precio)
		self.pagar(precio)
	}
	
	method validarDinero(cantidad){
		if(dinero  < cantidad ){
			throw new Exception(message= 'No tiene suficiente dinero para comprar la propiedad')
		}
	}
	
	method pagar(cantidad){
		dinero -= cantidad
	}
	
	
	method recibirDinero(cantidad){
		dinero += cantidad
	}
	
	method tirarDados(){
		return parDeDados.tirar()
	}

	method cayoEn(unaPropiedad, unJugador) {
		unJugador.pagarA(self, unaPropiedad.rentaPara(unJugador))
	}
	
	method comprarPropiedad(propiedad){
		self.pagarA(banco, propiedad.precioDeCompra())
		propiedades.add(propiedad)
	}
	
	method moverseSobre(casilleros){
		estadoDeLibertad.moverSobre(casilleros, self)
	}
	
	method pasarPorTodosMenosElUltimo(casilleros){
		const casillerosAPasar = casilleros.reverse().drop(1).reverse()
		casillerosAPasar.forEach({casillero => casillero.paso(self)})
	}
	
	method caerEn(unCasillero) {
		unCasillero.cayo(self)
		casilleroActual = unCasillero
	}
	
	method esDuenio(propiedad){
		return propiedades.contains(propiedad)
	}
	
	method verificarCambioDeEstado() {
		if (parDeDados.ultimoTiroFueDoble()) {
			self.incrementarCantidadDeTirosDoblesSeguidos()
		} else {
			self.resetearCantidadDeTirosDoblesSeguidos()
		}
	}
	
	method resetearCantidadDeTirosDoblesSeguidos() {
		cantidadDeTirosDoblesSeguidos = 0
	}
	
	method incrementarCantidadDeTirosDoblesSeguidos() {
		cantidadDeTirosDoblesSeguidos ++
		estadoDeLibertad.sacoDoble(self)
	}
	
	method marchePreso() {
		self.resetearCantidadDeTirosDoblesSeguidos()
		self.caerEn(prision)
		estadoDeLibertad = new Preso()
	}
	
	method liberate() {
		self.resetearCantidadDeTirosDoblesSeguidos()
		estadoDeLibertad = libre
	}

}


object parDeDados {
	
	var dado1
	var dado2
	
	method tirar() {
		dado1 = self.tirarUnDado()
		dado2 = self.tirarUnDado()
		return dado1 + dado2
	}
	
	method ultimoTiroFueDoble() {
		return dado1 == dado2
	}
	
	method tirarUnDado() {
		return 1.randomUpTo(7)
	}
	
}










