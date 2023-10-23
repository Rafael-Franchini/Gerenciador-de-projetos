import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/widget/emailIten.dart';
import 'package:http/http.dart' as http;

import '../_comum/meu_snackbar.dart';
import '../rep-serv/authserv.dart';

class CriaGrupo extends StatefulWidget {
  const CriaGrupo({super.key});

  @override
  State<CriaGrupo> createState() => _CriaGrupoState();
}

class _CriaGrupoState extends State<CriaGrupo> {
  final TextEditingController nomeG = TextEditingController();

  final TextEditingController emailG = TextEditingController();
  String? deletedemail;
  int? deletedemailpos;
  List<String> usuarios = [];
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
      appBar: AppBar(
        title: Text(
          "Criar grupo",
        ),
        actions: [
          IconButton(
              onPressed: () async {
                String nomeGr = nomeG.text;
                if (nomeGr != "") {
                  final Map<String, dynamic> data = {
                    'nome': '$nomeGr',
                    'dono': '${util[0].email}',
                    'usuarios': '$usuarios',
                  };

                  const String apiUrl =
                      "http://actionsolution.serveminecraft.net:9000/grupos/novo";

                  final response = await http.post(
                    Uri.parse(apiUrl),
                    headers: {
                      'Content-Type': 'application/json',
                      'x-auth-token': '${util[0].token}',
                    },
                    body: jsonEncode(data),
                  );

                  if (response.statusCode == 200) {
                    // ignore: use_build_context_synchronously
                    mostrarSnackbar(
                        context: context, texto: "grupo criado com sucesso");
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed("/grupos");
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarSnackbar(
                        context: context, texto: "${response.statusCode}");
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed("/grupos");
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: TextField(
                    controller: nomeG,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nome do grupo',
                      hintText: "Grupo1",
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailG,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email dos integrantes',
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
                              setState(() {
                                usuarios.add(email);
                              });
                            } else {}
                          },
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Lista de integrantes : ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    children: [
                      for (String user in usuarios)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: EmailList(email: user, onDelete: onDelete),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onDelete(String email) {
    deletedemail = email;
    deletedemailpos = usuarios.indexOf(email);
    setState(() {
      usuarios.remove(email);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            "Tarefa $email foi removida com sucesso",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFFFFAFF),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: "Desfazer",
            textColor: Color(0xFF30BCED),
            onPressed: () {
              setState(() {
                usuarios.insert(deletedemailpos!, deletedemail!);
              });
            },
          )),
    );
  }
}
