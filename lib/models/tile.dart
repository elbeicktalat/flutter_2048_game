class Tile {
  int row;
  int column;
  int value;
  bool canMerge;

  Tile({
    required this.row,
    required this.column,
    this.value = 0,
    this.canMerge = false,
  });

  bool get isEmpty => value == 0;

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return other is Tile && value == other.value;
  }
}
