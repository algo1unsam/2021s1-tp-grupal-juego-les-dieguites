import wollok.game.*
import jugador.*
import rivales.*
import graficos.*
import extras.*
import pelota.*

object audio {
	var property cancionActual = null
	
	method cancion() = game.sound("assets/sounds/unState.mp3")
	method frase() = game.sound("assets/sounds/gameOver.mp3")
	method fraseGanaste() = game.sound("assets/sounds/gameOver.mp3") //falta audio
	
	method reproducirCancion(){
	cancionActual = self.cancion()
	cancionActual.play()
	}
	
	method parar(){
		
		if(cancionActual != null){
			cancionActual.stop()
		}
		cancionActual=null
	}
	
	method reproducirFrase(){
		cancionActual = self.frase()
		cancionActual.play()
	}
	
	method reproducirFraseGanaste(){
		cancionActual = self.fraseGanaste()
		cancionActual.play()
	}
		
}
	