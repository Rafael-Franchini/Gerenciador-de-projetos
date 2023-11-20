// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/grupo.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';
import 'package:http/http.dart' as http; //faz conexao
import '../_comum/meu_snackbar.dart';
import '../models/projeto.dart';
import '../rep-serv/authserv.dart';
import '../models/tarefa.dart';

class AtvTela extends StatefulWidget {
  const AtvTela(
      {super.key,
      required this.parametros,
      required this.parametrosp,
      required this.parametrosg});

  final Projeto parametrosp;
  final Tarefa parametros;
  final Grupo parametrosg;

  @override
  State<AtvTela> createState() => _AtvTelaState();
}

class _AtvTelaState extends State<AtvTela> {
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
    Tarefa t = widget.parametros;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjetoT(
                    parametros1: widget.parametrosp,
                    parametros2: widget.parametrosg),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(t.title),
      ),
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFC5130),
              ),
              onPressed: () async {
                Grupo g1 = widget.parametrosg;
                if (util[0].email == g1.dono) {
                  final Map<String, dynamic> data = {
                    'tarefa': widget.parametros.title,
                    'projeto': widget.parametrosp.nome,
                  };
                  const String apiUrl =
                      "http://actionsolution.sytes.net:9000/tarefas/remover/tarefa";

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
                            parametros1: widget.parametrosp,
                            parametros2: widget.parametrosg),
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarSnackbar(
                        context: context,
                        texto: "Você não é o dono do grupo",
                        isErro: true);
                  }
                }
              },
              child: Row(
                children: const [Text("Deletar Tarefa"), Icon(Icons.delete)],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Descrição da tarefa:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Text(
                t.descricao,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff252525),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Email do responsavel pela tarefa:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                t.responsavel,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffFC5130),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
