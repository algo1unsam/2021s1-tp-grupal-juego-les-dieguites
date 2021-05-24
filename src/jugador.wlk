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
	//var direccion = quieto
	var property proteccionCantidad = 0
	var property puntos = 0
	//var property ultimaPosicion = position

	method movimiento(direccionModificar) {
//		direccion = direccionModificar
		self.position(direccionModificar)
		
		}
//	}

	method dispararPelota(){
		const pelota = new Pelota()
		pelota.disparo()
		vidaJugador -= 1

}
	method sumoVida(){ 
		vidaJugador += 1
		
	}
	
	method mover() {
		if (self.position().y() == game.height() - 2) {
	//		direccion = quieto
			position = position.down(1)
		} else if (self.position().y() == 2) {
	//		direccion = quieto
			position = position.up(1)
		} else if (self.position().x() == 0) {
		//	direccion = quieto
			position = position.right(1)
		} else if (self.position().x() == game.width() - game.width() / 3.roundUp()) {
	//		direccion = quieto
			position = position.left(1)
			}
//		} else {
//			position = self.position()
//		}
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

object quieto {

	method position() = jugador.position()

}

object perdiste {

	method finJuego() {
		game.clear()
		game.addVisual(gameOver)
		game.addVisual(jugadorScoreCartel)
		self.repetirMensaje()
		game.onTick(4000, "Mensaje", { self.repetirMensaje()})
		configuracion.teclado()
	}

	method repetirMensaje() {
		game.say(jugadorScoreCartel, "Obtuviste " + jugador.puntos().toString() + " puntos")
		game.say(jugadorScoreCartel, "Presiona Enter para reiniciar")
	}

}

