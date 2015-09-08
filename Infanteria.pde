class Infanteria
{
  // Atributos de posición del policía de infantería
  float x;
  float y;

  // Velocidad, tamaño
  float velocidad = 1;
  float masa = 5;  

  // Dirección y límite
  float dirx;
  float diry;
  float direccion;
  int valorx = 800;

  // Amplitud de movimiento
  float amplitud = radians(5);

  // Cantidad de salud que posee  
  float salud; 
  boolean vive = false;
  boolean herido = false;
  
  // Variable de espera o represión, tiempo de ataque
  int estado;
  int tiempo_ataque;

  // Distancia a la que puede ser herido
  float umbral_herida = masa * 3;
  
  // Arma disponible, tiempo de recarga
  int arma;
  int recarga;
  int owner;

  
  // Distancia hacia los manifestantes
  float dist_orden = 500;

  // Distancia desde la que puede reprimir a un manifestante
  float umbral_distancia = random(350, 550);
  
  // Ubico al Manifestante en Zona Libre
  Infanteria() {
    // Ubicación
    x = random(800, 850);
    y = random(250, 350);
    // Vida
    salud = 100;
    // Estado: 0 = Espera, 1 = Reprime
    estado = 0; // Inicia a la espera
    recarga = int(random(2000, 3000)); // Velocidad de recarga del policía
    tiempo_ataque = 0;
    arma = int(random(0,2));// 0 = bastón, 1 = gas, 2 = balas de goma
    owner = 0;

  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  // Método de dibuja
  void dibuja () {
    if (vive) {
      pushMatrix();
      translate(x, y);
      stroke(0, 0, 255);
      // Dibuja cuerpo
      ellipse(0, 0, masa, masa);      
      // Dibuja herida
      if (herido){
        ellipse(0, 0, masa*2, masa*2);
        herido = false;
      }
      // Ver rango de ataque
      stroke(0, 0, 255, 30);
      ellipse(0, 0, umbral_distancia * 2, umbral_distancia * 2);
      popMatrix();
    }
  }// Fin Dibuja

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void mover () {
    if (vive) {//solo si está vivo
      control_piedras();//función para controlar si está siendo herido por balas
      control_energia();//controlo la energía que posee
      distancia_persona();//calculo intención según posición
      limite(valorx);//chequeo
      nueva_pos();
    }//if vive
  }  //mover

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
  
  //Gasto de energía
  void control_energia() {
    salud -= 0.04;
    if (salud <= 0) {
      //si no está en condiciones se muere
      vive = false;
      herido = false;
    }
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  //Límites de la pantalla
  void limite(int valor) {
    if (x < 650) {
      x = 650;
      valorx++;
    }

    if (x > 996) {
      x = 996;
    }

    if (y < 154) {
      y = 154;
    }
    if (y > 446) {
      y = 446;
    }
  }

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

  void distancia_persona() {
    for (int i=0;i<cant_personas;i++) {
      if (persona[i].vive) {//si la persona está viva
        float aux_dist=dist(x, y, persona[i].x, persona[i].y);//calculo de distancia con la persona
        if (aux_dist < dist_orden) {//si la distancia obtenida en menor al umbral de orden...
          // Cotejo zona actual e intenciones del manifestante
          if (!persona[i].huye){ //si ataca  
            if (persona[i].xpos > 0) { //y si está en zona de alerta
              valorx++; // retrocedo un poco
              direccion = atan2(persona[i].y-y, persona[i].x-x);
              tiempo_ataque++;
              estado = 1; // cambio mi estado de espera a represión
              if (recarga < tiempo_ataque){
                if (balaUsada >= cant_balas) balaUsada = 0;
                tiempo_ataque = 0;
                balas[balaUsada].vive = true;
                balas[balaUsada].x = x;
                balas[balaUsada].y = y;
                balas[balaUsada].direccion = direccion;
                persona[i].atacado = true; // cambio el estado de la persona que está siendo atacada
                println("BANG!!!");
                balaUsada++;
              }
            } else valorx--; // sino, avanzo un poco
          }
          }
      }
    }
  }

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

  // Chequeo contra balas
  void control_piedras() {
      for (int i=0;i<cant_piedras;i++) {
        if (piedras[i].vive) {//si la bala está viva
          float aux_dist=dist(x, y, piedras[i].x, piedras[i].y);//calculo de distancia con la bala
          if (aux_dist < umbral_herida) {//si la distancia obtenida es menor al umbral...
              // Hubo impacto
              // Desaparece la piedra
              piedras[i].vive=false;
              // Baja la salud del policia
              herido = true;
              salud -= piedras[i].damage;
            }//if aux_dist
            break;//sale de la busqueda de otra planta
        }
      }
  }



}// Fin Class
