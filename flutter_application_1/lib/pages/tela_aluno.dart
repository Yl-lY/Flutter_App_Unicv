import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/mensagens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaAluno extends StatefulWidget {
  const TelaAluno({super.key, required this.userEmail});
  final String userEmail;

  @override
  State<TelaAluno> createState() => _TelaAlunoState();
}

class _TelaAlunoState extends State<TelaAluno> {
  Future<String> _pegaTurmaAluno() async {
    final turmaAluno = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    return turmaAluno.docs[0]['turma'].toString();
  }

  Future<List<String>> _pegaListaDeChats(String turma) async {
    final listaDeChats = await FirebaseFirestore.instance
        .collection('turmas')
        .doc(turma)
        .collection('turmas')
        .get();

    return listaDeChats.docs.map((doc) => doc.id).toList();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _pegaTurmaAluno(),
      builder: (context, snapshotTurma) {
        if (snapshotTurma.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshotTurma.hasError || !snapshotTurma.hasData) {
          return const Center(
            child: Text('Erro ao carregar a turma do aluno!'),
          );
        }

        final turmaAluno = snapshotTurma.data!;

        return FutureBuilder<List<String>>(
          future: _pegaListaDeChats(turmaAluno),
          builder: (context, snapshotChats) {
            if (snapshotChats.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshotChats.hasError || !snapshotChats.hasData) {
              return const Center(
                child: Text('Erro ao carregar os chats!'),
              );
            }

            final listaChats = snapshotChats.data!;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0.0),
                actions: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(Icons.exit_to_app_rounded),
                  )
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
                        child: DropdownButton(
                          value: selectedValue,
                          isExpanded: true,
                          hint: const Text(
                            "Escolha uma matéria",
                            style: TextStyle(color: Colors.grey),
                          ),
                          items: listaChats.map((String item) {
                            return DropdownMenuItem<String>(
                              alignment: AlignmentDirectional.center,
                              value: item,
                              child: Text(item),
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            )
                          : Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('turmas')
                                    .doc(turmaAluno)
                                    .collection('turmas')
                                    .doc(selectedValue)
                                    .collection('mensagens')
                                    .orderBy('criadoEm', descending: false)
                                    .snapshots(),
                                builder: (context, snapshotMensagens) {
                                  if (snapshotMensagens.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (!snapshotMensagens.hasData ||
                                      snapshotMensagens.data!.docs.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'Nenhuma mensagem encontrada!',
                                        style:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    );
                                  }

                                  final mensagens =
                                      snapshotMensagens.data!.docs;

                                  return ListView.builder(
                                    itemCount: mensagens.length,
                                    itemBuilder: (context, index) {
                                      final dadosMensagem =
                                          mensagens[index].data()
                                              as Map<String, dynamic>;

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
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
