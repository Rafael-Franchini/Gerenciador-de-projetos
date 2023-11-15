import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/ProjOp.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';

import '../models/grupo.dart';
import '../models/projeto.dart';
import 'CriaAtv.dart';

class ProjetoT extends StatefulWidget {
  const ProjetoT({required this.parametros1, required this.parametros2});

  final Projeto parametros1;
  final Grupo parametros2;

  @override
  State<ProjetoT> createState() => _ProjetoTState();
}

class _ProjetoTState extends State<ProjetoT> {
  String selectedValue = 'Opção 1';

  void getTarefas() async {}

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
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjOp(
                      parametros: widget.parametros1,
                      parametros2: widget.parametros2,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
        centerTitle: true,
        title: Text(widget.parametros1.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
