import 'package:flutter/material.dart';
import 'package:jarvis2_flutter/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jarvis',
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 255, 231, 245))),
      home: const HomePage(),
    );
  }
}
