import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/models/category.dart';
import 'package:flutter_sqflite_todolist_app/repositories/database_connection.dart';
import 'package:flutter_sqflite_todolist_app/screens/home_screen.dart';
import 'package:flutter_sqflite_todolist_app/service/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> _dataList = [];

  _addItems(int? id, String? title, String? description) {
    TextEditingController titleController = TextEditingController();
    TextEditingController desController = TextEditingController();
    if (id != null) {
      titleController.text = title!;
      desController.text = description!;
    }
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
            title: Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Write a Title',
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: desController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var title = titleController.text.toString();
                      var des = desController.text.toString();
                      if (id == null) {
                        SQLHelper.insertData(title, des).then((value) => {
                              if (value != -1)
                                {
                                  print("Data inserted Successfully"),
                                }
                              else
                                {
                                  print("failed to insert"),
                                }
                            });
                      }
                    },
                    child: Text("add"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getAllData() async {
    var List = await SQLHelper.getAllData();
    setState(() {
      _dataList = List;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: RaisedButton(
          onPressed: () => {
            getAllData(),
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          },
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.blue,
        ),
      ),
      body: Center(
        child: Text('Welcome to Categories Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItems(null, null, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
