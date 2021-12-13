import 'package:flutter/material.dart';
import 'package:game_2048/models/board.dart';
import 'package:game_2048/utils/colors.dart';
import 'package:game_2048/utils/query_data.dart';
import 'package:game_2048/views/widget/tile.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late Board _board;
  late int _row;
  late int _column;

  @override
  void initState() {
    super.initState();
    _row = 4;
    _column = 4;
    _board = Board(_row, _column);

    newGame();
  }

  void newGame() {
    setState(() {
      _board.initBoard();
    });
  }

  Iterable<Widget> getRenderedTiles() {
    List<List<Widget>> tileWidgets = List.generate(4, (row) {
      return List.generate(4, (column) {
        return Positioned(
          top: row * tileSize,
          left: column * tileSize,
          width: tileSize,
          height: tileSize,
          child: Center(child: TileWidget(tile: _board.getTile(row, column))),
        );
      });
    });
    return tileWidgets.expand((e) => e);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    List<Widget> children = [];
    children.addAll(getRenderedTiles());

    if (_board.gameOver() || _board.gameVictory()) {
      children.add(
        Opacity(
          opacity: 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: boardColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      );
      children.add(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _board.gameOver()
                    ? 'Game Over'
                    : _board.gameVictory()
                        ? 'Game Victory'
                        : '',
                style: GoogleFonts.sourceSansPro(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                _board.gameOver()
                    ? 'Press New Game Button To Start again!'
                    : _board.gameVictory()
                        ? 'Congratulation You Win The Game!'
                        : '',
                style: GoogleFonts.sourceSansPro(
                  fontSize: 36.0,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2048', style: Theme.of(context).textTheme.headline1),
                  Text(
                    'Join the tiles, get to 2048!',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 24.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'How to play?',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 18.0,
                      decoration: TextDecoration.underline,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: toggleWidth,
                        height: toggleHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Score',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              _board.score.toString(),
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 36.0,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: tileColors[0],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      const SizedBox(width: 18.0),
                      Container(
                        width: toggleWidth,
                        height: toggleHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Record',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              _board.score.toString(),
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 36.0,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: tileColors[0],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: toggleWidth,
                    height: toggleHeight,
                    child: ElevatedButton(
                      onPressed: () => newGame(),
                      child: Text(
                        'Start New',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff8f7a66),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28.0),
        Container(
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
                setState(() {
                  _board.moveUp();
                });
              } else if (details.velocity.pixelsPerSecond.dy > 250) {
                setState(() {
                  _board.moveDown();
                });
              }
            },
            onHorizontalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx < -1000) {
                setState(() {
                  _board.moveLeft();
                });
              } else if (details.velocity.pixelsPerSecond.dx > 1000) {
                setState(() {
                  _board.moveRight();
                });
              }
            },
            child: Stack(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
