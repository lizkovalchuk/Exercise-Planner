import 'package:flutter/material.dart';

import 'main_home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Exercise Planner',
        theme: ThemeData(
          primaryColor: Colors.blue,
          bottomAppBarColor: Colors.green
        ),
        home: MainHomePage(title: 'Exercise Planner',),
    );
  }
}
