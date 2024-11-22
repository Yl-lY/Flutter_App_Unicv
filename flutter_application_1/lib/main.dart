import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tela_aluno.dart';
import 'package:flutter_application_1/pages/tela_admin.dart';
import 'package:flutter_application_1/pages/tela_professor.dart';
import 'package:flutter_application_1/pages/tela_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return FutureBuilder(
                future: getUserData(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (userSnapshot.hasData && userSnapshot.data != null) {
                    final userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;

                    if (userData['isAdmin'] == true) {
                      return const TelaAdmin();
                    } else if (userData['isTeacher'] == true) {
                      return TelaProfessor(userEmail: userData['email']);
                    } else if (userData['isStudent'] == true) {
                      return TelaAluno(userEmail: userData['email']);
                    }
                  }

                  return const Center(
                    child: Text(
                        "Entre em contato com o suporte do App, você não está devidamente cadastrado!"),
                  );
                },
              );
            }

            return const TelaLogin();
          }),
    );
  }
}

Future<DocumentSnapshot?> getUserData() async {
  final String? usuarioEmail = FirebaseAuth.instance.currentUser!.email;

  if (usuarioEmail == null) {
    print("Vish painho, fedeu forte ein!");
    return null;
  }

  final querySnapshot = await FirebaseFirestore.instance
      .collection('usuarios')
      .where('email', isEqualTo: usuarioEmail)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  }

  print("Se chegou até aqui, fedeu de novo painho, vish!!");
  return null;
}
