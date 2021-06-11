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
		game.schedule(0 ,{audio.reproducirCancion()})	
	}
	
	method teclado() {
		keyboard.enter().onPressDo({ self.manejarPantalla()})
	}

	method manejarPantalla() {
		self.primeraPantalla()
		if (game.hasVisual(gameOver)) {
			game.removeVisual(jugadorScoreCartel)
			game.removeVisual(gameOver)
			game.addVisual(primera)
			game.removeTickEvent("Mensaje")
		}
	}

	method primeraPantalla() {
		if (game.hasVisual(primera)) {
			game.removeVisual(primera)
			self.crearJugador()
			const grupo1 = new CreadorRivales() // **********************************************************
			arquero.aparecer()
//			const grupo2 = new CreadorRivales() // *********** Grupos de rivales*****************************
//			const grupo3 = new CreadorRivales() // **********************************************************
			game.schedule(1000, {grupo1.crear()})
//			game.schedule(5000, { grupo2.crear()})//****************Dificultad 2******************************
//			game.schedule(20000, { grupo3.crear()})//**********************************Dificultad 3************
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
		game.onTick(150, "mover", { jugador.mover()})
		self.moverJugador()
	}

	method moverJugador() {
		keyboard.w().onPressDo({ jugador.movimiento(arriba.position())})
		keyboard.s().onPressDo({ jugador.movimiento(abajo.position())})
		keyboard.a().onPressDo({ jugador.movimiento(izq.position())})
		keyboard.d().onPressDo({ jugador.movimiento(der.position())})
		keyboard.space().onPressDo({ jugador.dispararPelota()})
	}

	// *********************************Bonus*********************************************
	method tickExtras() {
		game.onTick(proteccion.tiempoEvento(), proteccion.nombreEvento(), { proteccion.crearExtra()})
		game.onTick(vida.tiempoEvento(), vida.nombreEvento(), { vida.crearExtra()})
		game.onTick(10000, "sumarPuntos", { score.ganarPuntos()})
	}

	method colides() {
		game.whenCollideDo(jugador, { rival => jugador.danioVida(rival.danio(), rival)})
		game.whenCollideDo(arquero, { unaPelota => arquero.atajar(unaPelota)})
	}

}




