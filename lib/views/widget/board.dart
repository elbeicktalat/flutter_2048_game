import 'package:flutter/material.dart';
import 'package:game_2048/utils/colors.dart';
import 'package:game_2048/utils/query_data.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    Key? key,
    required this.moveLeft,
    required this.moveRight,
    required this.moveUp,
    required this.moveDown,
    required this.children,
  }) : super(key: key);

  final VoidCallback moveLeft;
  final VoidCallback moveRight;
  final VoidCallback moveUp;
  final VoidCallback moveDown;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boardSize,
      height: boardSize,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: boardColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy < -250) {
            moveUp();
          } else if (details.velocity.pixelsPerSecond.dy > 250) {
            moveDown();
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < -1000) {
            moveLeft();
          } else if (details.velocity.pixelsPerSecond.dx > 1000) {
            moveRight();
          }
        },
        child: Stack(
          children: children,
        ),
      ),
    );
  }
}
