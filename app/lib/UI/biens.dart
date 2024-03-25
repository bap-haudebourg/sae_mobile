import 'package:flutter/material.dart';
import '../database/sqflite.dart';

class Biens extends StatefulWidget {
  final Color color = Colors.white;
  final double myTextSize = 40.0;
  @override
  State<Biens> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Biens> {
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
      body: FutureBuilder(
        future: getProduits(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
                return Column(
                children: <Widget>[
                    Text(
                    'Mes Biens',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                            ),
                            child: ListTile(
                                title: Text(snapshot.data[index]['nom'] ?? 'Nom par défaut'),
                                subtitle: Text(snapshot.data[index]['description'] ?? 'Description par défaut'),
                                trailing: Text(snapshot.data[index]['nom_categorie'] ?? 'Catégorie par défaut'
                            ),
                            );
                        },
                    ),
                    ),
                ],
                );
            } else {
                return const CircularProgressIndicator();
            }
        },
      ),
    );
  }
}