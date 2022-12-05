import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:notekeep/main.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static DatabaseHelper get instance => _instance;

  static Databases? databases;

  init() {
    databases = Databases(client);
  }

  createTodo({
    required String title,
    required String description,
  }) async {
    databases ?? init();
    try {
      await databases!.createDocument(
          databaseId: "6389141f041930f1b5ee",
          collectionId: "63891433241c6149e129",
          documentId: ID.unique(),
          data: {
            "title": title,
            "description": description,
            "isDone": false,
            // "createdAt": DateTime.now().toIso8601String(),
          });
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
