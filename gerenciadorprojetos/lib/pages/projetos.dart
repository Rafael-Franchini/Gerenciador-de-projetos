import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/grupo.dart';
import 'package:gerenciadorprojetos/pages/GrupoOp.dart';
import 'package:gerenciadorprojetos/pages/adicionarProj.dart';
import 'package:gerenciadorprojetos/widget/ProjIten.dart';
import 'package:http/http.dart' as http; //faz conexao
import '../_comum/meu_snackbar.dart';
import '../models/projeto.dart';
import '../rep-serv/authserv.dart';

class Projetos extends StatefulWidget {
  final Grupo parametros;

  const Projetos({super.key, required this.parametros});

  @override
  State<Projetos> createState() => _ProjetosState();
}

class _ProjetosState extends State<Projetos> {
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  List<Projeto> projetoss = [];

  @override
  void initState() {
    super.initState();
    utilsreps.getutils().then((value) {
      setState(() {
        util = value;
        getProjetos();
      });
    });
  }

  //ve se grupo ja nao existe na lista,para nao ocorrer ter duplicidade de grupos
  bool verificarNome(List<Projeto> grupos, String nome) {
    for (int i = 0; i < grupos.length; i++) {
      if (grupos[i].nome == nome) {
        return true;
      }
    }
    return false;
  }

//usa a funcao acima e se nao existir ele adiciona
  void adicionarSeNaoExistir(List<Projeto> grupos, Projeto novoTeste) {
    if (!verificarNome(grupos, novoTeste.nome)) {
      projetoss.add(novoTeste);
    }
  }

  void getProjetos() async {
    Grupo g1 = widget.parametros;
    String texto = "";
    bool erro = false;
    final Map<String, dynamic> data = {
      "grupo": g1.nome,
      'usuario': util[0].email,
    };
    const String apiUrl = "http://actionsolution.sytes.net:9000/projetos/todos";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': util[0].token,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey("projetos") && jsonData["projetos"] is List) {
        final List<dynamic> gruposData = jsonData["projetos"];

        for (final docData in gruposData) {
          // Acessar os campos individuais do objeto "doc"
          final nome = docData['nome'];
          final dono = docData['dono'];
          final descricao = docData['descricao'];
          final id = docData['_id'];
          // Faça o que você precisa com os campos do objeto "doc"
          // ignore: non_constant_identifier_names
          Projeto Teste = Projeto(
            id: id,
            nome: nome,
            dono: dono,
            descricao: descricao,
            tarefas: [],
            dataE: "",
          );
          adicionarSeNaoExistir(projetoss, Teste);
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
    Grupo g1 = widget.parametros;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        actions: [
          IconButton(
              onPressed: () {
                Grupo parametros = g1;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GrupoOP(parametros: parametros),
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
        title: Text(g1.nome),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/grupos');
          },
        ),
      ),
      backgroundColor: Color(0xffFFFAFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Projetos:",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "${projetoss.length}",
                  style: TextStyle(color: Color(0xff30BCED), fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 55,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF30BCED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        getProjetos();
                      },
                      child: Icon(Icons.refresh)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 0.85 / 2 * MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30BCED),
                ),
                onPressed: () {
                  Map<String, dynamic> parametros = {
                    'nome': g1.nome,
                    'dono': g1.dono,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CriaProj(
                        parametros: parametros,
                        parametros2: widget.parametros,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Adicionar Projeto",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 0.85 / 2 * MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  if (projetoss.isNotEmpty)
                    for (Projeto grupo in projetoss)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: ProjList(
                          nome: grupo,
                          nome2: g1,
                        ),
                      ),
                  if (projetoss.isEmpty)
                    Center(
                      child: Text(
                        "Nenhum projeto encontrado",
                        style: TextStyle(
                          color: Color(0xffFC5130),
                          fontSize: 16,
                        ),
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
