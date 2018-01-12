import 'package:flutter/material.dart';

class SingleMovie extends StatelessWidget {
  SingleMovie({this.title});

  final String title;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new Text('hello there'),
    );
  }
}