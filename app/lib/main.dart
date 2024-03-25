import 'package:flutter/material.dart';
import 'UI/home.dart';
import 'UI/connection.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 4;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text('Demander'),
    Text('Proposer'),
    Text('Mon compte'),
    Connect(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    //creation d'un provider
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "ALL'O",
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Demander',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Proposer',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Mon compte',
              backgroundColor: Colors.green,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}