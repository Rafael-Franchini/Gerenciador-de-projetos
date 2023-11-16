import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class utils {
  utils({required this.token, required this.nome, required this.email});

  utils.fromJson(Map<String, dynamic> json)
      : nome = json["nome"],
        email = json["email"],
        token = json["token"];
  String token;
  String nome;
  String email;

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "email": email,
      "token": token,
    };
  }
}

const key = "util";

class UtilsRep {
  late SharedPreferences sharedPreferences;

  // ignore: avoid_types_as_parameter_names
  void save(utils) {
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
