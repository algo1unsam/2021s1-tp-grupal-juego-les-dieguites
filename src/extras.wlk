import wollok.game.*
import jugador.*
import rivales.*
import graficos.*


class Extra {

	var property position

	method danio() = 0

	method crearExtra() {
		if (!game.hasVisual(self)) {
			position = self.posicion()
			game.addVisual(self)
		} else {
			game.removeTickEvent(self.nombreEvento())
		}
	}

	method posicion() {
		return self.lugarEnPantalla()
	}

	method lugarEnPantalla() {
		return new Position(x = 3.randomUpTo(game.width() - (game.width() / 3) - 2), y = 3.randomUpTo(game.height() - 3))
	}

	method crearTick() {
		if (!game.hasVisual(self)) {
			game.onTick(self.tiempoEvento(), self.nombreEvento(), { self.crearExtra()})
		}
	}

	method colision() {
		game.removeVisual(self)
		self.crearTick()
		self.efectoDeColision()
	}

	method nombreEvento()

	method tiempoEvento()

	method efectoDeColision()

}

object proteccion inherits Extra {

	const property image = "argentina.png"

	override method nombreEvento() = "Proteccion"

	override method tiempoEvento() = 7000

	override method efectoDeColision() {
		jugador.proteccionCantidad(1)
		barraDeProteccion.removerDePantalla()
		jugador.image("maradoArg.png")
	}

}

object vida inherits Extra {

	const property image = "vida.png"

	override method nombreEvento() = "Vida"

	override method tiempoEvento() = 3000

	override method efectoDeColision() {
		jugador.sumoVida()
		barraDeVida.removerDePantalla()
	}

}

// **************Realiza la operación para la puntuación y lo guarda en una variable del jugador ************************
object score {

	method calcularPuntos() = (jugador.vidaJugador() + jugador.proteccionCantidad()) * 100

	method ganarPuntos() {
		jugador.puntos(jugador.puntos() + self.calcularPuntos())
	}

	method puntuacionTotal() = jugador.puntos()

}

