import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/servicos/authserv.dart';

import '../servicos/data.dart';

class Grupos extends StatefulWidget {
  const Grupos({super.key});
  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  final AutenticacaoServico _autenS = AutenticacaoServico();
  Data as = Data();
  int ngrup = 0;
  @override
  Widget build(BuildContext context) {
    as.addUser();
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Icon(
                Icons.person,
                size: 120,
              ),
            ),
            Text(
              "Ola ${_autenS.getNome()}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Grupos : ",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                Text(
                  "$ngrup",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF30BCED),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 72.0,
                vertical: 12,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/criagrupo');
                },
                child: SizedBox(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Text(
                        "Criar Grupo",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Lista de grupos : ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            //ListView(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 30,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      _autenS.deslogar();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFC5130),
                    ),
                    child: Text("Sair")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
