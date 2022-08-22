% Base de conocimientos

% atiende(Persona, Dia, HorarioEntrada, HorarioSalida)
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

% Punto 1

% atiende(Persona, Dia, HorarioEntrada, HorarioSalida)
atiende(vale, Dias, HorarioEntrada, HorarioSalida):-
   atiende(dodain, Dias, HorarioEntrada, HorarioSalida).

atiende(vale, Dias, HorarioEntrada, HorarioSalida):-
    atiende(juanC, Dias, HorarioEntrada, HorarioSalida).

% nadie hace el mismo horario que LeoC, es algo que no se cumple
% por lo que no se agrega.
% maiu está pensando si hace el horario de 0 a 8 los martes 
% y miércoles. Como no los hace, no se pone nada.

% Punto 2

% quienAtiendeKiosko(Persona, Dia, HorarioDeterminado)
quienAtiendeKiosko(Persona, Dia, HorarioDeterminado):-
   atiende(Persona, Dia, HorarioEntrada, HorarioSalida),
   between(HorarioEntrada, HorarioSalida, HorarioDeterminado).
   
% Punto 3

% atiendeSola(Persona, Dia, Horario)
atiendeSola(Persona, Dia, HorarioDeterminado):-
   quienAtiendeKiosko(Persona, Dia, HorarioDeterminado),
   not((quienAtiendeKiosko(OtraPersona, Dia, HorarioDeterminado), Persona\=OtraPersona)).

% Punto 4

% PosibilidadesDeAtencion(Personas, Dia)
posibilidadesDeAtencion(Dia, Personas):-
   atiende(_,Dia,_,_),
   findall(Persona, atiende(Persona, Dia, _, _), PersonasPosibles),
   combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-
   combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-
   combinar(PersonasPosibles, Personas).
  

% Punto 5

% golosinas(precio)
% cigarrillos(marca)
% bebida(alcoholicas, cantidad)
% fecha(dia, mes)

%ventas(Persona, Fecha, venta)
ventas(dodain, fecha(10, 8), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
ventas(dodain, fecha(12, 8), [bebida(alcoholica, 8), bebida(noAlcoholica, 1), golosinas(10)]).
ventas(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
ventas(lucas, fecha(11, 8), [golosinas(600)]).
ventas(lucas, fecha(18, 8), [bebida(noAlcoholica, 2), cigarrillos([derby])]).

vendedorSuertudo(Persona):-
   ventas(Persona, _, _),
   forall(ventas(Persona, _, [Venta|_]), esImportante(Venta)).

esImportante(golosinas(Precio)):-
   Precio > 100.

esImportante(cigarrillos(Marcas)):-
  length(Marcas, CantidadMarcas),
  CantidadMarcas > 2.

esImportante(bebida(alcoholica, _)).

esImportante(bebida(_, Cantidad)):-
   Cantidad > 5.

