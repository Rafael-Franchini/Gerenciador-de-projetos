// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../_comum/meu_snackbar.dart';
import '../models/grupo.dart';
import '../models/projeto.dart';
import '../rep-serv/authserv.dart';
import '../widget/emailIten.dart';
import 'grupos.dart';

class ProjOp extends StatefulWidget {
  const ProjOp(
      {super.key, required this.parametros, required this.parametros2});

  final Projeto parametros;
  final Grupo parametros2;

  @override
  State<ProjOp> createState() => _ProjOpState();
}

class _ProjOpState extends State<ProjOp> {
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
        getUsers();
      });
    });
  }

  bool verificarNome(List<String> grupos, String nome) {
    for (int i = 0; i < grupos.length; i++) {
      if (grupos[i] == nome) {
        return true;
      }
    }
    return false;
  }

//usa a funcao acima e se nao existir ele adiciona
  void adicionarSeNaoExistir(List<String> usuarios, String novoTeste) {
    if (!verificarNome(usuarios, novoTeste)) {
      usuarios.add(novoTeste);
    }
  }

  void getUsers() async {
    Projeto g1 = widget.parametros;
    final Map<String, dynamic> data = {
      'projeto': g1.nome,
    };
    const String apiUrl =
        "http://actionsolution.sytes.net:9000/projetos/participantes";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': util[0].token,
      },
      body: jsonEncode(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções do Projeto'),
        backgroundColor: Color(0xff30BCED),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                getUsers();
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: ListView(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFC5130),
                ),
                onPressed: () async {
                  Grupo g1 = widget.parametros2;
                  Projeto g2 = widget.parametros;
                  if (util[0].email == g1.dono) {
                    final Map<String, dynamic> data = {
                      'grupo': g1.nome,
                      'projeto': g2.nome,
                    };
                    const String apiUrl =
                        "http://actionsolution.sytes.net:9000/grupos/remover/projeto";

                    final response = await http.post(
                      Uri.parse(apiUrl),
                      headers: {
                        'Content-Type': 'application/json',
                        'x-auth-token': util[0].token,
                      },
                      body: jsonEncode(data),
                    );
                    print(response.body);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Grupos(),
                      ),
                    );
                  }
                },
                child: Row(
                  children: const [Text("Deletar Projeto"), Icon(Icons.delete)],
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
                        labelText: 'Email do integrante',
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
                          Projeto g1 = widget.parametros;
                          final Map<String, dynamic> data = {
                            'id': g1.id,
                            'participante': emailG.text,
                          };

                          const String apiUrl =
                              "http://actionsolution.sytes.net:9000/projetos/adicionar/participante";

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
                  height: 400,
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
      ),
    );
  }

  void onDelete(String email) async {
    Projeto g1 = widget.parametros;
    if (g1.dono == util[0].email) {
      final Map<String, dynamic> data = {
        'id': g1.id,
        'usuarios': [email],
      };

      const String apiUrl =
          "http://actionsolution.sytes.net:9000/projetos/remover/participante";

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
    } else {
      mostrarSnackbar(context: context, texto: "Você não é o dono do projeto");
    }
  }
}
