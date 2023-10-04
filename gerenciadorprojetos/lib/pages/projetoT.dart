import 'package:flutter/material.dart';

class ProjetoT extends StatefulWidget {
  const ProjetoT({super.key});

  @override
  State<ProjetoT> createState() => _ProjetoTState();
}

class _ProjetoTState extends State<ProjetoT> {
  String selectedValue = 'Opção 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/Projetos');
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        centerTitle: true,
        title: Text("Projeto1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text("Data"),
            Text(
              "Pessoas:",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text("Data"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Data Entrega :  ",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text("data"),
              ],
            ),
            Row(
              children: [
                Text(
                  "Concluido:  ",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 500,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30BCED),
                ),
                child: Text(
                  "Atribuir Tarefa",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
