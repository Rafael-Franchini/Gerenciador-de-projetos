import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/user.dart';

class CriaGrupo extends StatelessWidget {
  CriaGrupo({super.key});
  final TextEditingController nomeG = TextEditingController();
  final TextEditingController emailG = TextEditingController();
  late List<User> Usuarios;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      appBar: AppBar(
        title: Text(
          "Criar grupo",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: TextField(
                controller: nomeG,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nome do grupo',
                  hintText: "Grupo1",
                  labelStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Color(0xFF30BCED),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email dos integrantes',
                        hintText: "Grupo1",
                        labelStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xFF30BCED),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Lista de integrantes : ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // ListView(),
          ],
        ),
      ),
    );
  }
}
