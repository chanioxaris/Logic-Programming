:- set_flag(print_depth, 1000).
:- lib(ic).
:- lib(branch_and_bound).

tents(RowTents, ColumnTents, Trees, Tents):-
	length(RowTents, N),
	length(ColumnTents, M),
	create_grid(N, M, Grid),
	Grid #:: 0..1,
	constrains(Grid, RowTents, ColumnTents, Trees),
	flatten(Grid, Grid_flat),
	Cost #= sum(Grid_flat),
	bb_min(labeling(Grid_flat), Cost, bb_options{strategy:restart}),  
	create_grid(N, M, Grid1),
	Grid1 #:: 0..1,
	constrains(Grid1, RowTents, ColumnTents, Trees),
	flatten(Grid1, Grid1_flat),
	Cost #= sum(Grid1_flat),
	labeling(Grid1_flat),
	create_tents(Grid1_flat, M, 1, Tents).
	

constrains(Grid, RowTents, ColumnTents, Trees):-
	constrains_row(Grid, RowTents),
	transpose(Grid, GridTransposed),
	constrains_column(GridTransposed, ColumnTents),
	constrains_trees_tents(Grid, Trees),
	constrains_tents(Grid, Grid, 1),
	constrains_trees(Grid, Trees).


constrains_row(_, []):- ! .
constrains_row([H1 | T1], [H2 | T2]):-
	H2 >= 0,
	sum(H1) #=< H2,
	constrains_row(T1, T2).
constrains_row([_ | T1], [H2 | T2]):-
	H2 < 0,
	constrains_row(T1, T2).	


constrains_column(_, []):- ! .
constrains_column([H1 | T1], [H2 | T2]):-
	H2 >= 0,
	sum(H1) #=< H2,
	constrains_column(T1, T2).
constrains_column([_ | T1], [H2 | T2]):-
	H2 < 0,
	constrains_column(T1, T2).		

	
constrains_trees_tents(_, []):- ! .	
constrains_trees_tents(Grid, [Row-Col | T]):-
	get_elem(Grid, Row, Col, Elem),
	Elem #= 0,
	constrains_trees_tents(Grid, T).		
	

constrains_tents(_, [], _):- ! .	
constrains_tents(Grid, [H | T], Row):-
	constrains_tents1(Grid, H, Row, 1),
	Row1 is Row + 1,
	constrains_tents(Grid, T, Row1).
	
constrains_tents1(_, [], _, _):- ! .	 
constrains_tents1(Grid, [_ | T], Row, Col):-
	NextRow is Row + 1,
	NextCol is Col + 1,
	
	get_elem(Grid, Row, Col, Elem1),
	get_elem(Grid, Row, NextCol, Elem2),
	get_elem(Grid, NextRow, Col, Elem3),
	get_elem(Grid, NextRow, NextCol, Elem4),
	
	Elem1+Elem2+Elem3+Elem4 #=< 1,
	
	Col1 is Col + 1,
	constrains_tents1(Grid, T, Row, Col1).
	

constrains_trees(_, []):- ! .
constrains_trees(Grid, [Row-Col | T]):- 
	PrevRow is Row - 1,
	NextRow is Row + 1,
	PrevCol is Col - 1,
	NextCol is Col + 1,
	
	get_elem(Grid, PrevRow, PrevCol, Elem1),
	get_elem(Grid, PrevRow, Col, Elem2),
	get_elem(Grid, PrevRow, NextCol, Elem3),
	get_elem(Grid, Row, PrevCol, Elem4),
	get_elem(Grid, Row, NextCol, Elem5),
	get_elem(Grid, NextRow, PrevCol, Elem6),
	get_elem(Grid, NextRow, Col, Elem7),
	get_elem(Grid, NextRow, NextCol, Elem8),
		
	Elem1+Elem2+Elem3+Elem4+Elem5+Elem6+Elem7+Elem8 #>= 1,
	
	constrains_trees(Grid, T).
	
	
get_elem([], _, _, 0):- ! .
get_elem(_, Col, _, 0):- Col < 1, ! .
get_elem([H | _], 1, Col, Elem):-
	get_elem1(H, Col, Elem), ! .	
get_elem([_ | T], Row, Col, Elem):-
	Row1 is Row - 1,
	get_elem(T, Row1, Col, Elem).

get_elem1(_, Col, 0):- Col < 1, ! .
get_elem1([], _, 0):- ! .
get_elem1([H | _], 1, H):- ! .
get_elem1([_ | T], Col, Elem):-
	Col1 is Col - 1,
	get_elem1(T, Col1, Elem).
	

transpose([ [] | _ ], []).
transpose(M, [X | T]):- 
	row(M, X, M1), 
	transpose(M1, T).

row([], [], []).
row([[X | Xs] | Ys], [X | R], [Xs | Z]):- 
	row(Ys, R, Z).	
	
	
create_grid(0, _, []):- ! .
create_grid(Row, SizeCol, [H | T]):-
	length(H, SizeCol),
	Row1 is Row - 1,
	create_grid(Row1, SizeCol, T).	
	

create_tents([], _, _, []):- ! .
create_tents([0 | List], SizeCol, Pos, Tents):-
	Pos1 is Pos + 1,
	create_tents(List, SizeCol, Pos1, Tents).
create_tents([1 | List], SizeCol, Pos, [Row-Col | T]):-
	Row is (Pos-1) // SizeCol + 1,
	Col is (Pos-1) mod SizeCol + 1,	
	Pos1 is Pos+1,
	create_tents(List, SizeCol, Pos1, T).