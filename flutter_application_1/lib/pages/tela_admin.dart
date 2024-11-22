import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaAdmin extends StatefulWidget {
  const TelaAdmin({super.key});

  @override
  State<TelaAdmin> createState() => _TelaAdminState();
}

class _TelaAdminState extends State<TelaAdmin> {
  String? selectedValue;
  Future<List<String>> _pegaTurmas() async {
    final turmas = await FirebaseFirestore.instance.collection('turmas').get();

    return turmas.docs.map((doc) => doc.id).toList();
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 40, 167, 69),
      body: Center(
        child: Container(
          margin:
              const EdgeInsets.only(right: 100, left: 100, top: 16, bottom: 16),
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('turmas')
                      .snapshots(),
                  builder: (context, snapshot) {
                    final turmas = snapshot.data!.docs;

                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: turmas.length,
                        itemBuilder: (context, index) {
                          final dadosTurma = turmas[index].id;

                          return Container(
                            color: index % 2 == 0
                                ? Colors.grey[300]
                                : Colors.white,
                            child: turmaTile(dadosTurma),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.blue,
                onPressed: () {
                  _modalCriarOpcoes(context, 'turma', _pegaTurmas());
                },
                shape: const CircleBorder(eccentricity: 0.1),
                child: const Icon(Icons.class_rounded),
              ),
            ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.red,
                onPressed: () {
                  _modalCriarOpcoes(context, 'professor', _pegaTurmas());
                },
                shape: const CircleBorder(eccentricity: 0.1),
                child: const Icon(Icons.assignment_ind_rounded),
              ),
            ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.green,
                onPressed: () {
                  _modalCriarOpcoes(context, 'aluno', _pegaTurmas());
                },
                shape: const CircleBorder(eccentricity: 0.1),
                child: const Icon(Icons.people_alt_rounded),
              ),
            ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.orange,
                onPressed: () {
                  _modalCriarOpcoes(context, 'materia', _pegaTurmas());
                },
                shape: const CircleBorder(eccentricity: 0.1),
                child: const Icon(Icons.library_books_rounded),
              ),
            ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            backgroundColor: Colors.yellow.withOpacity(0.9),
            shape: const CircleBorder(eccentricity: 0.1),
            child: Icon(
              _isExpanded ? Icons.close_rounded : Icons.add_rounded,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.white, offset: Offset(2, 2), blurRadius: 5)
              ],
            ),
          )
        ],
      ),
    );
  }

  void _modalCriarOpcoes(BuildContext context, String opcao, dynamic func) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (opcao == 'aluno') {
          return AlertDialog(
            shadowColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.5),
            surfaceTintColor: Colors.white.withOpacity(0.0),
            title: Text('A área do $opcao está em produção!'),
            icon: Icon(Icons.warning_amber_rounded,
                color: Colors.yellow[800]?.withOpacity(0.8), size: 50),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Em produção...')],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blue[600]?.withOpacity(0.8),
                    ),
                    Text('Confirmar')
                  ],
                ),
              ),
            ],
          );

          // final TextEditingController nomeController = TextEditingController();
          // final TextEditingController emailController = TextEditingController();
          // final TextEditingController senhaController = TextEditingController();

          // return _ModalAluno(
          //     func: func,
          //     selectedValue: selectedValue,
          //     nomeController: nomeController,
          //     emailController: emailController,
          //     senhaController: senhaController);
        } else if (opcao == 'professor') {
          return AlertDialog(
            shadowColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.5),
            surfaceTintColor: Colors.white.withOpacity(0.0),
            title: Text('A área do $opcao está em produção!'),
            icon: Icon(Icons.warning_amber_rounded,
                color: Colors.yellow[800]?.withOpacity(0.8), size: 50),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Em produção...')],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blue[600]?.withOpacity(0.8),
                    ),
                    Text('Confirmar')
                  ],
                ),
              ),
            ],
          );
        } else if (opcao == 'turma') {
          final TextEditingController turmaController = TextEditingController();
          return AlertDialog(
            shadowColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.5),
            surfaceTintColor: Colors.white.withOpacity(0.0),
            title: Text('Deseja criar outro(a) $opcao?'),
            icon: Icon(Icons.cancel_presentation_rounded,
                color: Colors.red[800]?.withOpacity(0.8), size: 50),
            content: TextField(
              controller: turmaController,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('turmas')
                        .doc(turmaController.text)
                        .set({});
                    Navigator.of(context).pop();
                  },
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green[600]?.withOpacity(0.8),
                      ),
                      Text('Confirmar')
                    ],
                  )),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cancel_rounded,
                      color: Colors.red[600]?.withOpacity(0.8),
                    ),
                    Text('Cancelar')
                  ],
                ),
              ),
            ],
          );
        } else if (opcao == 'materia') {
          final TextEditingController materiaController =
              TextEditingController();

          return _ModalMateria(
            func: func,
            selectedValue: selectedValue,
            materiaController: materiaController,
          );
        }

        return AlertDialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white.withOpacity(0.5),
          surfaceTintColor: Colors.white.withOpacity(0.0),
          title: Text('Oops, algo está errado!'),
          icon: Icon(Icons.cancel_presentation_rounded,
              color: Colors.red[800]?.withOpacity(0.8), size: 50),
          content:
              Text('Algo de errado aconteceu, por favor contate o suporte!'),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green[600]?.withOpacity(0.8),
                  ),
                  Text('Confirmar')
                ],
              ),
            ),
          ],
        );
      },
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
              _editarTurma(context, title);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deletarTurma(context, title);
            },
          ),
        ],
      ),
    );
  }
}

class _ModalAluno extends StatefulWidget {
  final Future<List<String>> func;
  final String? selectedValue;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;

  const _ModalAluno({
    required this.func,
    required this.selectedValue,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
  });

  @override
  _ModalAlunoState createState() => _ModalAlunoState();
}

class _ModalAlunoState extends State<_ModalAluno> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.func,
      builder: (context, snapshotTurmas) {
        if (snapshotTurmas.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final listaTurmas = snapshotTurmas.data ?? [];

        return AlertDialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white.withOpacity(0.5),
          surfaceTintColor: Colors.white.withOpacity(0.0),
          title: Text('Deseja criar outro(a) aluno?'),
          icon: Icon(Icons.cancel_presentation_rounded,
              color: Colors.red[800]?.withOpacity(0.8), size: 50),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                hint: const Text(
                  "Escolha uma turma",
                  style: TextStyle(color: Colors.grey),
                ),
                items: listaTurmas.map((String item) {
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
              TextField(
                controller: widget.nomeController,
                decoration: const InputDecoration(label: Text('Nome')),
              ),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextField(
                controller: widget.senhaController,
                decoration: const InputDecoration(label: Text('Senha')),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                setState(
                  () async {
                    if (selectedValue != null &&
                        widget.nomeController.text.isNotEmpty &&
                        widget.emailController.text.isNotEmpty &&
                        widget.senhaController.text.isNotEmpty) {
                      UserCredential usuario = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.emailController.text,
                              password: widget.senhaController.text);

                      FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(usuario.user!.uid)
                          .set(
                        {
                          'email': widget.emailController.text,
                          'usuario': widget.nomeController.text,
                          'isAdmin': false,
                          'isTeacher': false,
                          'isStudent': true,
                          'turma': selectedValue
                        },
                      );
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green[600]?.withOpacity(0.8),
                  ),
                  Text('Confirmar')
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cancel_rounded,
                    color: Colors.red[600]?.withOpacity(0.8),
                  ),
                  Text('Cancelar')
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ModalMateria extends StatefulWidget {
  final Future<List<String>> func;
  final String? selectedValue;
  final TextEditingController materiaController;

  const _ModalMateria({
    required this.func,
    required this.selectedValue,
    required this.materiaController,
  });

  @override
  _ModalMateriaState createState() => _ModalMateriaState();
}

class _ModalMateriaState extends State<_ModalMateria> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: widget.func,
      builder: (context, snapshotTurmas) {
        if (snapshotTurmas.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final listaTurmas = snapshotTurmas.data ?? [];

        return AlertDialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white.withOpacity(0.5),
          surfaceTintColor: Colors.white.withOpacity(0.0),
          title: Text('Deseja criar outro(a) materia?'),
          icon: Icon(Icons.cancel_presentation_rounded,
              color: Colors.red[800]?.withOpacity(0.8), size: 50),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                hint: const Text(
                  "Escolha uma turma",
                  style: TextStyle(color: Colors.grey),
                ),
                items: listaTurmas.map((String item) {
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
              TextField(
                controller: widget.materiaController,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                if (selectedValue != null &&
                    widget.materiaController.text.isNotEmpty) {
                  FirebaseFirestore.instance
                      .collection('turmas')
                      .doc(selectedValue)
                      .collection('turmas')
                      .doc(widget.materiaController.text)
                      .set({});

                  Navigator.of(context).pop();
                }
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green[600]?.withOpacity(0.8),
                  ),
                  Text('Confirmar')
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cancel_rounded,
                    color: Colors.red[600]?.withOpacity(0.8),
                  ),
                  Text('Cancelar')
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

void _editarTurma(BuildContext context, String turmaAtual) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
            shadowColor: Colors.white,
            backgroundColor: Colors.white.withOpacity(0.5),
            surfaceTintColor: Colors.white.withOpacity(0.0),
            title: Text('A área de edição da turma está em produção!'),
            icon: Icon(Icons.warning_amber_rounded,
                color: Colors.yellow[800]?.withOpacity(0.8), size: 50),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text('Em produção...')],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blue[600]?.withOpacity(0.8),
                    ),
                    Text('Confirmar')
                  ],
                ),
              ),
            ],
          );
    },
  );
}

void _deletarTurma(BuildContext context, String turmaAtual) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.5),
        surfaceTintColor: Colors.white.withOpacity(0.0),
        title: Text('Deseja excluir esta turma?'),
        icon: Icon(Icons.cancel_presentation_rounded,
            color: Colors.red[800]?.withOpacity(0.8), size: 50),
        content: Text(
          turmaAtual,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('turmas')
                    .doc(turmaAtual)
                    .delete();
                Navigator.of(context).pop();
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green[600]?.withOpacity(0.8),
                  ),
                  Text('Confirmar')
                ],
              )),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cancel_rounded,
                  color: Colors.red[600]?.withOpacity(0.8),
                ),
                Text('Cancelar')
              ],
            ),
          ),
        ],
      );
    },
  );
}
