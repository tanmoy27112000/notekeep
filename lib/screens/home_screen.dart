import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/models/todo_model.dart';
import 'package:notekeep/screens/add_todo_screen.dart';
import 'package:notekeep/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> data = [
    TodoModel(
      title: "title",
      description: "description",
      isDone: true,
      createdAt: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notekeep"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthHelper.instance.logout();
              Get.to(() => const SplashScreen());
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddTodoScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: data.isEmpty
          ? const Center(
              child: Text("No todo added"),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index].title),
                subtitle: Text(data[index].description),
                leading: Checkbox(
                  value: data[index].isDone,
                  onChanged: (value) {
                    setState(() {
                      data[index].isDone = value!;
                    });
                  },
                ),
                trailing: Text(
                  "${data[index].createdAt.day}-${data[index].createdAt.month}-${data[index].createdAt.year}",
                ),
              ),
            ),
    );
  }
}
