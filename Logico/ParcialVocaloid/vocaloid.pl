canta(megurineLuka, cancion(nightFever,4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku , cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

% Punto 1
novedoso(Vocaloid):-
    cantaAlMenos2Canciones(Vocaloid),
    tiempoTotalCanciones(Vocaloid, DuracionTotal),
    DuracionTotal < 15.

cantaAlMenos2Canciones(Vocaloid):-
    canta(Vocaloid, cancion(NombreCancion1,_)),
    canta(Vocaloid, cancion(NombreCancion2,_)),
    NombreCancion1 \= NombreCancion2.

tiempoTotalCanciones(Vocaloid, DuracionTotal):-
findall(Duracion, canta(Vocaloid, cancion(_,Duracion)), Duraciones),
sumlist(Duraciones, DuracionTotal).

% Punto 2
acelerado(Vocaloid):-
    canta(Vocaloid, cancion(_,_)),
    not((canta(Vocaloid, cancion(_, Duracion)), Duracion > 4)).

% Conciertos
% concierto(NombreConcierto, PaisDondeSeRealiza, CantidadFama, Tipo)


concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto, _, _ , _).

puedeParticipar(Vocaloid, Concierto):-
canta(Vocaloid, cancion(_,_)),
Vocaloid \= hatsuneMiku,
concierto(Concierto, _, _ , Requisito),
cumpleRequisito(Vocaloid, Requisito).

cumpleRequisito(Vocaloid, gigante(CantCanciones, TiempoMinimo)):-
    cantidadCanciones(Vocaloid, Cantidad),
    Cantidad > CantCanciones,
    tiempoTotalCanciones(Vocaloid, DuracionTotal),
    DuracionTotal > TiempoMinimo.

cumpleRequisito(Vocaloid, mediano(TiempoMaximo)):-
    tiempoTotalCanciones(Vocaloid, DuracionTotal),
    DuracionTotal < TiempoMaximo.

cumpleRequisito(Vocaloid, pequenio(TiempoMinimo)):-
    canta(Vocaloid, cancion(_, Duracion)),
    Duracion > TiempoMinimo.

cantidadCanciones(Vocaloid, Cantidad):-
    canta(Vocaloid, cancion(_, _)),
    findall(Cancion, canta(Vocaloid, cancion(Cancion, _)), Canciones),
    length(Canciones, Cantidad).

% Punto 3

vocaloidMasFamoso(Vocaloid):-
    canta(Vocaloid, cancion(_, _)),
    nivelFama(Vocaloid, Nivel),
    not(
        (nivelFama(Vocaloid2, Nivel2),
        Vocaloid \= Vocaloid2,
        Nivel2 > Nivel)
    ).

nivelFama(Vocaloid, Nivel):-
    famaTotal(Vocaloid, FamaTotal),
    cantidadCanciones(Vocaloid, Cantidad),
    Nivel is FamaTotal * Cantidad.

famaTotal(Vocaloid, FamaTotal):-
    findall(Fama, famaConcierto(Vocaloid, Fama) , Famas),
    sumlist(Famas, FamaTotal).

famaConcierto(Vocaloid, Fama):-
    puedeParticipar(Vocaloid, Concierto),
    concierto(Concierto, _, Fama, _).

% Punto 4
conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).
conoceA(seeU, gumi).
conoceA(seeU, kaito).


esElUnicoQueParticipa(Vocaloid, Concierto):-
    canta(Vocaloid, cancion(_,_)),
    puedeParticipar(Vocaloid, Concierto),
    not((esConocido(Vocaloid, Conocido), puedeParticipar(Conocido, Concierto))).

esConocido(Vocaloid, Conocido):-
    conoceA(Vocaloid, Conocido).

esConocido(Vocaloid, Conocido):-
    conoceA(Vocaloid, OtroConocido),
    esConocido(OtroConocido, Conocido).

/*
Se deberian agregar los requerimientos del nuevo concierto a 
cumpleRequisitos/2. De esta forma estariamos utilizando 
polimorfismo que nos permite dar un tratamiento en particular 
a cada uno de los conciertos en la cabeza de la cláusula.
*/