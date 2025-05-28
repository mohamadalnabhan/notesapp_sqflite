import 'package:flutter/material.dart';
import 'package:notes_app/addnote.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/sqldb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      routes:{"addnotes":(context)=> Addnote()} ,
    );
  }
}
