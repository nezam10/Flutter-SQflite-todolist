import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/screens/home_screen.dart';
import 'package:flutter_sqflite_todolist_app/screens/login_screen.dart';
import 'package:flutter_sqflite_todolist_app/screens/splash_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
