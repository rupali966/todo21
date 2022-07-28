import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class usrsignUp {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();

  final String name1;
  final String pass1;
  final int id1;

  Future<Database> dt() async {
    return openDatabase(
      join(await getDatabasesPath(), 'usr_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, pass INTEGER)',
        );
      },
      version: 1,
    );
  }

  usrsignUp({
    required this.name1,
    required this.pass1,
    required this.id1,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id1,
      'name': name1,
      'pass': pass1,
    };
  }
  @override
  String toString() {
    return '{id: $id1, name: $name1, pass: $pass1}';
  }
  // Define a function that inserts dogs into the database
  Future<void> insertDog(usrsignUp dog, database) async {
    final db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  // A method that retrieves all the dogs from the dogs table.
  Future<List<usrsignUp>> dogs( database) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return usrsignUp(
        id1: maps[i]['id'],
        name1: maps[i]['name'],
        pass1: maps[i]['age'],
      );
    });
  }
}
