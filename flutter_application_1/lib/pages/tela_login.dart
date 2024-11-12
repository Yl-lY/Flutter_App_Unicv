import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
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
                        const CampoDeTexto(
                          label: 'Usuário',
                        ),
                        const SizedBox(height: 25),
                        const CampoDeTexto(
                          label: 'Senha',
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button(
                              texto: 'Cadastrar-se',
                              cor: const Color.fromARGB(255, 74, 214, 43),
                              onPress: () {},
                              icone: const Icon(Icons.person_add_alt),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Button(
                              texto: 'Login',
                              cor: const Color.fromARGB(255, 74, 214, 43),
                              onPress: () {},
                              icone: const Icon(Icons.login),
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

class Button extends StatelessWidget {
  final String texto;
  final Color cor;
  final double largura;
  final double altura;
  final VoidCallback onPress;
  final Icon icone;

  const Button(
      {super.key,
      required this.texto,
      this.cor = Colors.blue,
      this.largura = 200,
      this.altura = 50,
      required this.onPress,
      this.icone = const Icon(Icons.all_inclusive_rounded)});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(cor),
        ),
        onPressed: () {},
        label: Text(texto),
        icon: icone);
  }
}

class CampoDeTexto extends StatelessWidget {
  final String label;

  const CampoDeTexto({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}
