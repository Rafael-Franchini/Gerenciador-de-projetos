import 'package:gerenciadorprojetos/models/grupo.dart';

class User {
  User({
    required this.nome,
    required this.usuario,
    required this.grupos,
  });
  User.fromJson(Map<dynamic, dynamic> json)
      : nome = json["Nome"],
        usuario = json["usuario"],
        grupos = json["grupos"];
  String nome;
  String usuario;
  List<Grupo> grupos;
  Map<String, dynamic> toJson() {
    return {
      "Nome": nome,
      "Usuario": usuario,
      "grupos": grupos,
    };
  }
}
