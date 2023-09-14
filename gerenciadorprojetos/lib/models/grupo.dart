import 'package:gerenciadorprojetos/models/projeto.dart';
import 'package:gerenciadorprojetos/models/user.dart';

class Grupo {
  Grupo(
      {required this.lider,
      required this.Nome,
      required this.Projetos,
      required this.participantes});
  Grupo.fromJson(Map<dynamic, dynamic> json)
      : Nome = json["Nome"],
        Projetos = json["Projetos"],
        participantes = json["participantes"],
        lider = json["Lider"];
  String Nome;
  List<Projeto> Projetos;
  List<User> participantes;
  String lider;
  void addParticipante(User user) {
    participantes.add(user);
  }

  void RemoveParticipante(User user) {
    participantes.remove(user);
  }

  void addProj(Projeto proj) {
    Projetos.add(proj);
  }

  void removeProj(Projeto proj) {
    Projetos.remove(proj);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": Nome,
      "Projetos": Projetos,
      "participantes": participantes,
      "Lider": lider,
    };
  }
}
