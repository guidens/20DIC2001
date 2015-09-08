/*
Clase de Piedra.
*/

class Piedra {
  // Atributos de posición de la bala
  float x;
  float y;

  // Dirección y límite
  float dirx;
  float diry;
  float direccion;

  // Posición en la manifestación y estado del manifestante
  boolean vive = false;

  // Velocidad, tamaño
  float velocidad = 6;
  float masa = 2;
  float damage = random(50, 80);

Piedra() {
  // Ubicación de salida
  x = 0;
  y = 0;

}
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  // Método de dibuja
  void dibuja () {
    if (vive) {
      pushMatrix();
      translate(x, y);
      stroke(160, 128, 105);
      // Dibuja cuerpo
      ellipse(0, 0, masa, masa);
      println("DIBUJANDO PIEDRA");
      popMatrix();
    }
  }// Fin Dibuja

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void mover () {
    if (vive) {//solo si está viva
      nueva_pos();
      limite();//chequeo
    }//if vive
  }  //mover

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void nueva_pos() {//avanza
    dirx = velocidad * cos( direccion );//nueva direccion
    diry = velocidad * sin( direccion );//nueva direccion
    x = x + dirx;
    y = y + diry;
    println("X, Y de la piedra: ", x + "," + y);
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  //Límites de alcance de la bala
  void limite() {
    if (x < 0) {
      vive = false;
    }

    if (x > 996) {
      vive = false;
    }

    if (y < 104) {
      vive = false;
    }
    if (y > 496) {
      vive = false;
    }
  }

} // Fin Class Piedra
