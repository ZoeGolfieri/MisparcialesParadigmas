%%%%% Parte 1. Sombrero seleccionador %%%%

% mago(NombreMago)
mago(harry).
mago(draco).
mago(hermione).
mago(ron).
mago(luna).

% casa(NombreCasa)
casa(slytherin).
casa(hufflepuff).
casa(gryffindor).
casa(ravenclaw).

% caracteristicaMago(NombreMago, Caracteristica)
caracteristicaMago(harry, corajudo).
caracteristicaMago(harry, amistoso).
caracteristicaMago(harry, orgulloso).
caracteristicaMago(harry, inteligente).

caracteristicaMago(draco, orgulloso).
caracteristicaMago(draco, inteligente).

caracteristicaMago(hermione, orgulloso).
caracteristicaMago(hermione, inteligente).
caracteristicaMago(hermione, responsable).

% statusSangre(NombreMago, TipoSangre)
statusSangre(harry, mestiza).
statusSangre(draco, pura).
statusSangre(hermione, impura).

% odiariaQuedarEn(NombreMago, NombreCasa)
odiariaQuedarEn(harry, slytherin).
odiariaQuedarEn(draco, hufflepuff).

% esImportanteParaLaCasa(Casa, CaracteristicaMago)
esImportanteParaLaCasa(gryffindor, corajudo).

esImportanteParaLaCasa(slytherin, orgulloso).
esImportanteParaLaCasa(slytherin, inteligente).

esImportanteParaLaCasa(ravenclaw, responsable).
esImportanteParaLaCasa(ravenclaw, inteligente).

esImportanteParaLaCasa(hufflepuff, amistoso).

% Punto 1
% casaPermiteEntrar(Casa, Mago)
casaPermiteEntrar(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

casaPermiteEntrar(slytherin, Mago):-
    mago(Mago),
    not(statusSangre(Mago, impura)).

% Punto 2
% magoApropiadoParaCasa(Mago, Casa):-
magoApropiadoParaCasa(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(esImportanteParaLaCasa(Casa, CaracteristicaMago),
    caracteristicaMago(Mago, CaracteristicaMago)).

% Punto 3
% magoPuedeQuedarEn(Mago, Casa)
magoPuedeQuedarEn(Mago, Casa):-
magoApropiadoParaCasa(Mago, Casa),
casaPermiteEntrar(Casa, Mago),
not(odiariaQuedarEn(Mago, Casa)).

magoPuedeQuedarEn(hermione, gryffindor).

% Punto 4
% cadenaDeAmistades(Magos)
cadenaDeAmistades(Magos):-
    todosSonAmistosos(Magos),
    mismaCasaQueElSiguiente(Magos).

todosSonAmistosos(Magos):-
    forall(member(Mago, Magos), 
        caracteristicaMago(Mago, amistoso)).

mismaCasaQueElSiguiente(Magos):-
    forall(consecutivos(Mago1, Mago2, Magos),
    puedenQuedarEnLaMismaCasa(Mago1, Mago2, _)).

consecutivos(Mago1, Mago2, Lista):-
    nth1(IndiceAnterior, Lista, Mago1),
    IndiceSiguiente is IndiceAnterior + 1,
    nth1(IndiceSiguiente, Lista, Mago2).
  
  puedenQuedarEnLaMismaCasa(Mago1, Mago2, Casa):-
    magoPuedeQuedarEn(Mago1, Casa),
    magoPuedeQuedarEn(Mago2, Casa),
    Mago1 \= Mago2.

%%%%% Parte 2. La copa de las casas %%%%
% accion(Accion)
accion(andarDeNocheFueraDeLaCama).
accion(irALugarProhibido(bosque)).
accion(irALugarProhibido(biblioteca)).
accion(irALugarProhibido(tercerPiso)).
accion(ganarPartidaAjedrez).
accion(utilizarIntelecto).
accion(ganarleAVoldemort).

% malaAccion(Accion)
malaAccion(andarDeNocheFueraDeLaCama).
malaAccion(irALugarProhibido(bosque)).
malaAccion(irALugarProhibido(biblioteca)).
malaAccion(irALugarProhibido(tercerPiso)).

% buenaAccion(Accion).
buenaAccion(ganarPartidaAjedrez).
buenaAccion(utilizarIntelecto).
buenaAccion(ganarleAVoldemort).

% puntajeAccion(Accion, Puntaje)
puntajeAccion(andarDeNocheFueraDeLaCama, -50).
puntajeAccion(irALugarProhibido(bosque), -50).
puntajeAccion(irALugarProhibido(biblioteca), -10).
puntajeAccion(irALugarProhibido(tercerPiso), -75).
puntajeAccion(ganarPartidaAjedrez, 50).
puntajeAccion(utilizarIntelecto, 50).
puntajeAccion(ganarleAVoldemort, 60).

% accionQueRealizo(Mago, Accion)
accionQueRealizo(harry, andarDeNocheFueraDeLaCama).
accionQueRealizo(hermione, irALugarProhibido(biblioteca)).
accionQueRealizo(hermione, irALugarProhibido(tercerPiso)).
accionQueRealizo(harry, irALugarProhibido(bosque)).
accionQueRealizo(harry, irALugarProhibido(tercerPiso)).
accionQueRealizo(ron, ganarPartidaAjedrez).
accionQueRealizo(hermione, utilizarIntelecto).
accionQueRealizo(harry, ganarleAVoldemort).

% esDe(Mago, Casa)
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% Punto 1.a
% magoEsBuenAlumno(mago)
magoEsBuenAlumno(Mago):-
    mago(Mago),
    forall(
        accionQueRealizo(Mago, Accion),
        buenaAccion(Accion)
        ).

% Punto 1.b
% accionRecurrente(Accion) 
accionRecurrente(Accion) :-
    accion(Accion),
    findall(Accion, accionQueRealizo(_, Accion), Acciones),
    length(Acciones, CantMagosQueLaRealizaron),
    CantMagosQueLaRealizaron > 1.

% Punto 2
% puntajeTotal(Casa, PuntajeTotal)
puntajeTotal(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntos, puntosMiembroDeLaCasa(_, Casa, Puntos), PuntosDeTodos),
    sumlist(PuntosDeTodos, PuntajeTotal).

% puntosMiembroDeLaCasa(Mago, Casa, Puntos)
puntosMiembroDeLaCasa(Mago, Casa, Puntos):-
    mago(Mago),
    esDe(Mago, Casa),
    findall(Puntaje, (accionQueRealizo(Mago, Accion), puntajeAccion(Accion, Puntaje)), Puntajes),
    sumlist(Puntajes, PuntosAcciones),
    puntosEnClase(Mago, PuntosClase),
    Puntos is PuntosClase + PuntosAcciones.

% Punto 3
% casaGanadora(Casa)
casaGanadora(Casa):-
    casa(Casa),
    puntajeTotal(Casa, PuntajeTotal1),
    forall(
    puntajeTotal(_, PuntajeTotal2),
    PuntajeTotal1 >= PuntajeTotal2
        ).

% Punto 4
% preguntaEnClase(PersonaQueResponde, Pregunta, Dificultad, ProfesorQueRealizo)
preguntaEnClase(hermione, paraderoBezoar, 20, snape).
preguntaEnClase(hermione, levitarPluma, 25, flitwick).

puntosEnClase(Mago, PuntosTotales):-
    mago(Mago),
    findall(Puntos, magoGanoPorPregunta(Mago, Puntos), PuntosClase),
    sumlist(PuntosClase, PuntosTotales).

magoGanoPorPregunta(Mago, Puntos):-
    preguntaEnClase(Mago, Pregunta, _, _),
    puntosPreguntas(Pregunta, Puntos).

puntosPreguntas(Pregunta, Dificultad):-
    preguntaEnClase(_, Pregunta, Dificultad, Profesor),
    Profesor \= snape.

puntosPreguntas(Pregunta, Puntos):-
    preguntaEnClase(_, Pregunta, Dificultad, snape),
    Puntos is Dificultad / 2.





