import 'package:flutter/material.dart';

import '../models/grupo.dart';

class GrupoList extends StatelessWidget {
  const GrupoList({Key? key, required this.nome}) : super(key: key);
  final Grupo nome;
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
                          onPressed: () {},
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
