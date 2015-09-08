/*
Clase Manifestante
*/

class Manifestante
{
  // Atributos de posición del manifestante
  float x;
  float y;

  // Posición en la manifestación y estado del manifestante
  int xpos;
  int estado;
  int tiempo_ataque = 0;
  boolean atacado;
  boolean herido;
  boolean huye;

  // Atributos de punto de destino: La Plaza
  float plazax = 980;
  float plazay = 300;

  // Atributos de punto de reagrupe: Obelisco
  float puntox = 0;
  float puntoy = 300;

  // Dirección
  float dirx;
  float diry;
  float direccion;
  float direccionPiedra;

  // Velocidad y tamaño
  float velocidad = random(0, 1);
  float masa = random(4, 5);  

  // Cantidad de salud que posee  
  float salud; 
  boolean vive = true;

  // Distancia hacia la plaza
  float dist_punto = 150;

  // Distancia a la que puede atacar a un policía
  float umbral_distancia = random(350, 500);
  // Distancia a la que puede ser herido
  float umbral_herida = masa * 3;
  // Amplitud de movimiento
  float amplitud = radians(1);
  int recarga = int(random(1500, 3000)); // Velocidad de recarga del manifestante

  // Ubico al Manifestante en Zona Libre
  Manifestante() {
    // Ubicación
    x = random(5, 100);
    y = random(104, 496);
    // Zona inicial: 0 = Libre, 1 = Alerta, 2 = Montada, 3 = Plaza.
    xpos = 0;
    // Vida
    salud = random(70, 100);
    atacado = false;
    huye = false;
    tiempo_ataque = 0;
    // Estado: 0 = Espera, 1 = Avanza, 2 = Ataca
    estado = 1; // Inicia a la espera
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  // Método de dibuja
  void dibuja () {
    if (vive) {
      pushMatrix();
      translate(x, y);
      rotate(direccion);
      stroke(255, 0, 0);
      // Dibuja cuerpo
      ellipse(0, 0, masa, masa);
      // Dibuja herida
      if (herido){
        ellipse(0, 0, masa*2, masa*2);
        herido = false;
      }
      // Ver rango de ataque
      stroke(255, 0, 0, 30);
      ellipse(0, 0, umbral_distancia * 2, umbral_distancia * 2);
      popMatrix();
    }
  }// Fin Dibuja

  void dibuja_punto () {
      stroke(255, 128, 0);
      ellipse(puntox, puntoy, 5, 5);
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void mover () {
    if (vive) {//solo si está vivo
      control_balas();//función para controlar si está siendo herido por balas
      //control_gases();//función para controlar si está siendo herido por gases
      control_energia();//controlo la energía que posee
      //arroja_piedra();
      limite();//chequeo
      distancia_punto();//calculo posición según intención
      nueva_pos();
      dibuja_punto();
    }//if vive
  }  //mover

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void nueva_pos() {//avanza
    direccion += random(-(amplitud), (amplitud));//cambio de angulo
    dirx = velocidad * estado * cos( direccion );//nueva direccion
    diry = velocidad * estado * sin( direccion );//nueva direccion
    x = x + dirx;
    y = y + diry;
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void distancia_punto() {
    // Cotejo zona actual
    if (x <= 300) {
      xpos = 0; // Zona Libre
      atacado = false;
    } else if (x > 300  && x <= 950) {
      xpos = 1; // Zona Alerta
    } else println("LLEGUÉ A LA PLAZA!");
    
      
    //chequeo distancia con el punto de referencia según estado
    if (!huye){ //si ataca, va a la plaza  
      direccion = atan2(plazay-y, plazax-x);
    } else direccion = atan2(puntoy-y, puntox-x); //sino, al obelisco
    
    for (int i=0;i<cant_policias;i++) {
      if (policia[i].vive) {//si el policía está vivo
        float aux_dist=dist(x, y, policia[i].x, policia[i].y);//calculo de distancia con la persona
        if (aux_dist < umbral_distancia) {//si la distancia obtenida en menor al umbral de orden...
              direccionPiedra = atan2(policia[i].y-y, policia[i].x-x);
              tiempo_ataque++;
              estado = 1; // cambio mi estado de ataque a espera
              if (recarga < tiempo_ataque){
                if (piedraUsada >= cant_piedras) piedraUsada = 0;
                tiempo_ataque = 0;
                piedras[piedraUsada].vive = true;
                piedras[piedraUsada].x = x;
                piedras[piedraUsada].y = y;
                piedras[piedraUsada].direccion = direccionPiedra;
                println("PIEDRAZO!!!");
                piedraUsada++;
              }
          }
      }
    }

  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
  
  //Gasto de energía
  void control_energia() {
    salud -= 0.05;
    if (salud <= 0) {
      //si no está en condiciones se muere
      vive = false;
      herido = false;
    } else if (salud < 25 || atacado == true) {
      huye = true;
    } else huye = false;
  }
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void arroja_piedra() {
    tiempo_ataque++;
    if (recarga < tiempo_ataque){
      println("ATACANDO!!!");
    }
  }
  

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  // Chequeo contra balas
  void control_balas() {
      for (int i=0;i<cant_balas;i++) {
        if (balas[i].vive) {//si la bala está viva
          float aux_dist=dist(x, y, balas[i].x, balas[i].y);//calculo de distancia con la bala
          if (aux_dist < umbral_herida) {//si la distancia obtenida es menor al umbral...
              // Hubo impacto
              // Desaparece la bala
              balas[i].vive=false;
              // Baja la salud del manifestante
              salud -= balas[i].damage;
              herido = true;
            }//if aux_dist
            break;//sale de la busqueda de otra planta
        }
      }
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  //Límites de la pantalla
  void limite() {
    if (x < 4) {
      x = 4;
    }

    if (x > 996) {
      x = 996;
    }

    if (y < 104) {
      y = 104;
    }
    if (y > 496) {
      y = 496;
    }
  }


} // Fin Class
