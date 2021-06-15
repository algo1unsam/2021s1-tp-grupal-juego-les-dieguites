import wollok.game.*
import jugador.*
import rivales.*
import graficos.*
import extras.*
import pelota.*
import audio.*

object configuracion {

	method inicio() {
		game.title("Fua, EL DIEGO")
		game.height(10)
		game.width(15)
		game.boardGround("cancha.jpg")
		game.addVisual(primera)
		game.schedule(0, { audio.reproducirCancion()})
	}

	method teclado() {
		keyboard.enter().onPressDo({ self.manejarPantalla()})
	}

	method manejarPantalla() {
		self.primeraPantalla() // inicio del juego
		if (game.hasVisual(gameOver)) {
			game.removeVisual(jugadorScoreCartel)
			game.removeVisual(gameOver)
			game.addVisual(primera)
			game.removeTickEvent("Mensaje")
		}
		if (game.hasVisual(gamewin)){
			game.removeVisual(jugadorScoreCartel)
			game.removeVisual(gamewin)
			game.addVisual(primera)
			game.removeTickEvent("Mensaje")
		}
	}

	method primeraPantalla() { // pantalla de inicio se carga y se crea a maradona y a los rivales
		if (game.hasVisual(primera)) {
			game.removeVisual(primera)
			self.crearJugador() // maradona en el tablero
			const grupoRivales = new CreadorRivales() // se crea el grupo de rivales de una coleccion
			arquero.aparecer()  // movimiento del arquero 
			game.schedule(1000, { grupoRivales.crear()})
		}
	}

	method crearJugador() { 
		if (!game.hasVisual(jugador)) {
			game.addVisual(arco) 
			game.addVisual(arquero)
			game.addVisual(jugador)
			jugador.position(new Position(x = 3, y = 3))
			jugador.vidaJugador(5)
			jugador.puntos(0)
			barraDeVida.dibujarEnPantalla()
			barraDeProteccion.dibujarEnPantalla()
			self.movimientoJugador()
			self.tickExtras()
			self.colides()
		}
	}

	// ********************************* Movilidad *******************************************
	method movimientoJugador() {
		game.onTick(150, "mover", { jugador.mover()}) // controla que maradona no se pase de los ejes de la cancha
		self.moverJugador()
	}

	method moverJugador() { // movimientos del taclado
		keyboard.w().onPressDo({ jugador.movimiento(arriba.position())})
		keyboard.s().onPressDo({ jugador.movimiento(abajo.position())})
		keyboard.a().onPressDo({ jugador.movimiento(izq.position())})
		keyboard.d().onPressDo({ jugador.movimiento(der.position())})
		keyboard.space().onPressDo({ jugador.dispararPelota()})
	}

	// *********************************Bonus*********************************************
	method tickExtras() { // aparicion de los elementos aleatoriamente, la pelota y el escudo de argentina
		game.onTick(proteccion.tiempoEvento(), proteccion.nombreEvento(), { proteccion.crearExtra()})
		game.onTick(vida.tiempoEvento(), vida.nombreEvento(), { vida.crearExtra()})
		game.onTick(10000, "sumarPuntos", { score.ganarPuntos()}) // la sumatoria de puntos cada 10 seg
	}

	method colides() { // las colisiones de maradona con el rival, los bonus y el arquero con la pelota
		game.whenCollideDo(jugador, { rival => jugador.danioVida(rival.danio(), rival)})
		game.whenCollideDo(arquero, { unaPelota => arquero.atajar(unaPelota)})
	}

}

