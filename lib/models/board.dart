import 'dart:math' show Random;

import 'package:game_2048/models/tile.dart';

class Board {
  final int row;
  final int column;
  late int score;
  late List<List<Tile>> _tiles;

  Board(this.row, this.column);

  void initBoard() {
    _tiles = List.generate(4, (r) {
      return List.generate(4, (c) {
        return Tile(row: r, column: c, canMerge: false, value: 0);
      });
    });

    score = 0;
    resetCanMerge();
    randomTile();
    randomTile();
  }

  Tile getTile(int row, int column) {
    return _tiles[row][column];
  }

  void randomTile() {
    Random random = Random();
    List<Tile> tiles = <Tile>[];

    for (var rows in _tiles) {
      tiles.addAll(rows.where((tile) => tile.isEmpty));
    }

    if (tiles.isEmpty) {
      return;
    }

    int index = random.nextInt(tiles.length);
    tiles[index].value = random.nextInt(9) == 0 ? 4 : 2;
    tiles.removeAt(index);
  }

  bool canMoveLeft() {
    for (int r = 0; r < row; ++r) {
      for (int c = 1; c < column; ++c) {
        if (canMerge(_tiles[r][c], _tiles[r][c - 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveRight() {
    for (int r = 0; r < row; ++r) {
      for (int c = column - 2; c >= 0; --c) {
        if (canMerge(_tiles[r][c], _tiles[r][c + 1])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveUp() {
    for (int r = 1; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        if (canMerge(_tiles[r][c], _tiles[r - 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  bool canMoveDown() {
    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < column; ++c) {
        if (canMerge(_tiles[r][c], _tiles[r + 1][c])) {
          return true;
        }
      }
    }
    return false;
  }

  void moveLeft() {
    if (!canMoveLeft()) return;

    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        mergeLeft(r, c);
      }
    }
    randomTile();
    resetCanMerge();
  }

  void moveRight() {
    if (!canMoveRight()) return;

    for (int r = 0; r < row; ++r) {
      for (int c = column - 2; c >= 0; --c) {
        mergeRight(r, c);
      }
    }
    randomTile();
    resetCanMerge();
  }

  void moveUp() {
    if (!canMoveUp()) return;

    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        mergeUp(r, c);
      }
    }
    randomTile();
    resetCanMerge();
  }

  void moveDown() {
    if (!canMoveDown()) return;

    for (int r = row - 2; r >= 0; --r) {
      for (int c = 0; c < column; ++c) {
        mergeDown(r, c);
      }
    }
    randomTile();
    resetCanMerge();
  }

  bool canMerge(Tile a, Tile b) {
    return (b.isEmpty && !a.isEmpty) || (!a.isEmpty && a == b);
  }

  void merge(Tile a, Tile b) {
    if (!canMerge(a, b)) {
      if (!a.isEmpty && !b.canMerge) {
        b.canMerge = true;
      }
      return;
    }

    if (b.isEmpty) {
      b.value = a.value;
      a.value = 0;
    } else if (a == b) {
      b.value = b.value + a.value;
      a.value = 0;
      score += b.value;
      b.canMerge = true;
    }
  }

  void mergeLeft(int row, int column) {
    while (column > 0) {
      merge(_tiles[row][column], _tiles[row][column - 1]);
      column--;
    }
  }

  void mergeRight(int row, int column) {
    while (column < this.column - 1) {
      merge(_tiles[row][column], _tiles[row][column + 1]);
      column++;
    }
  }

  void mergeUp(int row, int column) {
    while (row > 0) {
      merge(_tiles[row][column], _tiles[row - 1][column]);
      row--;
    }
  }

  void mergeDown(int row, int column) {
    while (row < this.row - 1) {
      merge(_tiles[row][column], _tiles[row + 1][column]);
      row++;
    }
  }

  void resetCanMerge() {
    for (var rows in _tiles) {
      for (var tile in rows) {
        tile.canMerge = false;
      }
    }
  }

  bool gameOver() {
    return !canMoveLeft() && !canMoveRight() && !canMoveUp() && !canMoveDown();
  }

  bool gameVictory() {
    for (var row in _tiles) {
      for (var column in row) {
        if (column.value == 2048) {
          return true;
        }
      }
    }
    return false;
  }
}
