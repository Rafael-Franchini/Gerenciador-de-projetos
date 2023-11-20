// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';
import 'package:http/http.dart' as http; //faz conexao
import '../_comum/meu_snackbar.dart';
import '../models/grupo.dart';
import '../rep-serv/authserv.dart';

// ignore: must_be_immutable
class CriaProj extends StatefulWidget {
  CriaProj({super.key, required this.parametros, required this.parametros2});

  Grupo parametros2;
  final Map<String, dynamic> parametros;

  @override
  State<CriaProj> createState() => _CriaProjState();
}

class _CriaProjState extends State<CriaProj> {
  final UtilsRep utilsreps = UtilsRep();
  TextEditingController nomeProj = TextEditingController();
  TextEditingController descricao = TextEditingController();
  String? deletedemail;
  int? deletedemailpos;
  List<String> usuarios = [];
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
    String nomeGrupo = widget.parametros['nome'];
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        actions: [
          IconButton(
            onPressed: () async {
              String nomeGr = nomeProj.text;
              if (nomeProj.text.isNotEmpty) {
                if (descricao.text.isNotEmpty) {
                  final Map<String, dynamic> data = {
                    'nome': nomeGr,
                    'descricao': descricao.text,
                    'dono': util[0].email,
                  };

                  const String apiUrl =
                      "http://actionsolution.sytes.net:9000/projetos/novo";

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
                        context: context,
                        texto: "Projeto criado com sucesso",
                        isErro: false);
                    final Map<String, dynamic> data = {
                      'grupo': nomeGrupo,
                      'projeto': nomeGr,
                    };

                    const String apiUrl =
                        "http://actionsolution.sytes.net:9000/grupos/adicionar/projeto";

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Projetos(
                            parametros: widget.parametros2,
                          ),
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      mostrarSnackbar(
                          context: context, texto: "${response.statusCode}");
                    }
                    // ignore: use_build_context_synchronously
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarSnackbar(
                        context: context, texto: "${response.statusCode}");
                  }
                }
              }
            },
            icon: Icon(Icons.check),
          )
        ],
        title: Text(
          "Criar Projeto",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  //controller: nomeProj,
                  decoration: InputDecoration(
                    labelText: "Nome do Projeto",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: nomeProj,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  //controller: nomeProj,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Descrição do Projeto",
                  ),
                  controller: descricao,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Criando um projeto,porem somente o dono do grupo pode remover, Dentro dos projetos ficam as tarefas com nome,descrição e quem esta com a tarefa",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff252525),
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
