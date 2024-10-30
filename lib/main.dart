import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/screens/Login.dart';

import 'Daterange.dart';
import 'screens/Navigationbar.dart';
import 'screens/Dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationBAR',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}






