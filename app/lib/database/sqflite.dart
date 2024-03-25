import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    try {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'allo.db');
      deleteDatabase(path);
      var db = await openDatabase(path, version: 1, onCreate: _onCreate);
      db.rawInsert('INSERT INTO Categorie(nom) VALUES("Véhicules")');
        db.rawInsert('INSERT INTO Categorie(nom) VALUES("Immobilier")');
        db.rawInsert('INSERT INTO Categorie(nom) VALUES("Mode")');
        db.rawInsert('INSERT INTO Categorie(nom) VALUES("Multimédia")');
        db.rawInsert('INSERT INTO Annonce(dateDebut, dateFin, titre) VALUES("2021-10-01", "2021-10-31", "Annonce 1")');
        db.rawInsert('INSERT INTO Annonce(dateDebut, dateFin, titre) VALUES("2021-11-01", "2021-11-30", "Annonce 2")');
        db.rawInsert('INSERT INTO Produit(nom, id_categorie, id_annonce, description) VALUES("Voiture", 1, 1, "Voiture en bon état")');
        db.rawInsert('INSERT INTO Produit(nom, id_categorie, id_annonce, description) VALUES("Maison", 2, 2, "Maison en bon état")');
      return db;
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Annonce (id INTEGER PRIMARY KEY, dateDebut TEXT, dateFin TEXT, titre TEXT, description TEXT)');
    await db.execute('CREATE TABLE Produit (id INTEGER PRIMARY KEY, nom TEXT, description TEXT, id_categorie INTEGER, id_annonce INTEGER, FOREIGN KEY(id_annonce) REFERENCES Annonce(id), FOREIGN KEY(id_categorie) REFERENCES Categorie(id))');
    await db.execute('CREATE TABLE Categorie (id INTEGER PRIMARY KEY, nom TEXT)');
  }

}

Future<List<Map<String, dynamic>>> getAnnonces() async {
  Database db = await DBHelper().db;
  var res = await db.rawQuery('SELECT Annonce.titre AS nom, Categorie.nom AS nom_categorie, Produit.nom AS nom_produit, Annonce.dateDebut, Annonce.dateFin FROM Annonce JOIN Produit ON Annonce.id = Produit.id_annonce JOIN Categorie ON Produit.id_categorie = Categorie.id');
  return res.toList().cast<Map<String, dynamic>>();
}

Future<List<Map<String, dynamic>>> getProduits() async {
  Database db = await DBHelper().db;
  var res = await db.rawQuery('SELECT Produit.nom AS nom, Produit.description as description, Categorie.nom AS nom_categorie FROM Produit JOIN Categorie ON Produit.id_categorie = Categorie.id');
  return res.toList().cast<Map<String, dynamic>>();
}

void insertProduit(String nom, int idCategorie, int idAnnonce) async {
  Database db = await DBHelper().db;
  await db.rawInsert('INSERT INTO Produit(nom, id_categorie, id_annonce) VALUES(?, ?, ?)', [nom, idCategorie, idAnnonce]);
}

void insertCategorie(String nom) async {
  Database db = await DBHelper().db;
  await db.rawInsert('INSERT INTO Categorie(nom) VALUES(?)', [nom]);
}

void insertAnnonce(String dateDebut, String dateFin, String titre, String description) async {
  Database db = await DBHelper().db;
  await db.rawInsert('INSERT INTO Annonce(dateDebut, dateFin, titre, description) VALUES(?, ?, ?, ?)', [dateDebut, dateFin, titre, description]);
}