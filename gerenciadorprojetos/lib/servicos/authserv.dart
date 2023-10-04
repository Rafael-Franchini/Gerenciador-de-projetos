import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class utils {
  utils({required this.tokens, required this.nome, required this.email});
  utils.fromJson(Map<String, dynamic> json)
      : tokens = json["token"],
        nome = json["nome"],
        email = json["email"];
  String tokens;
  String nome;
  String email;
  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "email": email,
      "token": tokens,
    };
  }
}

const key = "logado";

class UtilsRep {
  late SharedPreferences sharedPreferences;

  void saveTodolist(utils) {
    final String jsonString = jsonEncode(utils);
    sharedPreferences.setString(key, jsonString);
  }

  Future<List<utils>> getutils() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(key) ?? '[]';
    final List jsonDecode = json.decode(jsonString) as List;
    return jsonDecode.map((e) => utils.fromJson(e)).toList();
  }
}
