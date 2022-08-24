# Archovo prolog vacio
% Base de conocimientos

% aeropuerto(SiglaAeropuerto)
aeropuerto(aep).
aeropuerto(eze).
aeropuerto(gru).
aeropuerto(scl).

% aeropuertoEncuentraEn(SiglaAeropuerto, Ciudad)
aeropuertoEncuentraEn(aep, buenosAires).
aeropuertoEncuentraEn(eze, buenosAires).
aeropuertoEncuentraEn(gru, saoPaulo).
aeropuertoEncuentraEn(scl, sgoDeChile).

% ciudadDe(Ciudad, Pais)
ciudadDe(buenosAires, argentina).
ciudadDe(saoPaulo, brasil).
ciudadDe(sgoDeChile, chile).
ciudadDe(palawan, filipinas).
ciudadDe(chicago, estadosUnidos).
ciudadDe(paris, francia).

% ciudad(paradisiaca(Ciudad))
ciudad(paradisiaca(palawan)).
% ciudad(negocios(Ciudad))
ciudad(negocios(chicago)).
ciudad(negocios(qatar)).
% ciudad(importanciaCultural(Ciudad, LugaresEmblematicos))
ciudad(importanciaCultural(paris, torreEiffel)).
ciudad(importanciaCultural(paris, arcoTrinufo)).
ciudad(importanciaCultural(paris, museoLouvre)).
ciudad(importanciaCultural(paris, catedralNotreDame)).
ciudad(importanciaCultural(buenosAires, obelisco)).
ciudad(importanciaCultural(buenosAires, congreso)).
ciudad(importanciaCultural(buenosAires, cabildo)).

% AEROLINEA DE CABOTAJE

% aerolinea(NombreAerolinea, rutaDeVuelo(aeropuertoSalida, aeropuertoLlegada, Precio))
aerolinea(prolog, rutaDeVuelo(aep, gru, 75000)).
aerolinea(prolog, rutaDeVuelo(gru, scl, 65000)).

% aerolineaCabotaje(Aerolinea)
aerolineaCabotaje(Aerolinea):-
    aerolinea(Aerolinea, _),
    forall(
        aerolinea(Aerolinea, rutaDeVuelo(AeropuertoSalida, AeropuertoLlegada, _)),
        aeropuertosSonDelMismoPais(AeropuertoSalida, AeropuertoLlegada)
    ).

% aeropuertosSonDelMismoPais(Aeropuerto, OtroAeropuerto)
aeropuertosSonDelMismoPais(Aeropuerto, OtroAeropuerto):-
    aeropuerto(Aeropuerto),
    aeropuertoEncuentraEn(Aeropuerto, Ciudad),
    aeropuertoEncuentraEn(OtroAeropuerto, OtraCiudad),
    ciudadesQuedanEnElMismoPais(Ciudad, OtraCiudad).

% ciudadesQuedanEnElMismoPais(Ciudad, OtraCiudad)
ciudadesQuedanEnElMismoPais(Ciudad, OtraCiudad):-
    ciudadDe(Ciudad, Pais),
    ciudadDe(OtraCiudad, Pais).

% VIAJE DE IDA
ciudadSoloViajeIda(Ciudad):-
    ciudadDe(Ciudad, _),
    tieneViajeIda(Ciudad),
    not(tieneViajeVuelta(Ciudad)).

tieneViajeIda(Ciudad):-
    aeropuerto(AeropuertoLlegada),
    aerolinea(_, rutaDeVuelo(_, AeropuertoLlegada, _)),
    aeropuertoEncuentraEn(AeropuertoLlegada, Ciudad).

tieneViajeVuelta(Ciudad):-
    aeropuerto(AeropuertoSalida),
    aerolinea(_, rutaDeVuelo(AeropuertoSalida, _, _)),
    aeropuertoEncuentraEn(AeropuertoSalida, Ciudad).

% RUTAS RELATIVAMENTE DIRECTAS
rutaRelativamenteDirecta(RutaDeVuelo):-
    aerolinea(_, RutaDeVuelo),
    esDirectoVuelo(RutaDeVuelo).

rutaRelativamenteDirecta(RutaDeVuelo):-
    aerolinea(_, RutaDeVuelo),
    tieneUnaEscalaVuelo(RutaDeVuelo).

esDirectoVuelo(rutaDeVuelo(AeropuertoSalida, AeropuertoLlegada, _)):-
   aerolinea(_, rutaDeVuelo(AeropuertoSalida, AeropuertoLlegada, _)).

tieneUnaEscalaVuelo(rutaDeVuelo(AeropuertoSalida, AeropuertoLlegada, _)):-
    aerolinea(NombreAerolinea, rutaDeVuelo(AeropuertoSalida, AeropuertoEscala, _)),
    aerolinea(NombreAerolinea, rutaDeVuelo(AeropuertoEscala, AeropuertoLlegada, _)).

% PUEDE VIAJAR UNA PERSONA

% dineroDePersona(NombrePersona, Dinero)

puedeViajar(Persona, Ciudad, OtraCiudad):-
    dineroDePersona(Persona, _),
    precioVuelo(vuelo(Ciudad, OtraCiudad), PrecioVuelo),
    tieneDineroNecesario(Persona, _, PrecioVuelo).
    
puedeViajar(Persona, Ciudad, OtraCiudad):-
    millasDePersona(Persona, _),
    precioVueloMillas(vuelo(Ciudad, OtraCiudad), PrecioVueloMillas),
    tieneMillasNecesarias(Persona, _, PrecioVueloMillas).

precioVuelo(vuelo(Ciudad, OtraCiudad), PrecioVuelo):-
    tieneVuelo(vuelo(Ciudad, OtraCiudad), PrecioVuelo).

tieneDineroNecesario(Persona, Dinero, PrecioVuelo):-
    dineroDePersona(Persona, Dinero),
    rutaDeVuelo(_, _, PrecioVuelo),
    Dinero > PrecioVuelo.

precioVueloMillas(vuelo(Ciudad, OtraCiudad), 500):-
    ciudadesQuedanEnElMismoPais(Ciudad, OtraCiudad).

precioVueloMillas(vuelo(Ciudad, OtraCiudad), PrecioMillas):-
    tieneVuelo(vuelo(Ciudad, OtraCiudad), PrecioVuelo),
    not(ciudadesQuedanEnElMismoPais(Ciudad, OtraCiudad)),
    PrecioMillas is PrecioVuelo * 0,2.

tieneVuelo(vuelo(Ciudad, OtraCiudad), PrecioVuelo):-
    aeropuertoEncuentraEn(AeropuertoSalida, Ciudad),
    aeropuertoEncuentraEn(AeropuertoLlegada, OtraCiudad),
    aeropuerto(AeropuertoSalida),
    aeropuerto(AeropuertoLlegada),
    rutaDeVuelo(AeropuertoSalida, AeropuertoLlegada, PrecioVuelo).

vuelo(Ciudad, OtraCiudad):-
    ciudadDe(Ciudad, _),
    ciudadDe(OtraCiudad, _).

% QUERER VIAJAR
quiereViajar(Persona, Ciudad):-
    dineroDePersona(Persona, _),
    dineroDePersona(Persona,Dinero),
    Dinero > 5000,
    millasDePersona(Persona, Millas),
    Millas > 100,
    requerimientoCiudad(Ciudad).

requerimientoCiudad(Ciudad):-
    ciudad(paradisiaca(Ciudad)).

requerimientoCiudad(Ciudad):-
    masDe4LugaresEmblematicos(Ciudad).

masDe4LugaresEmblematicos(Ciudad):-
    ciudad(importanciaCultural(Ciudad, _)),
    findall(LugarEmblematico, importanciaCultural(Ciudad, LugarEmblematico), LugaresEmblematicos),
    length(LugaresEmblematicos, CantLugaresEmblematicos),
    CantLugaresEmblematicos > 4.

quiereViajar(Persona, ciudad(negocios(qatar))):-
    dineroDePersona(Persona, _).

% QUIERE AHORRAR
puedePagarTodosLosVuelos(Persona):-
    dineroDePersona(Persona, _),
    ciudadActual(Persona, Ciudad),
    forall(
        vuelo(Ciudad, OtraCiudad),
        puedeViajar(Persona, Ciudad, OtraCiudad)
        ).

ahorrarUnPoquitoMas(Persona, Ciudad):-
    dineroDePersona(Persona, _),
    lugaresQueQuiereViajarYNoPuedePagar(Lugares),
    lugarMasBarato(Ciudad, Lugares).

lugarMasBarato(Ciudad, Lugares):-
    not(
        member(Lugar, Lugares),
        precioVuelo(Vuelo, Precio)
        ).

   
