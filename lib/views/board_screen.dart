import 'package:flutter/material.dart';
import 'package:game_2048/models/board.dart';
import 'package:game_2048/utils/colors.dart';
import 'package:game_2048/utils/query_data.dart';
import 'package:game_2048/views/widget/board.dart';
import 'package:game_2048/views/widget/tile.dart';
import 'package:game_2048/views/widget/toggle.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '2048',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Toggle(
                  title: 'Score',
                  subTitle: _board.score.toString(),
                ),
                Toggle(
                  title: 'Record',
                  subTitle: _board.score.toString(),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: toggleWidth,
                  height: toggleHeight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Undo',
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
                ),
                SizedBox(
                  width: toggleWidth,
                  height: toggleHeight,
                  child: ElevatedButton(
                    onPressed: () => newGame(),
                    child: Text(
                      'New Game',
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
                ),
              ],
            ),
          ],
        ),
        BoardWidget(
          moveLeft: () => setState(() => _board.moveLeft()),
          moveRight: () => setState(() => _board.moveRight()),
          moveUp: () => setState(() => _board.moveUp()),
          moveDown: () => setState(() => _board.moveDown()),
          children: children,
        ),
      ],
    );
  }
}
