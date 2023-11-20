import 'dart:convert';

import 'package:flutter/material.dart';
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
                    'nome': nomeGr,
                    'dono': util[0].email,
                    'usuarios': '',
                  };

                  const String apiUrl =
                      "http://actionsolution.sytes.net:9000/grupos/novo";

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
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Criando um grupo você se torna o dono dele, podendo adicionar e remover pessoas do grupo, além de poder adicionar projetos ao grupo. Todos podem adicionar pessoar mas so o dono pode remover pessoas.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff252525),
                          fontSize: 20),
                    ),
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
