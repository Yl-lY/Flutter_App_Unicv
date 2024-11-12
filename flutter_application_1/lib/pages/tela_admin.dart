import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/tela_login.dart';
// import 'package:flutter_application_1/pages/aa.dart';

class TelaAdmin extends StatefulWidget {
  const TelaAdmin({super.key});

  @override
  State<TelaAdmin> createState() => _TelaAdminState();
}

class _TelaAdminState extends State<TelaAdmin> {
  final List<String> turmas = [
    "Direito - 5",
    "Design Gráfico - 5",
    "Engenharia - 3",
    "Administração - 4",
    "Psicologia - 2",
    "Direito - 5",
    "Design Gráfico - 5",
    "Engenharia - 3",
    "Administração - 4",
    "Psicologia - 2",
    "Direito - 5",
    "Design Gráfico - 5",
    "Engenharia - 3",
    "Administração - 4",
    "Psicologia - 2"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 167, 69),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(right: 100, left: 100, top: 16, bottom: 16),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Turmas",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: turmas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                      child: turmaTile(turmas[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow[700],
        shape: const CircleBorder(eccentricity: 0.1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget turmaTile(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              // Ação de editar
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Ação de deletar
            },
          ),
        ],
      ),
    );
  }
}
