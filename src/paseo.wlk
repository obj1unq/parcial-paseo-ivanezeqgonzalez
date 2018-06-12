class Familia{
	var property ninios = #{}
	method cambiarPares(parA, parB){
		if (parA.talle() == parB.talle()){
			var derechoA = parA.derecho()
			parA.derecho(parB.derecho())
			parB.derecho(derechoA)
		}
	}
	method estaListaParaSalir(){
		return ninios.all({n => n.estaListoParaSalir()})
	}
	method prendaInfaltable(){
		return ninios.filter({n => n.prendaInfaltable()})
	}
	method niniosChiquitos(){
		return ninios.filter({n => n.esChuiquito()})
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
}
class PrendaDeAPar inherits Prenda{
	var property izquierdo = null
	var property derecho = null
	constructor(){nivelDeAbrigo = 1}
	
	method nivelDesgaste(){
		return (izquierdo.desgaste() + derecho.desgaste())/2
	}
	override method comodidad(ninio){
		return super(ninio) - if(ninio.esChiquito()) 1 else 0
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



//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase
class XXX {
	var talle= null
	var desgaste= null
	var min= null
	var max= null
	var prendas= null
	var ninios= null
	var edad= null
	var juguete = null
	var abrigo = null
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