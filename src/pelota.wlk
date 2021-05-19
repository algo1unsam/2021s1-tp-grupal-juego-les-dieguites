import wollok.game.*
import rivales.*
import configuracion.*
import graficos.*
import extras.*
import jugador.*

class Pelota {
	
	var property direccion = der
	var property position = jugador.position()
	var property image = "pelota.png"
	
	method disparo(){
//		self.image("vida" + direccion + ".png")
		game.addVisual(self)
		game.onTick(50, "moverPelota", {self.mover()})
	}
	method mover() {
		self.llegarAlArco()
	}
	method llegarAlArco() {
		if(self.position().x() != 0){
			position = position.right(1)
		}
		else {
			game.removeTickEvent("moverPelota")
			game.removeVisual(self)
		}
	}
}

object arco{
	
	var property position = new Position(x = 13, y = 3)
	var property image = "arco.png"
	
}

//object right{
//	method mover(unaPelota){
//		return unaPelota.position().right(1)
//	}
//}