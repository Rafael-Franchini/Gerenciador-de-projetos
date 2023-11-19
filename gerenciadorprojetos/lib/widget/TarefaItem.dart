// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/atAtv.dart';

import '../models/tarefa.dart';

class GrupoList extends StatelessWidget {
  const GrupoList({Key? key, required this.nome}) : super(key: key);
  final Tarefa nome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Tarefa parametros = nome;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AtvTela(parametros: parametros),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                nome.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFFFFAFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(nome.descricao,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFFFFAFF),
                                    fontWeight: FontWeight.normal,
                                  )),
                              Text(nome.responsavel,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFFFFAFF),
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
