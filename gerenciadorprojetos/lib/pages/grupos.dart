import 'package:flutter/material.dart';

import '../servicos/authserv.dart';

class Grupos extends StatefulWidget {
  const Grupos({super.key});

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
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
              "Ola ${util[0].nome}",
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
                  "s",
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30BCED),
                ),
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
            SizedBox(
              width: 400,
              height: 450,
              child: ListView(),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 30,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {},
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
