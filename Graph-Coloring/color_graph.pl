create_graph(NNodes, Density, Graph) :-
   cr_gr(1, 2, NNodes, Density, [], Graph).

   
cr_gr(NNodes, _, NNodes, _, Graph, Graph).
cr_gr(N1, N2, NNodes, Density, SoFarGraph, Graph) :-
   N1 < NNodes,
   N2 > NNodes,
   NN1 is N1 + 1,
   NN2 is NN1 + 1,
   cr_gr(NN1, NN2, NNodes, Density, SoFarGraph, Graph).
cr_gr(N1, N2, NNodes, Density, SoFarGraph, Graph) :-
   N1 < NNodes,
   N2 =< NNodes,
   rand(1, 100, Rand),
   (Rand =< Density ->
      append(SoFarGraph, [N1, N2], NewSoFarGraph) ;
      NewSoFarGraph = SoFarGraph),
   NN2 is N2 + 1,
   cr_gr(N1, NN2, NNodes, Density, NewSoFarGraph, Graph).

   
rand(N1, N2, R) :-
   random(R1),
   R is R1 mod (N2 - N1 + 1) + N1. 

   
max_list([],0).
max_list([H],H).
max_list([H|T],M):- 
	max_list(T,M1),
	M is max(H,M1).  
 
 
color_vertex(1, [1]).
color_vertex(N, [1|T]) :-
	N1 is N - 1,
	color_vertex(N1, T).

	
return_colour(_, P, P1, _) :- P1 is P + 1.
return_colour([H|T], P, Cou, Col) :- P =:= Cou,
	Col is H,
	Cou1 is Cou + 1,
	return_colour(T, P, Cou1, Col).
return_colour([_|T], P, Cou, Col) :- P \= Cou,
	Cou1 is Cou + 1,
	return_colour(T, P, Cou1, Col).
	

add_colour([], _, _, []).
add_colour([H|T], P, Cou, [H|K]) :- P \= Cou,
	Cou1 is Cou + 1,
	add_colour(T, P, Cou1, K).
add_colour([H|T], P, Cou, [H1|K]) :- P =:= Cou,
	H1 is H + 1,
	Cou1 is Cou + 1,
	add_colour(T, P, Cou1, K).
	
	
first_pass1(VC, CN1, CN2, _, VC) :- CN1 \= CN2.
first_pass1(VC, CN1, CN2, Pos, VC1) :- CN1 =:= CN2, 
	add_colour(VC, Pos, 1, VC1).
	

first_pass([], VC1, VC1).
first_pass([H1,H2|T], VC, VC2) :-
	return_colour(VC, H1, 1, CN1),
	return_colour(VC, H2, 1, CN2),
	first_pass1(VC, CN1, CN2, H2, VC1),
	first_pass(T, VC1, VC2).
	
	
second_pass([], VC1, VC1).
second_pass([H1,H2|T], VC, VC2) :-
	return_colour(VC, H1, 1, CN1),
	return_colour(VC, H2, 1, CN2),
	first_pass1(VC, CN1, CN2, H1, VC1),
	second_pass(T, VC1, VC2).
	
	
   
color_graph(N, D, Col, VC2) :-
	create_graph(N, D, G),
	color_vertex(N, VC),
	first_pass(G, VC, VC1),
	reverse(G, G1),
	second_pass(G1, VC1, VC2),
	max_list(VC2, Col).
	