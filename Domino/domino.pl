:- set_flag(print_depth, 1000).

dominos([(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),
(2,2),(2,3),(2,4),(2,5),(2,6),
(3,3),(3,4),(3,5),(3,6),
(4,4),(4,5),(4,6),
(5,5),(5,6),
(6,6)]).

frame([[3,1,2,6,6,1,2,2],
[3,4,1,5,3,0,3,6],
[5,6,6,1,2,4,5,0],
[5,6,4,1,3,3,0,0],
[6,1,0,6,3,2,4,0],
[4,1,5,2,4,3,5,5],
[4,1,0,2,4,5,2,0]]).


put_dominos :-
	dominos(Dominos),
	frame(Frame),
	length(Dominos, Length),
	generate_solution(Dominos, Solution),
	possible_positions(Dominos, Frame, Possible_pos),
	put_dominos1(Possible_pos, Length, Solution, L),
	frame_fix(Frame, L, 1, Frame1), !,
	show(Frame1). 
		
put_dominos1(_, 0, Solution, Solution).
put_dominos1(Possible_pos, Count, Solution, L):-
	list_min(Possible_pos, Solution, 999, Min),
	indexOf(Possible_pos, Solution, Min, Position), 
	select_position(Possible_pos, Position, Coordinates),		
	ins(Coordinates, Solution, Position, Solution1),
	delList(Possible_pos, Coordinates, Possible_pos2),	
	Count1 is Count - 1,
	put_dominos1(Possible_pos2, Count1, Solution1, L).			

	
possible_positions([], _, []).
possible_positions([(D1, D2) | T1], Frame, [Place | T2]):-
	byline(D1, D2, 1, Frame, Place1),
	transpose(Frame, Frame1),
	bycollumn(D1, D2, 1, Frame1, Place2),
	append(Place1, Place2, Place),
	possible_positions(T1, Frame, T2).	
	
	
byline(_, _, _, [], []).
byline(H1, H2, Line, [H | T], Place):-
	byline1(H1, H2, Line, 1, H, Place1),
	Line1 is Line + 1,
	byline(H1, H2, Line1, T, Place2),
	append(Place1, Place2, Place).
	
byline1(_, _, _, _, [], []).
byline1(D1, D2, Line, Column, [D1, D2 | T1], [(Line, Column, Line, Column1) | T2]):- 
	Column1 is Column + 1,
	byline1(D1, D2, Line, Column1, [D2 | T1], T2).
byline1(D1, D2, Line, Column, [D2, D1 | T1], [(Line, Column, Line, Column1) | T2]):- 
	Column1 is Column + 1,	
	byline1(D1, D2, Line, Column1, [D1 | T1], T2).
byline1(D1, D2, Line, Column, [ _ | T1], L2):-
	Column1 is Column + 1,
	byline1(D1, D2, Line, Column1, T1, L2).
	

transpose([ [] | _ ], []).
transpose(M, [X | T]) :- 
	row(M, X, M1), 
	transpose(M1, T).
	
row([], [], []).
row([[X | Xs] | Ys], [X | R], [Xs | Z]) :- 
	row(Ys, R, Z).	

	
bycollumn(_, _, _, [], []).
bycollumn(H1, H2, Line, [H | T], Place):-
	bycollumn1(H1, H2, Line, 1, H, Place1),
	Line1 is Line + 1,
	bycollumn(H1, H2, Line1, T, Place2),
	append(Place1, Place2, Place).	
	
bycollumn1(_, _, _, _, [], []).
bycollumn1(D1, D2, Line, Column, [D1, D2 | T1], [(Column, Line, Column1, Line) | T2]):- 
	Column1 is Column + 1,
	bycollumn1(D1, D2, Line, Column1, [D2 | T1], T2).
bycollumn1(D1, D2, Line, Column, [D2, D1 | T1], [(Column, Line, Column1, Line) | T2]):-
	Column1 is Column + 1,	
	bycollumn1(D1, D2, Line, Column1, [D1 | T1], T2).
bycollumn1(D1, D2, Line, Column, [ _ | T1], L2):-
	Column1 is Column + 1,
	bycollumn1(D1, D2, Line, Column1, T1, L2).	
	
	
delList([], _, []).
delList([H | T1], Coordinates, [L1 | T2]):-
	delMember(Coordinates, H, L1),
	delList(T1, Coordinates, T2).
	
delMember(_, [], []).
delMember([(X1, Y1, X2, Y2)], [(X1, Y1, _, _) | T], L) :- !, 
	delMember([(X1, Y1, X2, Y2)], T, L).
delMember([(X1, Y1, X2, Y2)], [(X2, Y2, _, _) | T], L) :- !, 
	delMember([(X1, Y1, X2, Y2)], T, L).
delMember([(X1, Y1, X2, Y2)], [(_, _, X1, Y1) | T], L) :- !, 
	delMember([(X1, Y1, X2, Y2)], T, L).
delMember([(X1, Y1, X2, Y2)], [(_, _, X2, Y2) | T], L) :- !, 
	delMember([(X1, Y1, X2, Y2)], T, L).
delMember(Coordinates, [H|T1], [H|T2]) :- !,
	delMember(Coordinates, T1, T2).
	
generate_solution([_], [[]]).
generate_solution([_ | T1], [[] | T2]) :-
  generate_solution(T1, T2).
 
list_min([], [], Min, Min).
list_min([H | T], [[] | T2], Min0, Min) :- 
    Min1 is min(length(H), Min0),
    list_min(T, T2, Min1, Min).	
list_min([_ | T], [[_] | T2], Min0, Min) :- 	
    list_min(T, T2, Min0, Min).	
		
indexOf([H | _ ], [[] | _], Count, 1):- length(H) =:= Count.
indexOf([ _ | T], [_ | T2], Count, Position):-
  indexOf(T, T2, Count, Position1), !,
  Position is Position1 + 1 .

not_empty([_ | _]).

select_position([_ | T1], Count, L2):- 
	Count1 is Count - 1, 
	select_position(T1, Count1, L2).	
select_position([H1 | _], 1, [H2]):-	
	not_empty(H1),	
	member(H2, H1).
		
ins(Val, [H1 | T1], Pos, [H1 | T2]):-
    Pos1 is Pos - 1, 
	ins(Val, T1, Pos1, T2). 
ins(Val, [_ | List], 1, [Val | List]).

show([]).
show([H|T]):-
    print_line(H),
    show(T).	
	
print_line([]):- nl.
print_line([H|T]) :-
    write(H),
    print_line(T).

frame_fix_odd_line([], _, _, ' ').
frame_fix_odd_line([[(Line, Row, Line, Row1)] | _], Line, Row, '-'):-		
	Row1 is Row + 1 .
frame_fix_odd_line([_ | T1], Line, Row, T2):-		
	frame_fix_odd_line(T1, Line, Row, T2).

frame_fix_odd([], _, _, _, []).
frame_fix_odd([H1 | T1], L, Line, Row, [H1, H2 | T2]):-
	frame_fix_odd_line(L, Line, Row, H2),
	Row1 is Row + 1,
	frame_fix_odd(T1, L, Line, Row1, T2).

frame_fix_even_line([], _, _, ' ').
frame_fix_even_line([[(Line, Row, Line1, Row)] | _], Line, Row, '|'):-
	Line1 is Line + 1 .
frame_fix_even_line([_ | T1], Line, Row, T2):-
	frame_fix_even_line(T1, Line, Row, T2).

frame_fix_even([], _, _, _, []).
frame_fix_even([_ | T1], L, Line, Row, [H2, ' ' | T2]):-
	frame_fix_even_line(L, Line, Row, H2),
	Row1 is Row + 1,
	frame_fix_even(T1, L, Line, Row1, T2).

frame_fix([], _, _, []).	
frame_fix([H1 | T1], Solution, Line, [H2, H3 | T2]):-
	frame_fix_odd(H1, Solution, Line, 1, H2),
	frame_fix_even(H1, Solution, Line, 1, H3), 
	Line1 is Line + 1, 
	frame_fix(T1, Solution, Line1, T2).