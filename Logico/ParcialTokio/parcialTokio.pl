% Base de conocimientos

% atleta(NombreAtleta, Edad, PaisQueRepresenta)
atleta(dalilahMuhammad, 30, estadosUnidos).
atleta(zoe, 29, argentina).
atleta(juan, 30, uruguay).
atleta(mateo, 21, francia).
atleta(maria, 22, francia).

% pais(NombrePais)
pais(argentina).
pais(estadosUnidos).
pais(paisesBajos).
pais(uruguay).
pais(francia).


% equipo(Pais)
equipo(argentina).
equipo(paisesBajos).

% atletaCompiteEn(NombreAtleta, disciplina(NombreDisciplina, Tipo))
atletaCompiteEn(dalilahMuhammad, disciplina(carrera400MetrosConVallasFemenino, individual)).
atletaCompiteEn(zoe, disciplina(carrera100MetrosLlanosFemenino, individual)).
atletaCompiteEn(zoe, disciplina(carrera400MetrosConVallasFemenino, individual)).
atletaCompiteEn(juan, disciplina(carrera100MetrosEspaldaMasculino, individual)).
atletaCompiteEn(mateo, disciplina(carrera100MetrosEspaldaMasculino, individual)).
atletaCompiteEn(zoe, disciplina(hockeyFemenino, equipo)).
atletaCompiteEn(zoe, disciplina(voleyMasculino, equipo)).

% disciplina(NombreDisciplina, individual/equipo)
disciplina(voleyMasculino, equipo).
disciplina(natacion400MetrosFemenino, individual).
disciplina(carrera400MetrosConVallasFemenino, individual).
disciplina(carrera100MetrosLlanosFemenino, individual).
disciplina(hockeyFemenino, equipo).
disciplina(carrera100MetrosEspaldaMasculino, individual).

% gano(atleta(NombreAtleta, Edad, PaisQueRepresenta), disciplina(NombreDisciplina, Individual), TipoMedalla)
% gano(equipo(Pais), disciplina(NombreDisciplina, Equipo), TipoMedalla)
gano(equipo(argentina), disciplina(voleyMasculino, equipo), bronce).
gano(atletaSolo(dalilahMuhammad, estadosUnidos), disciplina(carrera400MetrosConVallasFemenino, individual), plata).

atletaSolo(NombreAtleta, PaisQueRepresenta):-
    atleta(NombreAtleta, _, PaisQueRepresenta).

% evento(disciplina(NombreDisciplina, Tipo), Ronda, Participantes)
evento(disciplina(hockeyFemenino, equipo), final, equipo(argentina)).
evento(disciplina(hockeyFemenino, equipo), final, equipo(paisesBajos)).
evento(disciplina(carrera100MetrosEspaldaMasculino, individual), 2, atletaSolo(juan, uruguay)).
evento(disciplina(carrera100MetrosEspaldaMasculino, individual), 2, atletaSolo(mateo, francia)).

% Punto 2
% vinoAPasear(Atleta)
vinoAPasear(Atleta):-
    atleta(Atleta, _, _),
    not(atletaCompiteEn(Atleta, disciplina(_, _))).

% Punto 3
% medallasDelPais(Disciplina, Medalla, Paise).

medallasDelPais(NombreDisciplina, Medalla, Pais):-
    pais(Pais),
    gano(equipo(Pais), disciplina(NombreDisciplina, equipo), Medalla).

medallasDelPais(NombreDisciplina, Medalla, Pais):-
    pais(Pais),
    gano(atletaSolo(_, Pais), disciplina(NombreDisciplina, individual), Medalla).


% Punto 4
% participoEn(Ronda, Disciplina, Atleta)

participoEn(Ronda, NombreDisciplina, NombreAtleta):-
    evento(disciplina(NombreDisciplina, individual), Ronda, atletaSolo(NombreAtleta, _)).

participoEn(Ronda, NombreDisciplina, NombreAtleta):-
    evento(disciplina(NombreDisciplina, equipo), Ronda, equipo(Pais)),
    atletaCompiteEn(NombreAtleta, disciplina(NombreDisciplina, equipo)),
    atleta(NombreAtleta, _, Pais).

% Punto 5
% dominio(Pais, Disciplina)
dominio(Pais, NombreDisciplina):-
    pais(Pais),
    disciplina(NombreDisciplina, _),
    medallasDelPais(NombreDisciplina, _, Pais),
    not(
        (medallasDelPais(NombreDisciplina, _, Pais2),
        Pais \= Pais2)
        ).

% Punto 6
% medallaRapida(NombreDisciplina)
medallaRapida(NombreDisciplina):-
    evento(disciplina(NombreDisciplina, _), Ronda, _),
    not(
        (evento(disciplina(NombreDisciplina, _), Ronda2, _),
            Ronda \= Ronda2)
        ).

% Punto 7
% noEsElFuerte(Pais, Disciplina)
noEsElFuerte(Pais, NombreDisciplina):-
    pais(Pais),
    disciplina(NombreDisciplina, _),
    noCompitio(Pais, NombreDisciplina).

noCompitio(Pais, NombreDisciplina):-
    not(
        (atleta(NombreAtleta, _, Pais),
        participoEn(_, NombreDisciplina, NombreAtleta))
        ).

noCompitio(Pais, NombreDisciplina):-
    participoEn(inicial, NombreDisciplina, NombreAtleta),
    not(
        (atleta(NombreAtleta, _, Pais),
        participoEn(Ronda, NombreDisciplina, NombreAtleta),
        Ronda \= inicial)
        ).

% Punto 8
% medallasEfectivas(CuentaFinal, Pais)
medallasEfectivas(CuentaFinal, Pais):-
    pais(Pais),
    findall(Puntos, puntosPorMedallasParaPais(Pais, Puntos), ListaDePuntos),
    sumlist(ListaDePuntos, CuentaFinal).

puntosPorMedallasParaPais(Pais, Puntos):-
    medallasDelPais(_, Medalla, Pais),
    puntosPorMedalla(Medalla, Puntos).

puntosPorMedalla(oro, 3).
puntosPorMedalla(plata, 2).
puntosPorMedalla(bronce, 1).

% Punto 9
% laEspecialidad(Atleta)
laEspecialidad(Atleta):-
    atleta(Atleta, _, _),
    not(vinoAPasear(Atleta)),
    forall(
        participoEn(_, NombreDisciplina, Atleta),
        obtuvoMedallaDeOroOPlata(Atleta, NombreDisciplina)
        ).

obtuvoMedallaDeOroOPlata(Atleta, NombreDisciplina):-
    medallasDelPais(NombreDisciplina, Medalla, Pais),
    atleta(Atleta, _, Pais),
    medallaDeOroOPlata(Medalla).

medallaDeOroOPlata(oro).
medallaDeOroOPlata(plata).
