import 'package:flutter/material.dart';
import 'package:note_book/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey.shade900,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0
          )
      ),
      home: const HomeScreen(),
    );
  }
}