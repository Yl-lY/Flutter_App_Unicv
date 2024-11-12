import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/aa.dart';
import 'package:flutter_application_1/pages/tela_admin.dart';
// import 'package:flutter_application_1/pages/tela_login.dart';

void main() {
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Teste',
      debugShowCheckedModeBanner: false,
      home: TelaAdmin()
    );
  }
}
