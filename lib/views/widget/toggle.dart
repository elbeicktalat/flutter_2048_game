import 'package:flutter/material.dart';
import 'package:game_2048/utils/query_data.dart';
import 'package:google_fonts/google_fonts.dart';

class Toggle extends StatelessWidget {
  const Toggle({
    Key? key,
    required this.title,
    required this.subTitle,
    this.background = const Color(0xffcdc1b4),
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: toggleWidth,
      height: toggleHeight,
      child: ListTile(
        isThreeLine: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          subTitle,
          style: GoogleFonts.sourceSansPro(
            fontSize: 28.0,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
