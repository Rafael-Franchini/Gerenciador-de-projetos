import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/widget/emailIten.dart';

import '../servicos/authserv.dart';
import '../servicos/data.dart';

class CriaGrupo extends StatefulWidget {
  const CriaGrupo({super.key});

  @override
  State<CriaGrupo> createState() => _CriaGrupoState();
}

class _CriaGrupoState extends State<CriaGrupo> {
  final TextEditingController nomeG = TextEditingController();

  final TextEditingController emailG = TextEditingController();
  String? deletedemail;
  int? deletedemailpos;
  List<String> usuarios = [];
  Data as = Data();
  final AutenticacaoServico _autenS = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      appBar: AppBar(
        title: Text(
          "Criar grupo",
        ),
      ),
      body: ListView(
        children: [
          Padding(
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
                            hintText: "Exemplo@exemplo.com",
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
                          onPressed: () async {
                            String email = emailG.text;

                            if (email.isNotEmpty) {
                              setState(() {
                                usuarios.add(email);
                              });
                            } else {}
                          },
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Lista de integrantes : ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ListView(
                    children: [
                      for (String user in usuarios)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: EmailList(email: user, onDelete: onDelete),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () {
                      String? nomet = _autenS.getNome();
                      String nomeGr = nomeG.text;
                      if (nomeGr != "") {
                        Navigator.of(context).pushNamed("/grupos");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Criar",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
