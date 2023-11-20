// ignore: duplicate_ignore
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/tarefa.dart';
import 'package:gerenciadorprojetos/pages/grupos.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';
import 'package:gerenciadorprojetos/widget/TarefaItem.dart';

import '../_comum/meu_snackbar.dart';
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
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  List<Tarefa> tarefas = [];

  @override
  void initState() {
    super.initState();
    utilsreps.getutils().then((value) {
      setState(() {
        util = value;
        getTarefas();
      });
    });
  }

  //ve se grupo ja nao existe na lista,para nao ocorrer ter duplicidade de grupos
  bool verificarNome(List<Tarefa> grupos, String nome) {
    for (int i = 0; i < grupos.length; i++) {
      if (grupos[i].title == nome) {
        return true;
      }
    }
    return false;
  }

//usa a funcao acima e se nao existir ele adiciona
  void adicionarSeNaoExistir(List<Tarefa> grupos, Tarefa novoTeste) {
    if (!verificarNome(grupos, novoTeste.title)) {
      grupos.add(novoTeste);
    }
  }

  //pega grupos da api e converte em map usa a funcao a cima para ver se ja nao existe na lista de grupos
  void getTarefas() async {
    String texto = "";
    bool erro = false;
    final Map<String, dynamic> data = {
      'nome': widget.parametros1.nome,
    };
    const String apiUrl = "http://actionsolution.sytes.net:9000/tarefas/todas";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': util[0].token,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData.containsKey('message')) {
        final List<dynamic> gruposData = jsonData['message'];

        // Agora você tem uma lista de objetos "doc" como Map<String, dynamic>
        for (final docData in gruposData) {
          // Acessar os campos individuais do objeto "doc"
          final nome = docData["doc"]['titulo'];
          final desc = docData["doc"]['descricao'];
          final resp = docData["doc"]['atribuicao'];
          // Faça o que você precisa com os campos do objeto "doc"
          // ignore: non_constant_identifier_names
          Tarefa Teste =
              Tarefa(title: nome, descricao: desc, responsavel: resp);
          adicionarSeNaoExistir(tarefas, Teste);
        }
      }
    }
    if (response.statusCode == 404) {
      erro = true;
      texto = "nao encontado nada";
      // ignore: use_build_context_synchronously
      mostrarSnackbar(context: context, texto: texto, isErro: erro);
    }
    setState(() {});
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
                  if (response.statusCode == 200) {
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Grupos(),
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarSnackbar(
                        context: context,
                        texto: "Você não é o dono do grupo",
                        isErro: true);
                  }
                } else {
                  // ignore: use_build_context_synchronously
                  mostrarSnackbar(
                      context: context,
                      texto: "Você não é o dono do grupo",
                      isErro: true);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 600,
              height: 0.99 / 1.8 * MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  if (tarefas.isNotEmpty)
                    for (Tarefa grupo in tarefas)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: TarefaItem(
                          nome: grupo,
                          parametrosg: widget.parametros2,
                          parametrosp: widget.parametros1,
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
