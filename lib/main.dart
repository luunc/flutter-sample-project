import 'package:dxdart/injection.dart';
import 'package:dxdart/screens/another_screen/another_screen.dart';
import 'package:dxdart/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() async {
  await configureInjection();

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        AnotherScreen.routeName: (_) => AnotherScreen(),
      },
    );
  }

  @override
  void dispose() {
    unregisterInjection();
    super.dispose();
  }
}
