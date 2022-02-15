import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/helpers/drawer_navigaton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todolist Sqflite'),
      ),
      drawer: DrawerNavigaton(),
    );
  }
}
