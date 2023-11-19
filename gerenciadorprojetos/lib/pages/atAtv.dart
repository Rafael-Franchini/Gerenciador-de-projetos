// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //faz conexao
import '../rep-serv/authserv.dart';
import '../models/tarefa.dart';

class AtvTela extends StatefulWidget {
  const AtvTela({super.key, required this.parametros});

  final Tarefa parametros;

  @override
  State<AtvTela> createState() => _AtvTelaState();
}

class _AtvTelaState extends State<AtvTela> {
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
    Tarefa t = widget.parametros;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(t.title),
      ),
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(t.descricao),
            ),
            Center(
              child: Text(
                t.responsavel,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffFC5130),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
