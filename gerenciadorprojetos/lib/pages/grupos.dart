import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/widget/gruposItens.dart';
import 'package:http/http.dart' as http;

import '../models/grupo.dart';
import '../servicos/authserv.dart';

class Grupos extends StatefulWidget {
  const Grupos({super.key});

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  List<Grupo> grupos = [];

  @override
  void initState() {
    super.initState();
    utilsreps.getutils().then((value) {
      setState(() {
        util = value;
      });
    });
  }

  void getGrupos() async {
    final Map<String, dynamic> data = {
      'email': '${util[0].email}',
    };
    const String apiUrl =
        "http://actionsolution.serveminecraft.net:9000/grupos/todos";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': '${util[0].token}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> jsonData = json.decode(response.body);
      int i = 0;
      if (jsonData.containsKey('grupos')) {
        final List<dynamic> gruposData = jsonData['grupos'];
        final List docList =
            gruposData.map((grupoData) => grupoData['doc']).toList();

        // Agora você tem uma lista de objetos "doc" como Map<String, dynamic>
        for (final docData in docList) {
          // Acessar os campos individuais do objeto "doc"
          final id = docData['_id'];
          final rev = docData['_rev'];
          final nome = docData['nome'];
          final dono = docData['dono'];

          // Faça o que você precisa com os campos do objeto "doc"
          Grupo Teste = Grupo(
              dono: dono, nome: nome, projetos: [" "], participantes: [" "]);
          if (grupos.length < 0) {
            for (i; i <= grupos.length; i++) {
              if (grupos[i].nome == Teste.nome) {
                break;
              }
              if (i == grupos.length && grupos[i].nome != Teste.nome) {
                grupos.add(Teste);
              }
            }
          } else {
            grupos.add(Teste);
          }
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Icon(
                Icons.person,
                size: 120,
              ),
            ),
            Text(
              "Ola ${util[0].nome}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Grupos : ",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                Text(
                  "${grupos.length}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF30BCED),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        getGrupos();
                      },
                      child: Icon(Icons.refresh)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 72.0,
                vertical: 12,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30BCED),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/criagrupo');
                },
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Text(
                        "Criar Grupo",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Lista de grupos : ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 300,
              height: 450,
              child: ListView(
                children: [
                  for (Grupo grupo in grupos)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: GrupoList(
                        nome: grupo,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 30,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      utilsreps.save(' ');
                      Navigator.of(context).pushNamed("/login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFC5130),
                    ),
                    child: Text("Sair")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
