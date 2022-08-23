
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

% Punto 1
tieneHerramienta(egon, aspiradora(200)).
tieneHerramienta(egon, trapeador).
tieneHerramienta(peter, trapeador).
tieneHerramienta(winston, varitaDeNeutrones).

% Punto 2
satisfaceNecesidad(Integrante, Herramienta):-
    tieneHerramienta(Integrante, Herramienta).

satisfaceNecesidad(Integrante, aspiradora(PotenciaRequerida)):-
    tieneHerramienta(Integrante, aspiradora(PotenciaAspiradora)),
    between(0, PotenciaAspiradora, PotenciaRequerida).

% Punto 3
puedeRealizarUnaTarea(Persona, Tarea):-
    herramientasRequeridas(Tarea, _),
    tieneHerramienta(Persona, varitaDeNeutrones).

puedeRealizarUnaTarea(Persona, Tarea):-
    tieneHerramienta(Persona, _),
    herramientasRequeridas(Tarea, Herramientas),
    forall(
        member(Herramienta, Herramientas),
        satisfaceNecesidad(Persona, Herramienta)
        ).

% Punto 4
% tareaPedida(Cliente, Tarea, MetrosCuadradosTarea)
% precio(Tarea, PrecioPorMetroCuadrado)
precioPorTarea(Tarea, PrecioFinal):-
    tareaPedida(_, Tarea, MetrosCuadradosTarea),
    precio(Tarea, PrecioPorMetroCuadrado),
    PrecioFinal is MetrosCuadradosTarea * PrecioPorMetroCuadrado.

aceptaPedido(Integrante, Cliente):-
    puedeRealizarTodasLasTareas(Integrante, Cliente),
    estaDispuestoAHacer(Integrante, Cliente).

puedeRealizarTodasLasTareas(Integrante, Cliente):-
    tareaPedida(Cliente, _, _),
    tieneHerramienta(Integrante, _),
    forall(
        tareaPedida(Cliente, Tarea, _),
        puedeRealizarUnaTarea(Integrante, Tarea)
        ).

estaDispuestoAHacer(ray, Cliente):-
    forall(tareaPedida(Cliente, Tarea, _),
    Tarea \= limpiarTecho).

estaDispuestoAHacer(winston, Cliente):-
    tareaPedida(Cliente, Tarea, _),
    precioPorTarea(Tarea, PrecioFinal),
    PrecioFinal > 500.

estaDispuestoAHacer(egon, Cliente):-
    not((tareaPedida(Cliente, Tarea, _),
        tareaCompleja(Tarea))).

estaDispuestoAHacer(peter, Cliente):-
    tareaPedida(Cliente, Tarea, _),
    herramientasRequeridas(Tarea, _).

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, CantidadHerramientasRequeridas),
    CantidadHerramientasRequeridas > 2.

tareaCompleja(limpiarTecho).

% Punto 6
/*
a. Lo que haria seria agregar otro predicado en el cual se 
cambie la aspiradora por la escoba con lo cual me quedarian
2 formas de ordenar el cuarto.
b. Agregandolo de la forma anterior, alcanza con que cumpla
uno para que se satisfaga, por lo que funciona de la misma 
forma y soporta los requerimientos.
c. Debido a que utilice polimorfismo para resolver distintos
puntos y eso me ayuda a que sea facil de resolverlo.
*/
