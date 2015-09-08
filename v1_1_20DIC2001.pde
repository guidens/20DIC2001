/*
 Guido Villar
 20-DIC-2001
 V1.1
 
 Vida Artificial
 Emiliano Causa / Matías Romero Costas
 MAE 2º Año, 2015.
 
 Activar TSPS para tracking de movimiento. 
 El usuario controla a los manifestantes.
 A mayor movimiento del usuario, más rápido se mueven hacia la Plaza.
 Si están en zona libre, aceleran.
 Si están en zona de ataque, los manifestantes tiran piedras.
 Manifestantes son 100.
 Infantería son 10.
 Si se ven atacados, disparan balas de goma.
 Ambos son afectados por piedras y municiones.
 Pierden salud.
 */

import tsps.*;

TSPS tsps;

Manifestante persona[];
int cant_personas = 50;

Infanteria policia[];
int cant_policias = 10;

Bala balas[];
int cant_balas = 20;
int balaUsada = 0;

Piedra piedras[];
int cant_piedras = 20;
int piedraUsada = 0;

int tiempo_persona;
int tiempo_policia;
int tiempo_nueva_persona;
int tiempo_nuevo_policia;
int xpos0 = 0;
int xpos1 = 0;

void setup()
{
  size(1000, 600);
  // Coloco manifestantes
  persona = new Manifestante [cant_personas];
  for ( int i=0; i < cant_personas; i++ ) {
    persona[i] = new Manifestante();
  }

  // Coloco policías
  policia = new Infanteria [cant_policias];
  for ( int i=0; i < cant_policias; i++ ) {
    policia[i] = new Infanteria();
  }

  // Coloco balas
  balas = new Bala [cant_balas];
  for ( int i=0; i < cant_balas; i++ ) {
    balas[i] = new Bala();
  }

  // Coloco piedras
  piedras = new Piedra [cant_piedras];
  for ( int i=0; i < cant_piedras; i++ ) {
    piedras[i] = new Piedra();
  }

  tiempo_nueva_persona = 10;
  tiempo_nuevo_policia = 100;
  tiempo_persona = 0;
  tiempo_policia = 80;
  tsps = new TSPS(this, 12000);

  noFill();
  stroke(255, 0, 0);
}


void draw()
{
  background(255);
  stroke(0, 0, 0);
  noFill();

  TSPSPerson[] listaPersonas = tsps.getPeopleArray();
  int detectado = tsps.getNumPeople();
  TSPSPerson p;
  float x = 0;
  float y = 0;

  for (int j=0; j<detectado; j++) {

    p = listaPersonas[j];
    // Chequeo cuánto movimiento hay
    x += p.velocity.x;
    y += p.velocity.y;
  }// Fin TSPS

  xpos0 = 0;
  xpos1 = 0;
  for ( int i=0; i<cant_personas; i++ ) { 

    if (abs(x) > 10 && abs(y) > 5) { // Si hay movimiento rápido
      persona[i].estado = 5; // Persona lista para atacar
    } else persona[i].estado = 1; // Persona a la espera
    persona[i].mover(); 
    persona[i].dibuja();

    // Data para mostrar ubicación
    if (persona[i].xpos == 0) {
      xpos0++;
    } else if (persona[i].xpos == 1) {
      xpos1++;
    }
  }
  for ( int i=0; i<cant_policias; i++ ) { 
    policia[i].mover(); 
    policia[i].dibuja();
  }
  for ( int i=0; i<cant_balas; i++ ) { 
    balas[i].mover(); 
    balas[i].dibuja();
  }
  for ( int i=0; i<cant_piedras; i++ ) { 
    piedras[i].mover(); 
    piedras[i].dibuja();
  }
  String status_xpos = "Cantidad de Manifestantes en Zona de Alerta: " + str(xpos1);
  textSize(10);
  fill(0, 102, 153);
  text(status_xpos, 1, 10);
  
  // println("---------");
  //controlo tiempo de aparición de manifestantes
  tiempo_persona++;
  tiempo_policia++;
  if (tiempo_persona >= tiempo_nueva_persona) {
    tiempo_persona = 0;
    for (int i=0; i<cant_personas; i++) {
      if (persona[i].vive==false) {
        persona[i].salud= 100;
        persona[i].estado=1;
        persona[i].vive=true;
        persona[i].x=random(5, 100);
        persona[i].y=random(104, 496);
        break;
      }
    }
    if (tiempo_policia >= tiempo_nuevo_policia) {
      tiempo_policia = 0;
      for (int i=0; i<cant_policias; i++) {
        if (policia[i].vive==false) {
          policia[i].salud= 100;
          policia[i].vive=true;
          policia[i].x = random(750, 800);
          policia[i].y = random(250, 350);
          break;
        }
      }
    }
  }
}

