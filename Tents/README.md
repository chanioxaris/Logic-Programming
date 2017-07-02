## Overview

#### tents(RowTents, ColumnTents, Trees, Tents)
- RowTents: Number of tents per row
- ColumnTents: Number of tents per column
- Trees: Positions of trees
- Tents: Positions of tents to be placed


## Input examples

- ?- tents([0, -1, -1, 3, -1], [1, 1, -1, -1, 1], [1-2, 2-5, 3-3, 5-1, 5-5], Tents).
  * Tents = [2 - 3, 3 - 5, 5 - 2, 5 - 4] --> ;
  * Tents = [2 - 3, 3 - 5, 4 - 2, 5 - 4] --> ;
  * Tents = [2 - 3, 3 - 5, 4 - 1, 5 - 4] --> ;
  * Tents = [2 - 2, 3 - 5, 4 - 1, 5 - 4] --> ;
  * ......................  
  <br />
  
- ?- tents([-1, -1, -1, 2, -1, -1, 2, 1], [2, 1, -1, 1, 1, -1, 1, -1, -1, 1, 2, -1], [1-4, 1-9, 1-12, 2-1, 2-5, 2-8, 3-1, 3-6, 3-8, 3-12, 4-5, 4-7, 4-11, 5-3, 5-9, 6-1, 6-7, 6-11, 7-5, 8-10], Tents).
  * Tents = [2 - 4, 2 - 9, 2 - 12, 3 - 2, 4 - 6, 5 - 10, 6 - 3, 7 - 1, 7 - 6, 8 - 11] --> ;
  * Tents = [2 - 4, 2 - 9, 2 - 12, 3 - 2, 4 - 6, 5 - 10, 6 - 3, 7 - 1, 7 - 6, 8 - 9] --> ;
  * Tents = [2 - 4, 2 - 9, 2 - 12, 3 - 2, 4 - 6, 5 - 10, 6 - 3, 6 - 6, 7 - 1, 8 - 11] --> ;
  * ......................  
  <br />
  
