import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class signupProvider extends ChangeNotifier {
  usrsignUp Data = usrsignUp(name1: "", pass1: "", id1: 0,email1: "");

  void setData({required usrsignUp setdt}) {
    Data = setdt;
    notifyListeners();
  }

  usrsignUp getData() {
    return Data;
  }
}

class usrsignUp extends ChangeNotifier {
  final String name1;
  final String pass1;
  final String email1;
  final int id1;

  usrsignUp({
    required this.email1,
    required this.name1,
    required this.pass1,
    required this.id1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id1,
      'email':email1,
      'name': name1,
      'pass': pass1,
    };
  }

  @override
  String toString() {
    return '{id: $id1, name: $name1, pass: $pass1}';
  }
}

class dataOperation extends ChangeNotifier {
  Future<Database> data_initialization() async {
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;
    return openDatabase(
      join(await tempPath, 'usr_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT,email TEXT, pass INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insert_data(usrsignUp data, database) async {
    final db = await database;
    await db.insert(
      'dogs',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<usrsignUp>> getDataFromDatabase(database) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return usrsignUp(
        id1: maps[i]['id'],
        name1: maps[i]['name'],
        pass1: maps[i]['pass'],
        email1: maps[i]['email'],
      );
    });
  }

// make a method that get a perticular module data using the name and password
// (serching and retrival is used),
// make a method to chage globle user profile data
}
