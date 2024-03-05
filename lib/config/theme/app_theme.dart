import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.blueGrey,
  Colors.brown,
  Colors.deepOrange,
  Colors.indigo
];

class AppTheme {

  final int selectecColor;

  AppTheme({
    this.selectecColor = 0
  }):assert( selectecColor >= 0, 'Selected color must be greater than 0' ) ,
      assert( selectecColor <= colorList.length, 'Selected color must be less or equal than ${colorList.length-1}' ) ;

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[ selectecColor ],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    )
  );

}