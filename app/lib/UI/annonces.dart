import 'package:flutter/material.dart';
import '../database/sqflite.dart';

class PageAnnonce extends StatefulWidget {
  final Color color = Colors.white;
  final double myTextSize = 40.0;
  @override
  State<PageAnnonce> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageAnnonce> {
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
  future: getAnnonces(),
  builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      return Column(
        children: <Widget>[
          Text(
            'Mes Annonces',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data[index] != null) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListTile(
                      title: Text(snapshot.data[index]['nom'] ?? 'Nom par défaut'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data[index]['nom_categorie'] ?? 'Catégorie par défaut'),
                          Text(snapshot.data[index]['nom_produit'] ?? 'Produit par défaut'),
                        ],
                      ),
                      trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(snapshot.data[index]['dateDebut'] ?? 'Date de début par défaut'),
                            Text(snapshot.data[index]['dateFin'] ?? 'Date de fin par défaut'),
                          ],
                        ),
                    ),
                  );
                } else {
                  return Container(); 
                }
              },
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  },
),
    );
  }
}