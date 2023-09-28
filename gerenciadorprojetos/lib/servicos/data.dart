import 'package:cloud_firestore/cloud_firestore.dart';

import 'authserv.dart';

class Data {
  final AutenticacaoServico _autenS = AutenticacaoServico();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addGrupo(String nome, String nomeG, List lista) async {
    await _firestore.collection(nome).doc(nomeG).collection("projetos");
    for (int i = 0; i < lista.length; i++) {
      _firestore
          .collection(nome)
          .doc(nomeG)
          .collection("Usuarios")
          .doc(lista[i]);
    }
  }

  Future<void> addUser() async {
    var email = _autenS.getEmail();
    await _firestore.collection("usuarios").doc(email).set(
      {},
    );
  }
}
