// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';

import '../models/grupo.dart';
import '../models/projeto.dart';

class ProjList extends StatelessWidget {
  const ProjList({
    Key? key,
    required this.nome,
    required this.nome2,
  }) : super(key: key);
  final Projeto nome;
  final Grupo nome2;

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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF30BCED),
                          ),
                          onPressed: () {
                            Projeto parametros = nome;
                            Grupo parametros2 = nome2;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjetoT(
                                    parametros1: parametros,
                                    parametros2: parametros2),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                nome.nome.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFFFFAFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                nome.descricao,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(0xFFFFFAFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
