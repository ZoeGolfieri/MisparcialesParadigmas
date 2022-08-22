
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