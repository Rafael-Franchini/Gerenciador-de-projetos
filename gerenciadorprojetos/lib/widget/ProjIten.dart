import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';

import '../models/projeto.dart';

class GrupoList extends StatelessWidget {
  const GrupoList({Key? key, required this.nome}) : super(key: key);
  final Projeto nome;

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
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Projeto parametros = nome;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProjetoT(parametros: parametros),
                              ),
                            );
                          },
                          child: Text(
                            nome.nome.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFAFF),
                              fontWeight: FontWeight.bold,
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
