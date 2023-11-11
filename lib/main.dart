import 'package:flutter/material.dart';
import 'package:todoapp/add_note.dart';
import 'package:todoapp/edit.dart';
import 'package:todoapp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      home: Home(),
      title: 'sqflit cours ',
      routes: {
        '/home': (BuildContext context) => const Home(),
        'add_note': (BuildContext context) => const AddNote(),
        'edit_note': (BuildContext context) => const editNote(),
      },
    );
  }
}
