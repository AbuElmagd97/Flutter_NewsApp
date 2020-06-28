import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home_page.dart';

void main() => runApp(NewsApp());


class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

