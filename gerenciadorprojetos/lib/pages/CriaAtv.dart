// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';
import 'package:http/http.dart' as http; //faz conexao
import '../models/grupo.dart';
import '../models/projeto.dart';
import '../rep-serv/apilink.dart';
import '../rep-serv/authserv.dart';

class CriaAtv extends StatefulWidget {
  const CriaAtv(
      {super.key, required this.parametros1, required this.parametros2});

  final Projeto parametros1;
  final Grupo parametros2;

  @override
  State<CriaAtv> createState() => _CriaAtvState();
}

class _CriaAtvState extends State<CriaAtv> {
  TextEditingController nomeAtv = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController responsavel = TextEditingController();
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  Api api = Api();
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
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        leading: IconButton(
          onPressed: () {
            Grupo parametros = widget.parametros2;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjetoT(
                    parametros1: widget.parametros1, parametros2: parametros),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (nomeAtv.text.isNotEmpty &&
                    descricao.text.isNotEmpty &&
                    responsavel.text.isNotEmpty) {
                  final Map<String, dynamic> data = {
                    "titulo": nomeAtv.text,
                    "descricao": descricao.text,
                    "atribuicao": responsavel.text,
                    "projeto": widget.parametros1.nome,
                  };
                  String apiUrl =api.criarTarefa();

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
                        builder: (context) => ProjetoT(
                          parametros1: widget.parametros1,
                          parametros2: widget.parametros2,
                        ),
                      ),
                    );
                  }
                }
              },
              icon: Icon(Icons.check))
        ],
        centerTitle: true,
        title: Text(widget.parametros1.nome),
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Titulo da Atividade",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: nomeAtv,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Descrição da Atividade",
                    ),
                    controller: descricao,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email do Encarregado da tarefa",
                    ),
                    controller: responsavel,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Estamos trabalhando para que possa colocar uma data limite de atividade e para que possa colocar como concluida ou não",
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
      ]),
    );
  }
}
