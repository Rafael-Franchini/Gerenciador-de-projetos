import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';

import '../models/grupo.dart';
import '../models/projeto.dart';

class CriaAtv extends StatefulWidget {
  const CriaAtv({required this.parametros1, required this.parametros2});

  final Projeto parametros1;
  final Grupo parametros2;

  @override
  State<CriaAtv> createState() => _CriaAtvState();
}

class _CriaAtvState extends State<CriaAtv> {
  TextEditingController nomeAtv = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController responsavel = TextEditingController();
  bool prioridade = false;

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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
        centerTitle: true,
        title: Text(widget.parametros1.nome),
      ),
      body: Column(
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
                    labelText: "Responsável",
                  ),
                  controller: responsavel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
