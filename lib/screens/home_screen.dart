import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/helpers/drawer_navigaton.dart';
import 'package:flutter_sqflite_todolist_app/repositories/database_connection.dart';
import 'package:flutter_sqflite_todolist_app/screens/categories_screen.dart';
import 'package:flutter_sqflite_todolist_app/screens/view_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  getAllData();
                  Navigator.pop(context);
                },
                child: Text("add"),
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
                ],
              ),
            ),
          );
        });
  }

  // init() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   var c = sp.getStringList("_dataList");
  //   setState(() {
  //     _dataList = c!.cast<Map<String, dynamic>>();
  //   });
  // }

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
        title: Text('Todolist Sqflite'),
      ),
      drawer: DrawerNavigaton(),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoteScreen(
                        title: _dataList[position]["title"].toString(),
                        description:
                            _dataList[position]["description"].toString()),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 2, right: 2),
              child: Card(
                color: Colors.red[200],
                elevation: 3,
                child: Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.4,
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext) {},
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext) {
                          SQLHelper.deleteData(_dataList[position]["id"]);
                          getAllData();
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      _dataList[position]["title"].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _dataList[position]["description"].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ViewNoteScreen(
                    //                 title: Text(
                    //                     _dataList[position]["title"].toString()),
                    //                 description: Text(
                    //                     _dataList[position]["title"].toString()),
                    //               )));
                    // },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItems(null, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
