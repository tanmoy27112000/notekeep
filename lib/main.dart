import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/route_manager.dart';
import 'package:notekeep/providers/todo_provider.dart';
import 'package:notekeep/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
      .setEndpoint('http://localhost/v1')
      .setProject('63891086b06d6fbb200f')
      .setSelfSigned(status: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: const GetMaterialApp(
        title: 'Material App',
        home: SplashScreen(),
      ),
    );
  }
}
