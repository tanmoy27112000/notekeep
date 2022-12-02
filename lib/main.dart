import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:notekeep/screens/login_screen.dart';

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
    return const MaterialApp(
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}
