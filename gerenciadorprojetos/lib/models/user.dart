import 'package:gerenciadorprojetos/models/grupo.dart';

class User {
  User({
    required this.Nome,
    required this.Email,
    required this.Password,
    required this.Usuario,
    required this.grupos,
  });
  User.fromJson(Map<dynamic, dynamic> json)
      : Nome = json["Nome"],
        Email = json["Email"],
        Password = json["senha"],
        Usuario = json["usuario"],
        grupos = json["grupos"];
  String Nome;
  String Email;
  String Password;
  String Usuario;
  List<Grupo> grupos;
  Map<String, dynamic> toJson() {
    return {
      "Nome": Nome,
      "Email": Email,
      "Password": Password,
      "Usuario": Usuario,
      "grupos": grupos,
    };
  }
}
