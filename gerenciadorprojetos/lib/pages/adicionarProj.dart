import 'package:flutter/material.dart';

class CriaProj extends StatefulWidget {
  const CriaProj({super.key});

  @override
  State<CriaProj> createState() => _CriaProjState();
}

class _CriaProjState extends State<CriaProj> {
  final TextEditingController nomeG = TextEditingController();

  final TextEditingController emailG = TextEditingController();
  String? deletedemail;
  int? deletedemailpos;
  List<String> usuarios = [];

  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Projetos');
            },
            child: Icon(Icons.exit_to_app),
          )
        ],
        title: Text(
          "Criar Projeto",
          textAlign: TextAlign.center,
        ),
      ),
      body: const Column(
        children: [],
      ),
    );
  }

  void onDelete(String email) {
    deletedemail = email;
    deletedemailpos = usuarios.indexOf(email);
    setState(() {
      usuarios.remove(email);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            "Tarefa $email foi removida com sucesso",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFFFFAFF),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: "Desfazer",
            textColor: Color(0xFF30BCED),
            onPressed: () {
              setState(() {
                usuarios.insert(deletedemailpos!, deletedemail!);
              });
            },
          )),
    );
  }
}
