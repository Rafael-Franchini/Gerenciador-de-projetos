import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/grupo.dart';
import 'package:gerenciadorprojetos/pages/GrupoOp.dart';
import 'package:gerenciadorprojetos/pages/adicionarProj.dart';

import '../models/projeto.dart';
import '../rep-serv/authserv.dart';

class Projetos extends StatefulWidget {
  final Grupo parametros;

  Projetos({required this.parametros});

  @override
  State<Projetos> createState() => _ProjetosState();
}

class _ProjetosState extends State<Projetos> {
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  List<Projeto> projetos = [];

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
                  "${projetos.length}",
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
                      onPressed: () {},
                      child: Icon(Icons.refresh)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Scaffold(
                    backgroundColor: Color(0xff303036),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Andamento"),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Scaffold(
                    backgroundColor: Color(0xff30BCED),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Concluido"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff30BCED),
                  ),
                  onPressed: () {
                    Map<String, dynamic> parametrost = {
                      'nome': g1.nome,
                      'dono': g1.dono,
                    };
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CriaProj(parametros: parametrost),
                      ),
                    );
                  },
                  child: Text(
                    "Adicionar Projeto",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
