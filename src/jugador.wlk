import wollok.game.*
import rivales.*
import configuracion.*
import graficos.*
import extras.*
import pelota.*

object jugador {

	var property image = "marado.png"
	var property vidaJugador = 5
	var property position = new Position(x = 3, y = 3)
	var property proteccionCantidad = 0
	var property puntos = 0

	method movimiento(direccionModificar) {
		self.position(direccionModificar)
	}

	method dispararPelota() {
		const pelota = new Pelota()
		pelota.disparo()
		self.restoVida()
		self.estado()
	}

	method tengoVida() {
		return vidaJugador > 0
	}

	method restoVida() {
		vidaJugador -= 1
	}

	method sumoVida() {
		vidaJugador += 1
	}

	method mover() {
		if (self.position().y() == game.height() - 2) {
			position = position.down(1)
		} else if (self.position().y() == 1) {
			position = position.up(1)
		} else if (self.position().x() == 0) {
			position = position.right(1)
		} else if (self.position().x() == game.width() - game.width() / 3.roundUp()) {
			position = position.left(1)
		}
	}

	method danioVida(danio, rival) {
		if (!(proteccionCantidad == 0)) {
			proteccionCantidad -= danio
		} else {
			vidaJugador -= danio
		}
		if (proteccionCantidad == 0) {
			self.image("marado.png")
		}
		rival.colision()
	}

	method estado() {
		if (!gameOver.perdio()) {
			barraDeVida.removerDePantalla()
			barraDeProteccion.removerDePantalla()
		} else {
			perdiste.finJuego()
			
		}
	}

}

object abajo {

	method position() = jugador.position().down(1)

}

object arriba {

	method position() = jugador.position().up(1)

}

object izq {

	method position() = jugador.position().left(1)

}

object der {

	method position() = jugador.position().right(1)

}



object perdiste {

	method finJuego() {
		//configuracion.detenerMusica()
		game.clear()
		game.addVisual(gameOver)
		game.addVisual(jugadorScoreCartel)
		//game.sound("assets/sounds/gameOver.mp3").play()
		self.repetirMensaje()
		game.onTick(4000, "Mensaje", { self.repetirMensaje()})
		configuracion.teclado()
	}

	method repetirMensaje() {
		game.say(jugadorScoreCartel, "Obtuviste " + jugador.puntos().toString() + " puntos")
		game.say(jugadorScoreCartel, "Presiona Enter para reiniciar")
	}

}

