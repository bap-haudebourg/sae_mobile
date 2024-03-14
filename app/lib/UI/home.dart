import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final Color color = Colors.white;
  final double myTextSize = 40.0;
  //const Home(this.color, this.myTextSize);
  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "ALL'O",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,),
    ),
    centerTitle: true,
    backgroundColor: Colors.lightBlue,
    ),
    );
  }
}