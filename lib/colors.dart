import 'package:flutter/material.dart';

Color green = Color.fromARGB(255, 0, 166, 68);

Map<int, Color> greenMap =
{
50:Color.fromRGBO(0, 166, 68, .1),
100:Color.fromRGBO(0, 166, 68, .2),
200:Color.fromRGBO(0, 166, 68, .3),
300:Color.fromRGBO(0, 166, 68, .4),
400:Color.fromRGBO(0, 166, 68, .5),
500:Color.fromRGBO(0, 166, 68, .6),
600:Color.fromRGBO(0, 166, 68, .7),
700:Color.fromRGBO(0, 166, 68, .8),
800:Color.fromRGBO(0, 166, 68, .9),
900:Color.fromRGBO(0, 166, 68, 1),
};

MaterialColor greenSwatch = MaterialColor(0xff00a644, greenMap);
