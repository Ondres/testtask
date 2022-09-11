import 'package:flutter/material.dart';
import 'package:savenko_test/screens/home.dart';
import 'package:savenko_test/screens/preview.dart';
import 'package:savenko_test/screens/process.dart';
import 'package:savenko_test/screens/resultlist.dart';


void main()
{
  runApp(MaterialApp(
    initialRoute: '/',
    title: 'Destination',
    routes: {
      '/': (context) =>HomeScr(title: 'Home Screen'),
      '/1': (context) =>ProcessScr(title: 'Process Screen'),
      '/2': (context) =>ResultsScr(title: 'Results Screen'),
      '/3': (context) =>PreviewScr(title: 'Preview Screen'),

    },


  ));

}


