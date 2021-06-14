import wollok.game.*
import rivales.*
import configuracion.*
import graficos.*
import extras.*
import jugador.*

class Pelota {

	
	var property position = jugador.position()
	var property image = "pelota.png"

	method disparo() {
		game.addVisual(self)
		game.onTick(50, "moverPelota", { self.mover()})
	}

	method mover() {
		self.llegarAlArco()
	}

	method llegarAlArco() {
		if (self.position().x() != 0) {
			position = position.right(1)
			if (self.esGol()) {
				ganaste.finJuego()
			}
		} else {
			game.removeTickEvent("moverPelota")
			game.removeVisual(self)
		}
	}

	method danio() {
		return 0
	}

	method colision() {
	}

	method colisiono(algo) {
		algo.llegar(self)
	}

	method esGol() {
		return self.position().x() == 13 and self.position().y() == 3 or self.position().x() == 13 and self.position().y() == 4 or self.position().x() == 13 and self.position().y() == 5 or self.position().x() == 13 and self.position().y() == 6 and arquero.position()
	}

}

object arco {

	var property position = new Position(x = 13, y = 3)
	var property image = "arco.png"

	method llegar(unaPelota) {
		unaPelota.llegarAlArco()
	}

}


object arquero {

	var property image = "arquero.png"
	var property position = new Position(x = 11, y = 4)
	var property direccion = true
	var property empezarArquero = false

	method movimiento() {
		if (self.position().y() == 6) {
			direccion = false
		}
		if (self.position().y() == 3) {
			direccion = true
		}
		if (direccion) {
			position = position.up(1)
		} else position = position.down(1)
	}

	method llegar(unaPelota) {
		self.atajar(unaPelota)
	}

	method atajar(unaPelota) {
		if (unaPelota.position() == self.position()) {
			game.removeTickEvent("moverPelota")
			game.removeVisual(unaPelota)
		}
	}

	method aparecer() {
		game.onTick(100, "moverArquero", { self.movimiento()})
	}

}

