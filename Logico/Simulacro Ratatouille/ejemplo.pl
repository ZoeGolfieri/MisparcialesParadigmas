%Base de conocimientos

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

%plato(Nombre, Tipo)
plato(ratatouille).
plato(sopa).
plato(salmonAsado).
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

%platos(Persona, Comida)
%comida(Plato, Experiencia)
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
%inspeccionSatisfactoria(Restaurante)
inspeccionSatisfactoria(Restaurante):-
    restaurante(Restaurante),
    not(viveEn(Rata, Restaurante)),
    rata(Rata).

%2. chef
%chef(Empleado, Restaurante)
chef(Empleado, Restaurante):-
    trabajaEn(Empleado,Restaurante),
    platos(Empleado, _).

%3. chefcito
%chefcito(Rata)
chefcito(Rata):-
    rata(Rata),
    trabajaEn(linguini, Restaurante),
    viveEn(Rata, Restaurante).

%4. cocinaBien
%cocinaBien(Alguien, Plato)
cocinaBien(Persona, Plato):-
    platos(Persona, comida(Plato, Experiencia)),
    Experiencia > 7.

cocinaBien(remy, Plato):-
    plato(Plato).

%5. encargadoDe
%encargadoDe(PersonaEncargada, Plato, Restaurante)
encargadoDe(PersonaEncargada, Plato, Restaurante):-
    experiencia(Plato, PersonaEncargada, Restaurante, ExperienciaEncargado),
    forall(
        experiecia(Plato, _, Restaurante, Experiencia),
        Experiencia =< ExperienciaEncargado
    ).

%experiencia(Plato, Persona, Restaurante, Experiencia)
experiencia(Plato, Persona, Restaurante, Experiencia) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, Experiencia)).

%6. saludable
%saludable(Plato)
saludable(Plato) :-
    plato(Plato, TipoPlato),
    caloriasTipoPlato(TipoPlato, Calorias).
    Calorias < 75.

%caloriasTipoPlato(TipoPlato, Calorias)
caloriasTipoPlato(entrada(Ingredientes), Calorias).
    length(Ingredientes, Largo),
    Calorias is Largo * 15.

caloriasTipoPlato(principal(Guarnicion, Minutos), Calorias) :-
    CaloriasPlato is Minutos * 5,
    calorias(Guarnicion, CaloriasGuarnicion),
    Calorias is CaloriasPlato + CaloriasGuarnicion.
    
caloriasTipoPlato(postre(Calorias), Calorias).

%calorias(Guarnicion, CaloriasGuarnicion)
calorias(pure, 20).
calorias(papasFritas, 50).
calorias(ensalada, 0).
    
%7. criticaPositiva
%criticaPositiva(Restaurante, Critico)
criticaPositiva(Restaurante, Critico):-
    restaurante(Restaurante),
    espera(Critico, Restaurante).

%critico(Nombre)
critico(antonEgo).
critico(christophe).
critico(cormillot).
critico(gordonRamsay).

%espera(Critico, Restaurante)
espera(antonEgo, Restaurante):-
    restauranteEspecialista(Restaurante, ratatouille).

%restauranteEspecialista(Restaurante, Plato)
restauranteEspecialista(Restaurante, Plato):-
    forall(trabajaEn(Persona, Restaurante), cocinaBien(Persona, Plato)).

%%%%%%%%%%%%%%%%%%%%%%%%%
%espera(Critico, Restaurante)
espera(christophe, Restaurante):-
    restauranteMasDe3Chefs(Restaurante).

%restauranteMasDe3Chefs(Restaurante)
restauranteMasDe3Chefs(Restaurante):-
   findall(Persona, trabajaEn(Persona, Restaurante), Personas),
   length(Personas, CantidadPersonas),
   CantidadPersonas > 3.

%%%%%%%%%%%%%%%%%%%%%%%%%
%espera(Critico, Restaurante)
espera(cormillot, Restaurante):-
    todosLosPlatosSaludables(Restaurante),
    ningunaEntradaLeFalteZanahoria(Restaurante).

%todosLosPlatosSaludables(Restaurante)
todosLosPlatosSaludables(Restaurante):-
    forall(
        platoDeRestaurante(Restaurante, Plato), 
        saludable(Plato)
    ).
%platoDeRestaurante(Restaurante, Plato)
platoDeRestaurante(Restaurante, Plato) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, _)).

%ningunaEntradaLeFalteZanahoria(Restaurante)
ningunaEntradaLeFalteZanahoria(Restaurante):-
    forall(
        entradaDelRestaurante(Restaurante, IngredientesEntrada),
        member(zanahoria, IngredientesEntrada)
    ).

%entradaDelRestaurante(Restaurante, Lista)
entradaDelRestaurante(Restaurante, IngredientesEntrada) :-
    trabajaEn(Persona, Restaurante),
    platos(Persona, comida(Plato, _)),
    plato(Plato, entrada(IngredientesEntrada)).