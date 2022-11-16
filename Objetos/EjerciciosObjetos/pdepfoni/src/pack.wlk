class Pack{
	const vigencia = ilimitado
	
	method esInutil() = vigencia.vencido() || self.acabado()

	method acabado()

	method puedeSatisfacer(consumo) = not vigencia.vencido() && self.cubre(consumo)

	method cubre(consumo)
}

object ilimitado {

	method vencido() = false

}

class Vencimiento {

	const fecha

	method vencido() = fecha < new Date()

}