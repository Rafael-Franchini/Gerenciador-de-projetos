// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/atAtv.dart';

import '../models/grupo.dart';
import '../models/projeto.dart';
import '../models/tarefa.dart';

class TarefaItem extends StatelessWidget {
  const TarefaItem(
      {Key? key,
      required this.nome,
      required this.parametrosg,
      required this.parametrosp})
      : super(key: key);
  final Tarefa nome;
  final Projeto parametrosp;
  final Grupo parametrosg;

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
                  color: Colors.grey[900],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF30BCED),
                          ),
                          onPressed: () {
                            Tarefa parametros = nome;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AtvTela(
                                  parametros: parametros,
                                  parametrosg: parametrosg,
                                  parametrosp: parametrosp,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                      overflow: TextOverflow.ellipsis,
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
