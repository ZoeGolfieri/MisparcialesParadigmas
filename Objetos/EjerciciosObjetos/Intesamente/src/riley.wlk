import recuerdo.*
import emocion.*
import procesosMentales.*

object riley{
	var property nivelFelicidad = 1000
	var emocionDominante 
	const recuerdosDelDia = []
	var property pensamientosCentrales = #{}
	const procesosMentales  = []
	const memoriaALargoPlazo = []
	
	method vivirUnEvento(unaDescripcion){
		const unRecuerdo = new Recuerdo(descripcion = unaDescripcion, fecha = new Date(), emocion = emocionDominante)
		recuerdosDelDia.add(unRecuerdo)
	}
	
	method asentarRecuerdo(unRecuerdo){
		emocionDominante.asentarRecuerdo(self, unRecuerdo)
	}
	
	method seConvierteEnPensamientoCentral(unRecuerdo){
		pensamientosCentrales.add(unRecuerdo)
	}
	
	method disminuirCoeficienteFelicidad(porcentaje){
		nivelFelicidad =- nivelFelicidad * (porcentaje/100)
		self.validarNivelDeFelicidad()
		}
		
	method validarNivelDeFelicidad(){
		if(nivelFelicidad < 1){
			throw new Exception (message= "No puede quedar el nivel de felicidad menor a 1")
	}
	}
	
	method recuerdosRecientesDelDia(){
		return recuerdosDelDia.take(5)
	}
	
	method pensamientosCentralesDificilesDeExplicar(){
		return pensamientosCentrales.filter({unRecuerdo => unRecuerdo.esDificilDeExplicar()})
	}
	
	method buenNivelFelicidad(){
		return nivelFelicidad > 500
	}
	
	method asentarRecuerdosDelDia(){
		self.asentarRecuerdos(recuerdosDelDia)
	}
	
	method asentarRecuerdos(unosRecuerdos){
		unosRecuerdos.forEach({unRecuerdo => self.asentarRecuerdo(unRecuerdo)})
	}
	
	method asentarSiContienePalabra(palabra){
		self.asentarRecuerdos(recuerdosDelDia.filter({unRecuerdo => unRecuerdo.contienePalabra(palabra)}))
	}
	
	method profundizarRecuerdos(){
		self.enviarAMemoriaALargoPlazo(self.recuerdosQueSePuedenProfundizar(recuerdosDelDia))
	}
	
	method recuerdosQueSePuedenProfundizar(unosRecuerdos){
		return unosRecuerdos.filter({unRecuerdo => unRecuerdo.esProfundizable()})
	}
	
	method esProfundizable(unRecuerdo){
		return not (unRecuerdo.esCentral(self) or emocionDominante.esNegado(unRecuerdo))
	}
	method enviarAMemoriaALargoPlazo(unosRecuerdos){
		unosRecuerdos.forEach({unRecuerdo => memoriaALargoPlazo.add(unRecuerdo)})
	}
	
	method puedeDesequilibrarse(){
		return self.pensamientoCentralEnMemoriaALargoPlazo() or self.recuerdosDelDiaIgualEmocionDominante()
	}
	
	method desequilibrate(){
		self.disminuirCoeficienteFelicidad(15)
		self.perder3PensamientosCentralesMasAntiguos()
		}
	
	method perder3PensamientosCentralesMasAntiguos(){
		pensamientosCentrales = pensamientosCentrales.sortedBy { r1, r2 => r1.fecha() < r2.fecha() }.drop(3)
	}
	
	method pensamientoCentralEnMemoriaALargoPlazo(){
		return memoriaALargoPlazo.any({unRecuerdo => pensamientosCentrales.contains(unRecuerdo)})
	}
	
	method recuerdosDelDiaIgualEmocionDominante(){
		const unaEmocion = recuerdosDelDia.anyOne().emocion()
		return recuerdosDelDia.all({ unRecuerdo => unRecuerdo.emocion(unaEmocion)})
	}
	
	method aumentarCoeficienteFelicidad(cantidad){
		nivelFelicidad = (nivelFelicidad + cantidad).min(1000)
	}
	
	method seLiberanRecuerdosDelDia(){
		recuerdosDelDia.removeAll()
	}
	
	method dormir() {
		self.validarProcesosMentales()
		procesosMentales.forEach { procesoMental => procesoMental.apply(self) }
	}
	
	method validarProcesosMentales() {
		if (procesosMentales.contains(liberarRecuerdosDelDia)) {
			procesosMentales.remove(liberarRecuerdosDelDia)
			procesosMentales.add(liberarRecuerdosDelDia)
		}
	}
}















