import 'package:flutter/material.dart';
import 'package:game_2048/models/tile.dart';
import 'package:game_2048/utils/colors.dart';
import 'package:game_2048/utils/query_data.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({Key? key, required this.tile}) : super(key: key);
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    int tileValue = tile.value;
    return Container(
      width: tileSize - 10.0 * 2,
      height: tileSize - 10.0 * 2,
      decoration: BoxDecoration(
        color: tileColors[tile.value],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          (tileValue == 0) ? '' : tileValue.toString(),
          style: TextStyle(
            fontSize: 68.0,
            fontWeight: FontWeight.bold,
            color: (tileValue <= 4) ? const Color(0xff776e65) : Colors.white,
          ),
        ),
      ),
    );
  }
}
