import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/repositories/database_connection.dart';
import 'package:flutter_sqflite_todolist_app/screens/edit_view_note.dart';
import 'package:flutter_sqflite_todolist_app/screens/home_screen.dart';

class ViewNoteScreen extends StatelessWidget {
  ViewNoteScreen({Key? key, this.id, this.title, this.description})
      : super(key: key);
  List<Map<String, dynamic>> _dataList = [];

  String? title;
  String? description;
  int? id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.25,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$title",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "$description",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditViewNote(
                        title: title,
                        description: description,
                      );
                    },
                  ));
                  //SQLHelper.updateData(id!, title!, description!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
