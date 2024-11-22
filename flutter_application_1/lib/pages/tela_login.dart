import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool _modoLogin = true;
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  final TextEditingController _controladorUsuario = TextEditingController();
  bool _escondeSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 167, 69),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500.0,
              ),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 30),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/imagens/LOGO_UNICV_COLORIDA.png',
                          width: 300,
                          height: 150,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          decoration: const InputDecoration(
                            label: Text("Email"),
                          ),
                          controller: _controladorEmail,
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          obscureText: _escondeSenha,
                          decoration: InputDecoration(
                            label: const Text("Senha"),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _escondeSenha = !_escondeSenha;
                                });
                              },
                              icon: _escondeSenha
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                          controller: _controladorSenha,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (!_modoLogin)
                          TextField(
                            decoration: const InputDecoration(
                              label: Text("Usuário"),
                            ),
                            controller: _controladorUsuario,
                          ),
                        if (!_modoLogin)
                          const SizedBox(
                            height: 25,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 74, 214, 43),
                                  ),
                                ),
                                onPressed: () {
                                  if (!_modoLogin) {
                                    setState(() {
                                      _modoLogin = true;
                                    });
                                  } else {
                                    setState(() {
                                      _modoLogin = false;
                                    });
                                  }
                                },
                                label: _modoLogin
                                    ? const Text('Cadastrar-se')
                                    : const Text('Voltar'),
                                icon: _modoLogin
                                    ? const Icon(Icons.person_add_alt)
                                    : const Icon(Icons.arrow_back)),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton.icon(
                              label: Text(_modoLogin ? 'Login' : 'Salvar'),
                              style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color.fromARGB(255, 74, 214, 43),
                                  ),
                                ),
                              onPressed: () async {
                                try {
                                  if (_modoLogin) {
                                    _firebaseAuth.signInWithEmailAndPassword(
                                        email: _controladorEmail.text,
                                        password: _controladorSenha.text);
                                  }
                                } catch (error) {
                                  print(error);
                                }

                                try {
                                  if (!_modoLogin) {
                                    final usuario = await _firebaseAuth
                                        .createUserWithEmailAndPassword(
                                            email: _controladorEmail.text,
                                            password: _controladorSenha.text);

                                    FirebaseFirestore.instance.collection('usuarios').doc(usuario.user!.uid).set({
                                      'email': _controladorEmail.text,
                                      'usuario': _controladorUsuario.text,
                                      'isAdmin': false,
                                      'isTeacher': false,
                                      'isStudent': true,
                                      'turma': ''
                                    });
                                  }
                                } catch (error) {
                                  print(error);
                                }
                              },
                              icon: _modoLogin
                                  ? const Icon(Icons.login)
                                  : const Icon(Icons.check_circle_rounded),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
