class Ninio{
	var property talle = null
	var property prentas = #{}
	var property edad = null 
	
	method nivelDeComodiadDePrenda(prenda){
		return prenda.comodidad(self)
	} 
		
	 
}

class Prenda{
	var property talle = null
	var property nivelDesgaste = null
	
	method comodidad(ninio){
		if(talle == ninio.talle()){
			return 8 - (nivelDesgaste.min(3))
		}else{
			return 0
		} 
	}
}
class PrendaDeAPar inherits Prenda{
	var property izquierdo = null
	var property derecho = null
	
	method nivelDesgaste(){
		return (izquierdo.desgaste() + derecho.desgaste())/2
	}
	override method comodidad(ninio){
		return super(ninio) - if(ninio.edad() < 4) 1 else 0
	}
	
}
class PrendaLiviana inherits Prenda{
	var property desgaste = 0
	
	override method comodidad(ninio){
		return super(ninio) + 2
	}
}

class PrendaPesada inherits Prenda{
	var property desgaste = 0
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