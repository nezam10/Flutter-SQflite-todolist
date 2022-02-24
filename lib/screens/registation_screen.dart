import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todolist_app/models/model_class.dart';
import 'package:flutter_sqflite_todolist_app/repositories/database_connection.dart';
import 'package:flutter_sqflite_todolist_app/screens/login_screen.dart';
import 'package:flutter_sqflite_todolist_app/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({Key? key}) : super(key: key);

  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void checkValidation() {
    if (_formkey.currentState!.validate()) {
      var name = nameController.text.toString();
      var phone = phoneController.text.toString();
      var email = emailController.text.toString();
      var password = passController.text.toString();
      var id = 0;
      if (id == 0) {
        SQLHelper.insertDataUser(name, phone, email, password).then((value) => {
              if (value != -1)
                {
                  print("User data inserted Successfully"),
                  toastMessage('Login Successful')
                }
              else
                {print("Failed user data insert")}
            });
      } else
        toastMessage('Something Wrong');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  void toastMessage(var toastText) {
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            checkValidation();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Create a new account',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: nameController,
                  label: Text('NAME'),
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  label: Text('PHONE'),
                  hintText: 'Enter your number',
                  prefixIcon: Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  label: Text('EMAIL'),
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.mail),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: passController,
                  label: Text('PASSWORD'),
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.password),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return value.length <= 6
                        ? 'Password must be six characters'
                        : null;
                  },
                ),
                SizedBox(height: 10),
                ModelClass.submitButton(
                    const Text(
                      'CREATE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ), () {
                  checkValidation();
                  // var name = nameController.text.toString();
                  // var phone = phoneController.text.toString();
                  // var email = emailController.text.toString();
                  // var password = passController.text.toString();
                  // var id = 0;
                  // if (id == 0) {
                  //   SQLHelper.insertDataUser(name, phone, email, password)
                  //       .then((value) => {
                  //             if (value != -1)
                  //               {
                  //                 print("User data inserted Successfully"),
                  //               }
                  //             else
                  //               {print("Failed user data insert")}
                  //           });
                  // }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoginScreen(),
                  //     ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
