## Overview

#### tents(RowTents, ColumnTents, Trees, Tents)
- RowTents: Number of tents per row
- ColumnTents: Number of tents per column
- Trees: Positions of trees
- Tents: Positions of placed tents 
<br />

## Visualization

The below describes a 5x5 field where the trees are represented as "Y". <br />
We want to place the minimum number of tents with the following constraints: <br />
1. We can't place a tent where a tree is.
2. Two tents can't be in nearby positions (horizontal, vertical, diagonal).
3. At least one (more is possible) tent must be placed around a tree.
4. Can't place more than the maximum number of tents on rows and columns.

<br />

|       |   1   |   2   |   3   |   4   |   5   |       |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|   1   |       |   Y   |       |       |       |   0   |
|   2   |       |       |       |       |   Y   |       |
|   3   |       |       |   Y   |       |       |       |
|   4   |       |       |       |       |       |   3   |
|   5   |   Y   |       |       |       |   Y   |       |
|       |   1   |   1   |       |       |   1   |       |
<br />

One possible solution for the above field, where "Δ" stands for a tent, is the following:

<br />

|       |   1   |   2   |   3   |   4   |   5   |       |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|   1   |       |   Y   |       |       |       |   0   |
|   2   |       |       |   Δ   |       |   Y   |       |
|   3   |       |       |   Y   |       |   Δ   |       |
|   4   |       |       |       |       |       |   3   |
|   5   |   Y   |   Δ   |       |   Δ   |   Y   |       |
|       |   1   |   1   |       |       |   1   |       |
<br />



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
  
