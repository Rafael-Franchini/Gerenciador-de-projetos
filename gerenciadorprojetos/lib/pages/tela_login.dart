import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/servicos/authserv.dart';

import '../_comum/meu_snackbar.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});
  final TextEditingController emails = TextEditingController();
  final TextEditingController senhas = TextEditingController();
  AutenticacaoServico _autenS = AutenticacaoServico();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logobranca.png',
                    width: 150,
                    height: 150,
                    isAntiAlias: true,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextField(
                    controller: emails,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      hintText: "Exemplo@exemplo.com",
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: senhas,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF30BCED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      String pass = senhas.text;
                      String email = emails.text;
                      if (pass.isNotEmpty && email.isNotEmpty) {
                        await _autenS.Login(email: email, password: pass)
                            .then((String? erro) {
                          //voltou com erro
                          if (erro != null) {
                            MostrarSnackbar(context: context, texto: erro);
                          }
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 124.0,
                        vertical: 15,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFFFFFAFF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text("Não possui ?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 19,
                      ),
                      primary: Color(0xFF30BCED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/registrar');
                    },
                    child: Text("Registrar-se"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
