
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'dart:io';
import 'Navigationbar.dart';
import 'SignUp.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _username = '';
  String? _password = '';


  bool checkUserCredentials(String email, String password) {
    final file = File('assets/data/users.json');

    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      final users = json.decode(jsonString).cast<Map<String, dynamic>>();

      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          return true;
        }
      }
    }

    return false;
  }




  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          body: Stack(
            children: <Widget>[
              // Back Ground Image
              Container(
                width: double.infinity,
                height:double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  image: DecorationImage(
                    image: AssetImage('assets/rm222-mind-16.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Container (username, pw , resest pw)
              Center(
                child: Container(
                  height: 300,
                  width: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                    color: Color.fromRGBO(180, 217, 234, 0.1),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  // username
                  child: Form(
                    key: _formKey, //with the form Key current state we can access the value of the form and validate or save it
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.0,),
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              // controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                filled: true, fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                hintText: "Your email",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                              validator: ( value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _username = value;
                              },
                            ),
                          ),
                          SizedBox(height: 16.0),

                          // Password
                          Container(
                            height: 45,
                            width: 300,
                            child: TextFormField(
                              // controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                filled: true, fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                hintText: "Your email",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(Icons.password_outlined),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value;
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),

                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(44, 84, 132, 1))),
                            child: Text('Login'),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NavigationBAR()),
                              );
                            },
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(44, 84, 132, 1))),
                            child: Text('Register'),
                            onPressed: () {
                              // Navigate to the registration screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                          ),
                          SizedBox(height: 16.0,),

                          // rest pw
                          GestureDetector(
                            onTap: () {
                              // Add code to handle the reset password action
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NavigationBAR()),
                              );
                            },
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 70, 128),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}