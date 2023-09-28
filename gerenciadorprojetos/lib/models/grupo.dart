import 'package:gerenciadorprojetos/models/projeto.dart';
import 'package:gerenciadorprojetos/models/user.dart';

class Grupo {
  Grupo(
      {required this.lider,
      required this.nome,
      required this.projetos,
      required this.participantes});
  Grupo.fromJson(Map<dynamic, dynamic> json)
      : nome = json["Nome"],
        projetos = json["Projetos"],
        participantes = json["participantes"],
        lider = json["Lider"];
  String nome;
  List<Projeto> projetos;
  List<User> participantes;
  String lider;
  void addParticipante(User user) {
    participantes.add(user);
  }

  void removeParticipante(User user) {
    participantes.remove(user);
  }

  void addProj(Projeto proj) {
    projetos.add(proj);
  }

  void removeProj(Projeto proj) {
    projetos.remove(proj);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": nome,
      "Projetos": projetos,
      "participantes": participantes,
      "Lider": lider,
    };
  }
}
