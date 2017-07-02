:- set_flag(print_depth, 1000).
:- lib(ic).
:- lib(branch_and_bound).

maxclq(N, D, Clique, Size):-
	create_graph(N, D, Graph),
	write(Graph), nl,
	length(Solution, N),
	Solution #:: 0..1,
	constrain(Solution, 1, Graph),
	Cost #= N - sum(Solution),
	bb_min(labeling(Solution), Cost, bb_options{strategy:restart}),	
	generate_solution(Solution, 1, Clique),
	length(Clique, Size).

	
constrain([], _, _).	
constrain([Elem | T], Node, Graph):- 
	Node1 is Node + 1,
	constrain1(Elem, T, Node, Node1, Graph),
	constrain(T, Node1, Graph).

constrain1(_, [], _, _, _).
constrain1(Elem, [Elem1 | T], Node, Node1, Graph):- 
	not member(Node - Node1, Graph), !,
	Elem + Elem1 #=< 1,
	Node2 is Node1 + 1,
	constrain1(Elem, T, Node, Node2, Graph).
constrain1(Elem, [Elem1 | T], Node, Node1, Graph):- 
	Node2 is Node1 + 1,
	constrain1(Elem, T, Node, Node2, Graph).


generate_solution([], _, []).	
generate_solution([0 | T], Node, L):-
	Node1 is Node + 1,
	generate_solution(T, Node1, L).
generate_solution([1 | T], Node, [ Node | T2]):-
	Node1 is Node + 1,
	generate_solution(T, Node1, T2).


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
      append(SoFarGraph, [N1 - N2], NewSoFarGraph) ;
      NewSoFarGraph = SoFarGraph),
   NN2 is N2 + 1,
   cr_gr(N1, NN2, NNodes, Density, NewSoFarGraph, Graph).

rand(N1, N2, R) :-
   random(R1),
   R is R1 mod (N2 - N1 + 1) + N1.