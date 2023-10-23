import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';
import 'package:http/http.dart' as http;

import '../_comum/meu_snackbar.dart';
import '../rep-serv/authserv.dart';
import '../widget/emailIten.dart';

class GrupoOP extends StatefulWidget {
  final Map<String, dynamic> parametros;
  const GrupoOP({required this.parametros});

  @override
  State<GrupoOP> createState() => _GrupoOPState();
}

class _GrupoOPState extends State<GrupoOP> {
  List<String> usuarios = [];
  final TextEditingController emailG = TextEditingController();
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
    String nome = widget.parametros['nome'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        title: Text(nome),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Map<String, dynamic> parametrost = {
              'nome': nome,
            };
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Projetos(parametros: parametrost),
              ),
            );
          },
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFC5130),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Deletar Grupo"),
                    Icon(Icons.delete),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email do integrantes',
                        hintText: "Exemplo@exemplo.com",
                        labelStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xFF30BCED),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        String email = emailG.text;

                        if (email.isNotEmpty) {
                          String nomeGr = nome;
                          final Map<String, dynamic> data = {
                            'nomeGrupo': nomeGr,
                            'usuarios': email,
                          };

                          const String apiUrl =
                              "http://actionsolution.serveminecraft.net:9000/grupos/adicionar/usuario";

                          final response = await http.post(
                            Uri.parse(apiUrl),
                            headers: {
                              'Content-Type': 'application/json',
                              'x-auth-token': util[0].token,
                            },
                            body: jsonEncode(data),
                          );
                          if (response.statusCode == 200) {
                            // ignore: use_build_context_synchronously
                            mostrarSnackbar(
                                context: context, texto: "Usuario adicionado");
                          } else {
                            // ignore: use_build_context_synchronously
                            mostrarSnackbar(
                                context: context,
                                texto: "${response.statusCode}");
                          }
                          setState(() {
                            usuarios.add(email);
                          });
                        } else {}
                      },
                      child: Icon(
                        Icons.person_add,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Lista de participante:"),
              SizedBox(
                  height: 500,
                  width: 300,
                  child: ListView(
                    children: [
                      for (String user in usuarios)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: EmailList(email: user, onDelete: onDelete),
                        ),
                    ],
                  )),
            ],
          ),
        ),
      ]),
    );
  }

  void onDelete(String email) async {
    String nome = widget.parametros['nome'];
    final Map<String, dynamic> data = {
      'nomeGrupo': nome,
      'usuarios': email,
    };

    const String apiUrl =
        "http://actionsolution.serveminecraft.net:9000/grupos/remover/usuario";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': util[0].token,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      mostrarSnackbar(context: context, texto: "Usuario deletado");
    } else {
      // ignore: use_build_context_synchronously
      mostrarSnackbar(context: context, texto: "${response.statusCode}");
    }

    setState(() {
      usuarios.remove(email);
    });
  }
}
