import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: senha);
      await userc.user!.updateDisplayName(nome);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        return "Email ja em uso";
      }
      if (e.code == "invalid-email") {
        return "email Invalido";
      }
      return "Erro desconhecido";
    }
  }

  Future<String?> Login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-email") {
        return "email Invalido";
      }
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return "senha invalida";
      }
      return "Erro desconhecido";
    }
  }

  Future<void> deslogar() async {
    _firebaseAuth.signOut();
  }
}
