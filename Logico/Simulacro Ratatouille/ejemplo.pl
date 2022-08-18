%rata(Nombre)
rata(remy).
rata(emile).
rata(django).

%viveEn(Nombre, Lugar)
viveEn(remy, gusteaus).
viveEn(emile, barMalabar).
viveEn(django, pizzeriaJeSuis).

%persona(NombrePersona)
persona(linguini).
persona(colette).
persona(horst).
persona(amelie).

plato(ratatouille).
plato(sopa).
plato(salmonAsado).
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

%comida(plato, experiencia)
%platos(persona, [(plato,experiencia)])
platos(linguini, comida(ratatouille, 3)).
platos(linguini, comida(sopa, 5)).
platos(colette, comida(salmonAsado, 9)).
platos(horst, comida(ensaladaRusa, 8)).

%restaurante(NombreRestaurante)
restaurante(gusteaus).
restaurante(cafeDes2Moulins).
restaurante(barMalabar).
restaurante(pizzeriaJeSuis).

%trabajaEn(Persona, Restaurante)
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

%1. inspeccionSatisfactoria
inspeccionSatisfactoria(Restaurante):-
    restaurante(Restaurante),
    not(viveEn(Rata, Restaurante)),
    rata(Rata).

%2. chef
chef(Empleado, Restaurante):-
    trabajaEn(Empleado,Restaurante),
    platos(Empleado, _).

%3. chefcito
chefcito(Rata):-
    rata(Rata),
    trabajaEn(linguini, Restaurante),
    viveEn(Rata, Restaurante).

%4. cocinaBien
cocinaBien(Persona, Plato):-
    platos(Persona, comida(Plato, Experiencia)),
    Experiencia > 7.

cocinaBien(remy, Plato):-
    plato(Plato).

%5. encargadoDe (PersonaEncargada, Plato, Restaurante)
encargadoDe(PersonaEncargada, Plato, Restaurante):-
    experiencia(Plato, PersonaEncargada, Restaurante, ExperienciaEncargado),
    forall(
        experiecia(Plato, _, Restaurante, Experiencia),
        Experiencia =< ExperienciaEncargado
    ).

experiencia(Plato, Persona, Restaurante, Experiencia) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, Experiencia)).


%6. saludable

calorias(pure, 20).
calorias(papasFritas, 50).
calorias(ensalada, 0).

saludable(Plato, Calorias):-
    plato(Plato, Algo),
    Calorias < 75.

saludableEntrada(Plato):-
    plato(Plato, entrada(Lista)),
    length(Lista, Largo),
    (Largo * 15) < 75.

saludablePrincipal(Plato):-
    plato(Plato, principal(Guarnicion, Minutos)),
    Calorias is Minutos * 5,
    calorias(Guarnicion, CaloriasGuarnicion),
    (Calorias + CaloriasGuarnicion) < 75.

saludablePostre(Plato):-
    plato(Plato, postre(Calorias)),
    Calorias < 75.

%7. criticaPositiva

%criticaPositiva(Restaurante, Critico):-
criticaPositiva(Restaurante, Critico):-
    restaurante(Restaurante),
    espera(Critico, Restaurante).

%%%%%%%%%%%%%%%%%%%%%%%%%
critico(antonEgo).
critico(christophe).
critico(cormillot).
critico(gordonRamsay).

%%%%%%%%%%%%%%%%%%%%%%%%%
espera(antonEgo, Restaurante):-
    restauranteEspecialista(Restaurante, ratatouille).

restauranteEspecialista(Restaurante, Plato):-
    forall(trabajaEn(Persona, Restaurante), cocinaBien(Persona, Plato)).

%%%%%%%%%%%%%%%%%%%%%%%%%
espera(christophe, Restaurante):-
    restauranteMasDe3Chefs(Restaurante).

restauranteMasDe3Chefs(Restaurante):-
   findall(Persona, trabajaEn(Persona, Restaurante), Personas),
   length(Personas, CantidadPersonas),
   CantidadPersonas > 3.

%%%%%%%%%%%%%%%%%%%%%%%%%
espera(cormillot, Restaurante):-
    todosLosPlatosSaludables(Restaurante),
    ningunaEntradaLeFalteZanahoria(Restaurante).

todosLosPlatosSaludables(Restaurante):-
    forall(
        platoDeRestaurante(Restaurante, Plato), 
        saludable(Plato)
    ).

ningunaEntradaLeFalteZanahoria(Restaurante):-
    forall(
        entradaDelRestaurante(Restaurante, IngredientesEntrada),
        member(zanahoria, IngredientesEntrada)
    ).

platoDeRestaurante(Restaurante, Plato) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, _)).

entradaDelRestaurante(Restaurante, Lista) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, _)),
    plato(Plato, entrada(Lista)).

tieneZanahoria(entrada(Lista)) :- 
    member(zanahoria, IngredientesEntrada).








































saludable(Plato) :-
    plato(Plato, TipoPlato),
    caloriasTipoPlato(TipoPlato, Calorias).
    Calorias < 75.

caloriasTipoPlato(entrada(Ingredientes), Calorias).
    length(Ingredientes, Largo),
    Calorias is Largo * 15.

caloriasTipoPlato(principal(Guarnicion, Minutos), Calorias) :-
    CaloriasPlato is Minutos * 5,
    calorias(Guarnicion, CaloriasGuarnicion),
    Calorias is CaloriasPlato + CaloriasGuarnicion.
    
caloriasTipoPlato(postre(Calorias), Calorias).
    
    
