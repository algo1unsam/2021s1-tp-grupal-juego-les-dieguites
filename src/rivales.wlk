import wollok.game.*
import jugador.*
import graficos.*
import extras.*
import pelota.*
import audio.*

class Rival {

	var property position = self.dondeAparece()
	var property danio = 1
	var property tiempoCambio = self.tiempoEvento()

	method dondeAparece() {
		return new Position(x = game.width() - 1, y = 2.randomUpTo(game.height() - 2))
	}

	method crear() {
		position = self.dondeAparece()
		game.addVisual(self)
		game.onTick(self.tiempoEvento(), self.nombreEvento(), { self.mover()})
	}

	method alcanzarPuntos() = jugador.puntos() > 3000

	method mover() {
		self.llegarAlFin()
		if (self.alcanzarPuntos()) {
			self.eliminar()
		}
	}

	method llegarAlFin() {
		if (self.position().x() != 0) {
			position = position.left(1)
		} else {
			jugador.puntos(jugador.puntos() + 10)
			self.darVuelta()
		}
	}

	method chocoConDiego() = self.position() == jugador.position()

	method darVuelta() {
		position = self.dondeAparece()
	}

	method colision() {
		position = self.dondeAparece()
		jugador.estado()
	}

	method eliminar() {
	}

	method nombreEvento()

	method tiempoEvento()

}

// ***************************Alemania es mas rapida y saca 1 de danio ********************************
class Alemania inherits Rival {

	const property image = "alemania.png"

	override method nombreEvento() = "moverAlemania"

	override method tiempoEvento() = 200

	override method danio() {
		if (jugador.proteccionCantidad() > 0) {
			return jugador.proteccionCantidad()
		} else {
			// audio.perdioVida()
			return super() * 1
		}
	}

	override method eliminar() {
		game.removeTickEvent(self.nombreEvento())
		game.removeVisual(self)
	}

}

// *******************************Brasil hace 2 de danio **********************************************
class Brasil inherits Rival {

	const property image = "brasil.png"

	override method nombreEvento() = "moverBrasil"

	override method tiempoEvento() = 280

	override method danio() {
		if (jugador.proteccionCantidad() > 0) {
			return jugador.proteccionCantidad()
		} else {
			// audio.perdioVida()
			return super() * 2
		}
	}

	override method eliminar() {
		game.removeTickEvent(self.nombreEvento())
		game.removeVisual(self)
	}

}

// ***************************  Inglaterra hace 3 de danio ********************************
class Inglaterra inherits Rival {

	const property image = "inglaterra.png"

	override method nombreEvento() = "moverInglaterra"

	override method tiempoEvento() = 360

	override method danio() {
		if (jugador.proteccionCantidad() > 0) {
			return jugador.proteccionCantidad()
		} else {
			// audio.perdioVida()
			return super() * 3
		}
	}

	override method eliminar() {
		game.removeTickEvent(self.nombreEvento())
		game.removeVisual(self)
	}

}

class CreadorRivales {

	const coleccionDeRivales = [ new Alemania(), new Inglaterra(), new Brasil(), new Alemania(), new Inglaterra(), new Brasil(), new Alemania(), new Inglaterra(), new Brasil() ]

	method crear() {
		coleccionDeRivales.forEach({ e =>
			if (!game.hasVisual(e)) {
				e.crear()
			}
		})
	}

	method remover() {
		coleccionDeRivales.forEach({ e =>
			if (game.hasVisual(e)) {
				e.eliminar()
			}
		})
	}

}

