import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/grupo.dart';
import '../models/projeto.dart';
import '../rep-serv/authserv.dart';
import 'grupos.dart';

class ProjOp extends StatefulWidget {
  const ProjOp({required this.parametros, required this.parametros2});

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
    String texto = "";
    bool erro = false;
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
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções do Projeto'),
        backgroundColor: Color(0xff30BCED),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
