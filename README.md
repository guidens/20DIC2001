# 20DIC2001

TP Final - Vida Artificial

Guido Villar

MAE 2º Año

Docentes: Emiliano Causa / Matías Romero Costas

Buenos Aires, 20 de Diciembre de 2001. Diagonal Norte. Cansados de las políticas que están arruinando a la población y del Estado de Sitio dictado el día 19-DIC-2001 por el entonces presidente Fernando de la Rúa, miles de manifestantes se reúnen en la zona del Obelisco. Luego de que la Policía asesine a dos personas en las inmediaciones, la masa tiene como objetivo llegar a la Plaza de Mayo para pedir la renuncia de la cúpula de Gobierno. Ya en las inmediaciones de la plaza, los enfrentamientos se hacen cada vez más violentos, prolongándose por más de 7 horas hasta que la situación derivó en la dimisión del primer mandatario.

Esta pieza realiza una simulación colocando al espectador como arengador de masas. Los manifestantes son controlados por el usuario mediante su movimiento, capturado por la webcam y utilizando la librería TSPS como nexo con Processing. La zona del conflicto está dividida en 3: zona libre, zona alerta y Plaza. En zona libre, los manifestantes se aglomeran y marchan despacio hacia el objetivo. Si se detecta que un usuario está frente a la webcam, se analiza la velocidad de sus movimientos. A mayor movimiento, la velocidad de marcha será mayor.

Al acercarse, los policías evalúan la posición de los manifestantes y el riesgo de ser sobrepasados. Si ingresan a la zona de alerta, comienzan a disparan balas de goma. Ante esta situación, los manifestantes comienzan a reagruparse y lanzar piedras hacia las posiciones de Infantería. Ambos contendientes pueden resultar heridos y ser los responsables de una situación que lejos estuvo de ser provocada por ellos mismos.

# DATA
Características de los protagonistas
Manifestante:
	|_ Vida (0 o 1)
	|	|_ Estado (sano, herido)
	|	|_ Masa (2-4)
	|_ Velocidad (3-5)
	|_ Violencia (webcam: espera máx 5”, avanza (4 - 8 / Masa), tira piedra (distancia entre 15 - 25 / daño))
Policía de Infantería:
	|_ Vida (0 o 1)
	|	|_ Estado (sano, herido)
	|	|_ Recuperación (2”-6” = 5%)
	|	|_ Masa (4-6)
	|_ Velocidad (3-5)
	|_ Violencia (espera, apunta y tira gas / tira balas)

Objetos Dañinos
Piedra:
	|_ Daño (20% - 100%, radio 3)
	|_ Velocidad (10-20)
Balas de Goma
	|_ Daño (20% - 80%, radio 1)
	|_ Velocidad (100)

Acciones
Manifestante:
	|_ Espera => !Movimiento => random(Violencia 20, 100)
	|_ Ataca => Movimiento > 30%; Montada zona alerta, ataca el 50%.
	|_ Huye => Salud < 60%
Policía:
	|_ Espera => chequea zona libre, zona alerta
	|_ Ataca => zona alerta < 10, bala (1); 11-20, bala (2); 21-30, bala (3); <30, gas (1)
	|_ Repliega
