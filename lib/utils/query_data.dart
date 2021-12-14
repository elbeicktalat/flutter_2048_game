import 'package:flutter/cupertino.dart';

late MediaQueryData queryData;

double boardSize = queryData.size.width - 8.0 * 2;
double tileSize = (boardSize - 8.0) / 4;
double toggleWidth = queryData.size.width * 0.4;
double toggleHeight = queryData.size.height * 0.08;
