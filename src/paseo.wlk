class Familia{
	var property ninios = #{}

	method estaListaParaSalir(){
		return ninios.all({n => n.estaListoParaSalir()})
	}
	method prendaInfaltable(){
		return ninios.filter({n => n.prendaInfaltable()})
	}
	method niniosChiquitos(){
		return ninios.filter({n => n.esChuiquito()})
	}
	method salirDePaseo(){
		if (self.estaListaParaSalir()){
			ninios.forEach({n => n.gastarPrendas()})
		}
	}
}
class Ninio{
	var property talle = null
	var property prendas = #{}
	var property edad = null 
	
	var minimoDePrendasParaSalir = 5
	
	method nivelDeComodiadDePrenda(prenda){
		return prenda.comodidad(self)
	} 
	method estaListoParaSalir(){
		return prendas.size() >= minimoDePrendasParaSalir &&
			prendas.any({p => p.nivelDeAbrigo() >= 3}) &&
			self.prendasDeCalidad() > 8 
	}	
	method prendasDeCalidad(){
		return prendas.sum({p => p.calidad(self)}) / prendas.size()
	}
	method prendaInfaltable(){
		return prendas.max({p => p.calidad(self)})
	}
	method esChiquito(){
		return edad < 4
	}
	method gastarPrendas(){
		prendas.forEach({p => p.gastarPrenda()})
	}
}

class NinioProblematico inherits Ninio{
	var property jugueteEnMano = null
	constructor(){
		minimoDePrendasParaSalir = 4
	}
	
	override method estaListoParaSalir(){
		return super() && self.jugueteListoParaSalir()
	}
	method jugueteListoParaSalir(){
		return edad.between(jugueteEnMano.edadMinima(),
			jugueteEnMano.edadMaxima()
		)
	}
}

class Juguete{
	var property edadMinima = null
	var property edadMaxima = null
}
class Prenda{
	var property talle = null
	var property nivelDesgaste = null
	var property nivelDeAbrigo = null
	
	method comodidad(ninio){
		if(talle == ninio.talle()){
			return 8 - (nivelDesgaste.min(3))
		}else{
			return 0
		} 
	}
	method calidad(ninio){
		return self.comodidad(ninio) + nivelDeAbrigo
	}
	method gastarPrenda(numero){
		nivelDesgaste += numero
	}
}
class PrendaDeAPar inherits Prenda{
	var property izquierdo = null
	var property derecho = null
		
	method nivelDesgaste(){
		return (izquierdo.nivelDesgaste() + derecho.nivelDesgaste())/2
	}
	override method comodidad(ninio){
		return super(ninio) - if(ninio.esChiquito()) 1 else 0
	}
	override method gastarPrenda(numero){
		izquierdo.gastarPrenda(0.8)
		derecho.gastarPrenda(1.20)
	}
	method nivelDeAbrigo(){
		return izquierdo.nivelDeAbrigo() + derecho.nivelDeAbrigo()
	}
	method talle(){
		return izquierdo.talle() // o podria ser derecho
	}
	method intercambiar(otroPar){
		if (self.talle() == otroPar.talle()){
			var derechoB = derecho
			derecho = otroPar.derecho()
			otroPar.derecho(derechoB)
		}
	}
}
class PrendaLiviana inherits Prenda{
	constructor(){
		nivelDesgaste = 0
		nivelDeAbrigo = 1
	}
	
	override method comodidad(ninio){
		return super(ninio) + 2
	}
}

class PrendaPesada inherits Prenda{
	constructor(){
		nivelDesgaste = 0
		nivelDeAbrigo = 3
	}
	
}

//Objetos usados para los talles
object xs {
}

object s {
}
object m {
	
}
object l{
	
}
object xl{
	
}