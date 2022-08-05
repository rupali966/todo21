import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class usrsignUp extends ChangeNotifier {
  final String name1;
  final String pass1;
  final int id1;

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
}

class dataOperation extends ChangeNotifier {

  Future<Database> data_initialization() async {
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;
    return openDatabase(
      join(await tempPath, 'usr_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, pass INTEGER)',
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
}
