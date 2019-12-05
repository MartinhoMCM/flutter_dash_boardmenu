import 'package:flutter/material.dart';
import 'package:menu_and_dashboard/menu_dashboard_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu DashBoard',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),

      home: MenuDashBoardPage(),



    );
  }
}

