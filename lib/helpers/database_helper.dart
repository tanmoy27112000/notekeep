import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/main.dart';
import 'package:notekeep/models/todo_model.dart';

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
      String? userId = await AuthHelper.instance.getUserId();
      await databases!.createDocument(
          databaseId: "6389141f041930f1b5ee",
          collectionId: "63891433241c6149e129",
          documentId: ID.unique(),
          data: {
            "title": title,
            "description": description,
            "isDone": false,
            "createdAt": DateTime.now().toIso8601String(),
            "userId": userId,
          });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  getTodos() async {
    databases ?? init();
    try {
      String userId = await AuthHelper.instance.getUserId() ?? "";
      DocumentList response = await databases!.listDocuments(
        databaseId: "6389141f041930f1b5ee",
        collectionId: "63891433241c6149e129",
        queries: [
          Query.equal("userId", userId),
        ],
      );
      return response.documents
          .map(
            (e) => TodoModel.fromJson(e.data, e.$id),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  void updateTodo(TodoModel todo) async{
    databases ?? init();
    try {
      await databases!.updateDocument(
        databaseId: "6389141f041930f1b5ee",
        collectionId: "63891433241c6149e129",
        documentId: todo.id,
        data: {
          "title": todo.title,
          "description": todo.description,
          "isDone": todo.isDone,
          "createdAt": todo.createdAt.toIso8601String(),
          "userId": todo.userId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void deleteTodo(String id)async {
    databases ?? init();
    try {
      await databases!.deleteDocument(
        databaseId: "6389141f041930f1b5ee",
        collectionId: "63891433241c6149e129",
        documentId: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
