import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/_comum/meu_snackbar.dart';
import 'package:http/http.dart' as http;

import '../servicos/authserv.dart';

class TelaLogin extends StatefulWidget {
  TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController emails = TextEditingController();

  final TextEditingController senhas = TextEditingController();

  final UtilsRep utilsreps = UtilsRep();

  List<utils> util = [];
  @override
  void initState() {
    super.initState();
    utilsreps.getutils().then((value) {
      setState(() {
        util = value;
      });
    });
  }

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
                        final Map<String, dynamic> data = {
                          'email': '$email',
                          'senha': '$pass',
                        };

                        const String apiUrl =
                            "http://actionsolution.serveminecraft.net:9000/auth/login";

                        final response = await http.post(
                          Uri.parse(apiUrl),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode(data),
                        );

                        if (response.statusCode == 200) {
                          mostrarSnackbar(context: context, texto: "Logado");
                          utils as = utils.fromJson(json.decode(response.body));
                          util.add(as);
                          utilsreps.save(util);
                          Navigator.of(context).pushNamed("/grupos");
                        } else {
                          mostrarSnackbar(
                              context: context,
                              texto: "${response.statusCode}");
                        }
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
                      textStyle: TextStyle(fontSize: 19, color: Colors.red),
                      backgroundColor: Color(0xffFFFAFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/registrar');
                    },
                    child: Text(
                      "Registrar-se",
                      style: TextStyle(color: Color(0xff30BCED)),
                    ),
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
