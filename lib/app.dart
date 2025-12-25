import 'package:flutter/material.dart';
import 'views/home_page.dart';

// Entry point of the application
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Build the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {'/home': (context) => const HomePage()}, // Route to HomePage
    );
  }
}
