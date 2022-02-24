import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/models/model_class.dart';
import 'package:flutter_sqflite_todolist_app/repositories/database_connection.dart';
import 'package:flutter_sqflite_todolist_app/screens/home_screen.dart';
import 'package:flutter_sqflite_todolist_app/screens/registation_screen.dart';
import 'package:flutter_sqflite_todolist_app/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _dataList = [];

  SharedPreferences? sharedPreferences;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  getAllDataUser() async {
    var List = await SQLHelper.getAllDataUser();
    setState(() {
      _dataList = List;
    });
  }

  void getSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveData() {
    _dataList;
  }

  void checkLogin(var checkEmail, var checkPassword) {
    SQLHelper.checkLogin(checkEmail, checkPassword).then((value) => () {
          if (value != null) {
            saveData();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            toastMessage("invalid email & password");
          }
        });

    // var userEmail = checkEmail;
    // var password = checkPassword;
    // if (_formkey.currentState!.validate()) {
    //   if (checkEmail == userEmail) {
    //     if (checkPassword == password) {
    //       toastMessage('Login Successful');
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => HomeScreen(),
    //           ));
    //       print("success");
    //     } else {
    //       toastMessage('Wrong Password');
    //     }
    //   } else {
    //     toastMessage('Wrong Email Address');
    //   }
    // } else
    //   toastMessage('Login Field');
  }

  void toastMessage(var toastText) {
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.red,
        fontSize: 16.0);
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

  bool _isVisible = false;
  void upDateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 110, color: Colors.black12),
                const SizedBox(height: 15),
                const Text(
                  'Wellcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'sign in to continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  labelText: "EMAIL",
                  prefixIcon: Icon(Icons.mail),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Email Address';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: passController,
                  hintText: "Enter your password",
                  labelText: "PASSWORD",
                  prefixIcon: Icon(Icons.lock),
                  obscureText: _isVisible ? false : true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      upDateStatus();
                    },
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return value.length <= 6
                        ? 'Password must be six characters'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ModelClass.submitButton(
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  () {
                    checkLogin(emailController.text, passController.text);
                    // getAllData();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistationScreen()),
                        );
                      },
                      child: const Text(
                        'create a new account',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
