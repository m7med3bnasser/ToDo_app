import 'package:flutter/material.dart';
import 'package:todo/UI/home.dart';
import 'package:todo/UI/styels/my_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData.lightTheme,
      routes: {
        HomeScreen.routename1:(context)=> HomeScreen(),
      },
      initialRoute: HomeScreen.routename1,
    );
  }
}

