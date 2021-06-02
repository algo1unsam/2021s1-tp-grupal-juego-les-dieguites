import jugador.*
import wollok.game.*
import extras.*
import pelota.*

object gameOver {

	var property image = "gameOver.png"
	var property position = new Position(x = 0, y = 0)

	method perdio() = jugador.vidaJugador() <= 0

}

object gamewin {
	var property image = "ganaste.png"
	var property position = new Position(x = 0, y = 0)
	
}

object primera {

	var property image = "primera.png"
	var property position = new Position(x = 0, y = 0)

}

class VidaJugador {

	var property image = "vida.png"
	var property position

	method danio() = 0

}

class ProteccionJugador {

	var property image = "argentina.png"
	var property position

	method danio() = 0

}

class Barra {

	const coleccionDeBarra = []

	method igualarBarra()

	method actualizarBarra()

	method dibujarEnPantalla() {
		self.igualarBarra()
		coleccionDeBarra.forEach({ i => game.addVisual(i)})
	}

	method removerDePantalla() {
		coleccionDeBarra.forEach({ i => game.removeVisual(i)})
		self.dibujarEnPantalla()
	}

}

object barraDeVida inherits Barra {

	var property position = new Position(x = 0, y = 0)

	override method igualarBarra() {
		coleccionDeBarra.clear()
		self.actualizarBarra().times({ i => coleccionDeBarra.add(new VidaJugador(position = new Position(x = i - 1, y = game.height() - 1)))})
	}

	override method actualizarBarra() {
		return jugador.vidaJugador()
	}

}

object barraDeProteccion inherits Barra {

	var property position = new Position(x = 0, y = 0)

	override method igualarBarra() {
		coleccionDeBarra.clear()
		self.actualizarBarra().times({ i => coleccionDeBarra.add(new ProteccionJugador(position = new Position(x = 10 + i - 1, y = game.height() - 1)))})
	}

	override method actualizarBarra() {
		return jugador.proteccionCantidad()
	}

}

object jugadorScoreCartel {

	var property position = new Position(x = 6, y = 0)
	var property image = "marado.png"

}

