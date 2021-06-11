import wollok.game.*
import jugador.*
import rivales.*
import graficos.*
import extras.*
import pelota.*

object audio {
	var property cancionActual = null
	
	method cancion() = game.sound("assets/sounds/unState.mp3")
	method frasePerdedora() = game.sound("assets/sounds/gameOver.mp3")
	method fraseGanadora() = game.sound("assets/sounds/ganaste.mp3") 
	
	method reproducirCancion(){
	cancionActual = self.cancion()
	cancionActual.volume(0)
	cancionActual.play()
	}
	
	method parar(){
		
		if(cancionActual != null){
			cancionActual.stop()
		}
		cancionActual=null
	}
	
	method reproducirFrasePerdedora(){
		cancionActual = self.frasePerdedora()
		cancionActual.play()
	}
	
	method reproducirFraseGanadora(){
			cancionActual = self.fraseGanadora()
			cancionActual.play()
	}
	
	method perdioVida() {
		game.schedule(0 ,{game.sound("assets/sounds/perdioVida.mp3").play()})	 
	}
	
	method ganoVida() {
		game.schedule(0 ,{game.sound("assets/sounds/ganoVida.mp3").play()})	 
	}
		
}
	