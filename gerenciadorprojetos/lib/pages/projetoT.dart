// ignore: duplicate_ignore
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/grupos.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';

import '../models/grupo.dart';
import '../models/projeto.dart';
import '../rep-serv/authserv.dart';
import 'CriaAtv.dart';
import 'package:http/http.dart' as http; //faz conexao

class ProjetoT extends StatefulWidget {
  const ProjetoT(
      {super.key, required this.parametros1, required this.parametros2});

  final Projeto parametros1;
  final Grupo parametros2;

  @override
  State<ProjetoT> createState() => _ProjetoTState();
}

class _ProjetoTState extends State<ProjetoT> {
  String selectedValue = 'Opção 1';
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  List<Projeto> projetoss = [];

  void getTarefas() async {}

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
                builder: (context) => Projetos(parametros: parametros),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                getTarefas();
              },
              icon: Icon(Icons.refresh)),
        ],
        centerTitle: true,
        title: Text(widget.parametros1.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFC5130),
              ),
              onPressed: () async {
                Grupo g1 = widget.parametros2;
                Projeto g2 = widget.parametros1;
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
            Text(
              "Descrição: ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(widget.parametros1.descricao),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriaAtv(
                          parametros1: widget.parametros1,
                          parametros2: widget.parametros2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30BCED),
                ),
                child: Text(
                  "Atribuir Tarefa",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
