multi_Reverse2(_,[],[]).
multi_Reverse2([H1|T1], [H2|T2], [H3|T3]) :-
	H3 is H1 * H2,
	multi_Reverse2([H1|T1], T2, T3).

	
multi_Reverse([],_,[]).
multi_Reverse([H1|T1], H2, [H3|T3]) :-
	multi_Reverse2([H1|T1], H2, H3),
	multi_Reverse(T1, H2, T3).
	
		
add_Matrix2([],[],[]).
add_Matrix2([H1|T1], [H2|T2], [H3|T3]) :-
	H3 is H1 + H2,
	add_Matrix2(T1, T2, T3).		
		
		
add_Matrix([],[],[]).
add_Matrix(L,[],L).
add_Matrix([H1|T1], [H2|T2], [H3|T3]) :-
	add_Matrix2(H1, H2, H3),
	add_Matrix(T1, T2, T3).
	

identity2(_,0,[]).
identity2(M,N,[0|Tail]):- M \= N,
	N1 is N-1,
 	identity2(M,N1,Tail).
identity2(M,N,[-1|Tail]):-
	N1 is N-1,
 	identity2(M,N1,Tail).	
	
		
identity(0,_,[]).
identity(M, N,[Head|Tail]):-
	identity2(M,N,Head),
	M1 is M-1,
	identity(M1,N,Tail).


length_Hop([], 0).
length_Hop([_|Tail], M) :-
	length_Hop(Tail, M1),
	M is M1 + 1 .

	
		
hopfield([],[]).
hopfield([H|T],W):-
	multi_Reverse(H,H,L1),
	length(H,N),
	identity(N,N,L2),
	add_Matrix(L1,L2,L3),
	hopfield(T,W1),
	add_Matrix(L3,W1,W).
		