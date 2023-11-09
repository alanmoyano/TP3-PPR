% BASE DE CONOCIMIENTO
% personaje/5
personaje(iron_man, humano, 'Tony Stark', 1, [tec, fs, vel]).
personaje(captain_america, humano, 'Steve Rogers', 1, [fs, ag, res]).
personaje(black_widow, humano, 'Natasha Romanoff', 1, [com, tir, diz]).
personaje(thor, asgardiano, 'Thor Odinson', 2, [fs, res, inm, cr]).
personaje(hulk, humano, 'Bruce Banner', 1, [fs, res, reg]).
personaje(black_panther, humano, 'T Challa', 3, [fs, ag, res, am]).
personaje(spider_man, humano, 'Peter Parker', 1, [ag, fs, sa]).
personaje(wolverine, mutante, 'Logan', 4, [reg,garr, sea]).
personaje(deadpool, mutante, 'Wade Wilson', 5, [reg, ins, mc, ma]).

% equipo/3
equipo(1, avengers, 0.78).
equipo(2, asgard, 0.67).
equipo(3, wakanda, 0.74).
equipo(4, xmen, 0.91).
equipo(5, mercenarios, 0.90).

% poderes/3:
poder(tec,'Tecnología',	10).
poder(fs, 'Fuerza sobrehumana', 30).
poder(res, 'Resistencia', 5).
poder(vel,'Velocidad',5).
poder(ag,'Agilidad',5).
poder(com,'Combate mano a mano', 5).
poder(tir,'Experta tiradora', 5).
poder(diz,'Maestra del disfraz', 5).
poder(inm,'Inmortalidad',50).
poder(cr,'Control de rayos', 25).
poder(reg, 'Regeneración', 25).
poder(am, 'Maestro en artes marciales',10).
poder(sa, 'Sentido arácnido', 10).
poder(garr, 'Garras retráctiles', 15).
poder(sea,'Sentidos agudos',5).
poder(ins,'Inmunidad psíquica',	10).
poder(mc,'Maestro en combate', 35).
poder(ma, 'Maestro en armas', 15).

% aliado_de/2 y enemigo_de/2
aliado_de(Personaje1, Personaje2) :-
	personaje(Personaje1, _, _, Equipo, _),
	personaje(Personaje2, _, _, Equipo, _),
	Personaje1 \= Personaje2.

enemigo_de(Personaje1, Personaje2) :-
	personaje(Personaje1, _, _, Equipo1, _),
	personaje(Personaje2, _, _, Equipo2,_),
	Equipo1 =\= Equipo2,
	Personaje1 \= Personaje2.

% 1)	Para cierto código de personaje que se especifica como primer argumento, 
%       mostrar los siguientes datos:
%       nombre real, nombre del equipo al que pertenece y
%       lista de poderes (deberá mostrar los nombres de los poderes no lo códigos). Regla sugerida: regla1/4.

% regla1/4
%   Argumentos: 
%       Codigo: Código de personaje
%       NombreReal: Nombre real del personaje
%       NombreEquipo: Nombre del equipo al que pertenece el personaje
%       Poderes: Lista de poderes del personaje, formada por los nombres de los mismos

regla1(Codigo, NombreReal, NombreEquipo, Poderes) :-
    personaje(Codigo, _, NombreReal, CodigoEquipo, ListaPoderes),
    equipo(CodigoEquipo, NombreEquipo, _),
    findall(Poder,
        (
            member(X, ListaPoderes),
            poder(X, Poder, _)
        ), Poderes).

% 2)	Si existe o no algún personaje que siendo de avengers tenga 
%       como poder la fuerza sobrehumana pero no cuenta con agilidad. Regla sugerida: regla2/0.

% regla2/0

regla2() :-
    personaje(_,_,_,1,ListaPoderes),
    member(fs, ListaPoderes),
    not(member(ag, ListaPoderes)), !.

% 3)	Para cierto código de personaje, calcular su peso total 
%       en base a unidades totales de combate según sus poderes. Regla sugerida: regla3/2. 
%       Este valor se calcula de la siguiente manera:
%       Se suma el peso en unidades de combate de cada poder 
%       y se lo multiplica por un factor que depende del equipo
%       al que pertenece el personaje.

% regla3/2
%   Argumentos:
%       Codigo: Código de presonaje
%       Peso: Peso total del personaje en unidades totales de combate

regla3(Codigo, Peso) :-
    personaje(Codigo, _, _, CodigoEquipo, ListaPoderes),
    equipo(CodigoEquipo, _, FactorEquipo),
    findall(Peso,
        (
            member(Poder, ListaPoderes),
            poder(Poder, _, Peso)
        ), PesosPoderes),
    sumlist(PesosPoderes, SumaPesosPoderes),
    Peso is SumaPesosPoderes * FactorEquipo.

% 4)	Determinar para un nombre de equipo, la lista de nombres de personajes 
%       que lo conforman. Regla sugerida: regla4/3.

% regla4/2
%   Argumentos:
%       NombreEquipo: Nombre del equipo
%       ListaNombres: Lista formada por los nombres de los personajes participantes del equipo

regla4(NombreEquipo, ListaNombres) :-
    equipo(CodigoEquipo, NombreEquipo, _),
    findall(NombrePersonaje,
        (
            personaje(_, _, NombrePersonaje, CodigoEquipo, _)
        ), ListaNombres).

% 5)	Dado el código de un equipo generar una lista de tuplas. 
%       Cada tupla deberá tener 2 elementos.
%       El primer elemento de cada tupla es el nombre de un personaje 
%       del equipo y el segundo elemento es
%       el peso total en base a unidades totales de combate según
%       los poderes del personaje
%       (se puede reutilizar la regla 3): regla5/1.

% regla5/2
%   Argumentos:
%       CodigoEquipo: Código del equipo
%       ListaEquipos: Lista de los personajes del equipo, formada por tuplas que poseen los nombres de cada personaje y su peso total en unidades totales de combate

regla5(CodigoEquipo, ListaEquipos) :- 
    findall((NombrePersonaje, PesoTotal),
        (
            personaje(Codigo, _, NombrePersonaje, CodigoEquipo, _),
            regla3(Codigo, PesoTotal)
        ), ListaEquipos).
