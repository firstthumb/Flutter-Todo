import 'package:flutter/material.dart';
import 'package:flutter_todo_simple/app/view/page/home_page.dart';
import 'package:hive/hive.dart';
import 'di/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'ProductSans',
        primaryColor: Color(0xFF433D82),
        accentColor: Color(0xFFFF4954),
      ),
      home: HomePage(),
    );
  }

  @override
  void dispose() {
    // Dispose Hive
    Hive.close();
    super.dispose();
  }
}
