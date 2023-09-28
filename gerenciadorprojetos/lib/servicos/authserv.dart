import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      if (e.code == "email-already-in-use") {
        return "Email ja em uso";
      }
      if (e.code == "invalid-email") {
        return "email Invalido";
      }
      if (e.code == "weak-password") {
        return "senha muito curta";
      }
      return "Erro desconhecido";
    }
  }

  void alterarSenha(email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "email Invalido";
      }
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return "senha invalida";
      }
      return "Erro desconhecido";
    }
  }

  String? getNome() {
    String? nome = _firebaseAuth.currentUser!.displayName;
    if (nome != null) {
      return nome;
    } else {
      return null;
    }
  }

  String? getEmail() {
    String? nome = _firebaseAuth.currentUser!.email;
    if (nome != null) {
      return nome;
    } else {
      return null;
    }
  }

  Future<void> deslogar() async {
    _firebaseAuth.signOut();
  }
}
