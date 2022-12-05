import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/providers/todo_provider.dart';
import 'package:notekeep/screens/add_todo_screen.dart';
import 'package:notekeep/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoProvider todoProvider;
  @override
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    super.initState();
    getData();
  }

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
        body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return todoProvider.todos.isEmpty
                ? const Center(
                    child: Text("No todo added"),
                  )
                : ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(todoProvider.todos[index].title),
                      subtitle: Text(todoProvider.todos[index].description),
                      leading: Checkbox(
                        value: todoProvider.todos[index].isDone,
                        onChanged: (value) {
                          setState(() {
                            todoProvider.todos[index].isDone = value!;
                          });
                        },
                      ),
                      trailing: Text(
                        "${todoProvider.todos[index].createdAt.day}-${todoProvider.todos[index].createdAt.month}-${todoProvider.todos[index].createdAt.year}",
                      ),
                    ),
                  );
          },
        ));
  }

  void getData() async {
    await todoProvider.getTodo();
  }
}
