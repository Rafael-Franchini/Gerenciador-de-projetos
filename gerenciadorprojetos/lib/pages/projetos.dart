import 'package:flutter/material.dart';

class Projetos extends StatefulWidget {
  const Projetos({super.key});

  @override
  State<Projetos> createState() => _ProjetosState();
}

class _ProjetosState extends State<Projetos> {
  int nProj = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        title: Text("Grupo 1"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/grupos');
          },
        ),
      ),
      backgroundColor: Color(0xffFFFAFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Projetos:",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "$nProj",
                  style: TextStyle(color: Color(0xff30BCED), fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Scaffold(
                    backgroundColor: Color(0xff303036),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Andamento"),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                  child: Scaffold(
                    backgroundColor: Color(0xff30BCED),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Concluido"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff30BCED),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Adicionar Projeto",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
