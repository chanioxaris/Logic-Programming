## Overview

#### maxclq(N, D, Clique, Size):-
- N: Number of graph nodes
- D: Graph's density
- Clique: List of clique's nodes
- Size: Size of clique


## Input examples

- ?- maxclq(15, 60, Clique, Size).
  * Clique = [2, 3, 5, 8, 9, 15]
  * Size = 6
  <br />
  
- ?- maxclq(80, 50, Clique, Size).
  * Clique = [1, 3, 7, 42, 44, 51, 72, 79]
  * Size = 8
  <br />
  
- ?- maxclq(165, 30, Clique, Size).
  * Clique = [12, 54, 81, 95, 108, 109, 130]
  * Size = 7
  <br />
  
  
- ?- maxclq(300, 15, Clique, Size).
  * Clique = [1, 4, 69, 138, 232]
  * Size = 5
  <br />
  
  
- ?- maxclq(500, 10, Clique, Size).
  * Clique = [1, 38, 156, 176, 335]
  * Size = 5
  <br />
  
- ?- maxclq(800, 2, Clique, Size).
  * Clique = [1, 107, 272]
  * Size = 3
  <br />
