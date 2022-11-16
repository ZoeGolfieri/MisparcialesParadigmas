object mensajeria{
const property empleados = []

method contratar(unaPersona){
empleados.add(unaPersona)
}
method despedir(unaPersona){
empleados.remove(unaPersona)
}
method despedirATodos(){
empleados.clear()
}
method esGrande(){
return empleados.size() > 2
}
method loEntregaElPrimero(){
return paquete.puedeSerEntregadoPor(empleados.take(1))
}
method pesoDelUltimo(){
return empleados.last().peso()
}

}

object prueba {
  method robertoTieneBici(){
    roberto.transporte(bici)
  }
  method robertoTieneCamionCon1Acoplado(){
    camion.acoplados(1)
    roberto.transporte(camion)
  }
  method unAcopladoMasParaElCamionDeRoberto(){
    roberto.transporte(camion)
  }
}

object roberto{
var peso = 90
var transporte = null

method puedeLlamar(){
return false
}

method transporte(vehiculo){
transporte = vehiculo
}

method peso(){
return peso + transporte.peso()
}

}

object bici{
const peso = 1
method peso(){
return peso
}
}

object camion{
var acoplados = 2

	method peso() {
		return acoplados * 500
	}

	method acoplados(cantAcoplados) {
		acoplados = cantAcoplados
	}
}

object laMatrix{
method dejaEntrar(persona){
return persona.puedeLlamar()
}
}

object neo{
var credito = 7 
var peso = 0

method llamar(){
credito-= 5
}

method puedeLlamar(){
return credito >= 5
}
}

object chuck{

method peso(){
return 900
}

method puedeLlamar(){
return true
}

}

object paquete{
var destino = laMatrix
var pago = false

method pagar(){
pago = true
}

method destino(nuevoDestino){
destino = nuevoDestino
}
method estaPago(){
return pago
}
method puedeSerEntregadoPor(persona){
return destino.dejaEntrar(persona) and self.estaPago()
} 
}

object puenteDeBrooklyn{
method dejaEntrar(persona){
return persona.peso()<1000
}
}