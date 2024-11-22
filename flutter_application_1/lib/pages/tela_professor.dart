import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/mensagens.dart';

class TelaProfessor extends StatefulWidget {
  const TelaProfessor({super.key, required this.userEmail});
  final String userEmail;

  @override
  State<TelaProfessor> createState() => _TelaProfessorState();
}

class _TelaProfessorState extends State<TelaProfessor> {
  final TextEditingController _controladorInput = TextEditingController();

  Future<List<String>> _pegaTurmaProfessor() async {
    final turmasProfessor = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    return List<String>.from(turmasProfessor.docs[0]['turmas']);
  }

  Future<String> _pegaMateriaProfessor() async {
    final materiaProfessor = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    return materiaProfessor.docs[0]['materias'][0].toString();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _pegaTurmaProfessor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nenhuma turma encontrada!'),
          );
        }

        final turmasProfessor = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.0),
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.exit_to_app_rounded))
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 40, 167, 69),
          body: Center(
            child: Container(
              margin: const EdgeInsets.only(
                  right: 100, left: 100, top: 16, bottom: 16),
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
                children: [
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: DropdownButton<String>(
                      value: selectedValue,
                      isExpanded: true,
                      hint: const Text(
                        "Escolha uma turma",
                        style: TextStyle(color: Colors.grey),
                      ),
                      items: turmasProfessor.map((String turma) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.center,
                          value: turma,
                          child: Text(turma),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                      dropdownColor: Colors.white,
                      alignment: AlignmentDirectional.center,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: Container(
                        height: 2,
                        color: Colors.green.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  selectedValue == null
                      ? const Text(
                          "Selecione uma turma para ver as mensagens",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : Expanded(
                          child: FutureBuilder<String>(
                            future: _pegaMateriaProfessor(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('Erro ao carregar a matéria'),
                                );
                              }

                              final materia = snapshot.data!;
                              final listaChat = FirebaseFirestore.instance
                                  .collection('turmas')
                                  .doc(selectedValue)
                                  .collection('turmas')
                                  .doc(materia)
                                  .collection('mensagens')
                                  .orderBy('criadoEm', descending: false)
                                  .snapshots();

                              return StreamBuilder<QuerySnapshot>(
                                stream: listaChat,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                      child:
                                          Text('Nenhuma mensagem encontrada!'),
                                    );
                                  }

                                  final mensagens = snapshot.data!.docs;

                                  return ListView.builder(
                                    itemCount: mensagens.length,
                                    itemBuilder: (context, index) {
                                      final dadosMensagem = mensagens[index]
                                          .data() as Map<String, dynamic>;

                                      return Mensagens(
                                        conteudoMensagem:
                                            dadosMensagem['conteudo'] ?? '',
                                        emailUsuario:
                                            dadosMensagem['email'] ?? '',
                                        tempoMensagem: dadosMensagem['criadoEm'] ?? '',
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                  selectedValue == null
                      ? const SizedBox(width: 5, height: 5)
                      : SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controladorInput,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final mensagem = await FirebaseFirestore
                                      .instance
                                      .collection('turmas')
                                      .doc(selectedValue)
                                      .collection('turmas')
                                      .doc(await _pegaMateriaProfessor())
                                      .collection('mensagens')
                                      .add({
                                    'conteudo': _controladorInput.text,
                                    'criadoEm': Timestamp.now(),
                                    'email':
                                        FirebaseAuth.instance.currentUser!.email
                                  });

                                  if (mensagem.id.isNotEmpty) {
                                    _controladorInput.clear();
                                  }
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.green[400],
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
