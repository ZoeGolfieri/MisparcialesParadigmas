% Punto 1
necesidad(respiracion, fisiologico).
necesidad(alimentacion, fisiologico).
necesidad(descanso, fisiologico).
necesidad(reproduccion, fisiologico).
necesidad(integridadFisica, seguridad).
necesidad(empleo, seguridad).
necesidad(salud, seguridad).
necesidad(amistad, social).
necesidad(afecto, social).
necesidad(intimidad, social).
necesidad(confianza, reconocimiento).
necesidad(respeto, reconocimiento).
necesidad(exito, reconocimiento).
necesidad(creatividad, autorrealizacion).
necesidad(espontaneidad, autorrealizacion).

nivelSuperior(autorrealizacion, reconocimiento).
nivelSuperior(reconocimiento, social).
nivelSuperior(social, seguridad).
nivelSuperior(seguridad, fisiologico).

nivel(fisiologico).
nivel(seguridad).
nivel(social).
nivel(reconocimiento).
nivel(autorrealizacion).

% Punto 2

separacionDeNiveles(Necesidad1, Necesidad2, DistanciaNivel):-
    posicionDeNecesidad(Necesidad1, Posicion1),
    posicionDeNecesidad(Necesidad2, Posicion2),
    DistanciaNivel is abs(Posicion1-Posicion2).

posicionDeNecesidad(Necesidad, Posicion):-
    necesidad(Necesidad, Nivel),
    nivel(Nivel),
    posicion(Nivel, Posicion).

posicion(Nivel, 1):-
    not(nivelSuperior(Nivel, _)).

posicion(Nivel, Posicion):-
    nivelSuperior(Nivel, NivelInferior),
    posicion(NivelInferior, PosicionInferior),
    Posicion is PosicionInferior + 1.

% Necesidades de las personas
% Punto 3
necesidadPorSatisfacer(carla, alimentacion).
necesidadPorSatisfacer(carla, descanso).
necesidadPorSatisfacer(carla, empleo).
necesidadPorSatisfacer(carla, confianza).
necesidadPorSatisfacer(juan, afecto).
necesidadPorSatisfacer(juan, exito).
necesidadPorSatisfacer(roberto, amistad).
necesidadPorSatisfacer(manuel, integridadFisica).
necesidadPorSatisfacer(charly, afecto).
necesidadPorSatisfacer(zoe, integridadFisica).
necesidadPorSatisfacer(zoe, afecto).
% Punto 4
necesidadMayorJerarquia(Persona, Necesidad):-
    necesidadPorSatisfacer(Persona, Necesidad),
    posicionDeNecesidad(Necesidad, Posicion),
    not(
        (necesidadPorSatisfacer(Persona, Necesidad2),
        posicionDeNecesidad(Necesidad2, Posicion2),
        Posicion2 > Posicion)
        ).

% Punto 5
satisfaceNivel(Persona, Nivel):-
    necesidadPorSatisfacer(Persona, _),
    nivel(Nivel),
    posicion(Nivel, Posicion),
    not(
        (necesidadPorSatisfacer(Persona, Necesidad),
        posicionDeNecesidad(Necesidad, Posicion2),
        Posicion2 =< Posicion)
        ).

% Motivacion
% Punto 6
verdaderaTeoriaDeMaslowParaUno(Persona):-
    necesidadPorSatisfacer(Persona, _),
    not(
        (necesidadPorSatisfacer(Persona, Necesidad),
        posicionDeNecesidad(Necesidad, Posicion),
        posicion(NivelAnterior, PosicionAnterior),
        PosicionAnterior is Posicion - 1,
        not(satisfaceNivel(Persona, NivelAnterior))
    )
    ).

verdaderaTeoriaDeMaslowParaTodos:-
    forall(
        necesidadPorSatisfacer(Persona, _),
    verdaderaTeoriaDeMaslowParaUno(Persona)
        ).

verdaderaTeoriaDeMaslowMayoria:-
    cantidadPersonas(CantidadPersonas),
    cantidadPersonasEsVerdaderaTeoria(CantidadPersonasVerdadera),
    MitadPoblacion is CantidadPersonas/2,
    CantidadPersonasVerdadera >= MitadPoblacion.
    
cantidadPersonas(Cantidad):-
    findall(Persona, necesidadPorSatisfacer(Persona, _), Personas),
    list_to_set(Personas, PersonasSinRepetidos),
    length(PersonasSinRepetidos, Cantidad).
    
cantidadPersonasEsVerdaderaTeoria(Cantidad):-
    findall(Persona, verdaderaTeoriaDeMaslowParaUno(Persona), Personas),
    list_to_set(Personas, PersonasSinRepetidos),
    length(PersonasSinRepetidos, Cantidad).

% Punto 7 NO TERMINADO
% Frase: Detrás de cada necesidad hay un derecho. Eva Duarte
% derechoDeUnaPersona(Persona, basico(Necesidad, Derecho))
/*
derechoDeUnaPersona(carla, basico(alimentacion, comer)).
derechoDeUnaPersona(zoe, basico(descanso, tenerCasa)).
derechoDeUnaPersona(carla, extra(salud, saludPublica)).
derechoDeUnaPersona(zoe, extra(respeto, seguridadSocial)).

tieneDerechoPorCadaNecesidad(Persona):-
    necesidadPorSatisfacer(Persona, _),
    cantidadNecesidades(Persona, Cantidad),
    cantidadDerechos(Persona, Cantidad).

cantidadNecesidades(Persona, CantidadNecesidades):-
    necesidadPorSatisfacer(Persona, _),
    findall(Necesidad, necesidadPorSatisfacer(Persona, Necesidad), Necesidades),
    length(Necesidades, CantidadNecesidades).

cantidadDerechos(Persona, CantidadDerechos):-
    necesidadPorSatisfacer(Persona, _),
    findall(Derecho, derechoDeUnaPersona(Persona, Derecho), Derechos),
    length(Derechos, CantidadDerechos).

*/

   



