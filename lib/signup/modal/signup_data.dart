import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class signupProvider extends ChangeNotifier {
  user_signup_modal Data =
      user_signup_modal(name1: "", pass1: "", id1: 0, email1: "");

  void setData({required user_signup_modal setdt}) {
    Data = setdt;
    notifyListeners();
  }

  void change_name({
    required String name,
  }) {
    Data.name1 = name;
    notifyListeners();
  }

  void change_email({
    required String email,
  }) {
    Data.email1 = email;
    notifyListeners();
  }

  user_signup_modal getData() {
    return Data;
  }
}

class user_signup_modal {
  String? name1;
  String? email1;
  String? pass1;
  int? id1;

  user_signup_modal({
    this.name1,
    this.pass1,
    this.email1,
    this.id1,
  });

  // get fromFirestore => this.fromFirestore;

  Map<String, dynamic> toMap() {
    return {
      'id': id1,
      'name': name1,
      'pass': pass1,
      'email': email1,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id1 != null) 'id': id1,
      if (name1 != null) 'name': name1,
      if (pass1 != null) 'pass': pass1,
      if (email1 != null) 'email': email1,
    };
  }

  @override
  String toString() {
    return '{id: $id1, name: $name1, pass: $pass1}';
  }

  factory user_signup_modal.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return user_signup_modal(
      name1: data?['name'],
      email1: data?['email'],
      id1: data?['id'],
      pass1: data?['pass'],
    );
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
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, pass TEXT,email TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insert_data(user_signup_modal data, database) async {
    final db = await database;
    await db.insert(
      'dogs',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<user_signup_modal>> getDataFromDatabase(database) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return user_signup_modal(
        id1: maps[i]['id'],
        name1: maps[i]['name'],
        pass1: maps[i]['pass'],
        email1: maps[i]['email'],
      );
    });
  }
}
