import 'package:gerenciadorprojetos/packges/user.dart';

class Grupo {
  Grupo(this.lider, this.Nome, this.Projetos, this.participantes);
  String Nome;
  int Projetos;
  List<User> participantes;
  String lider;
  void addParticipante(User user) {
    participantes.add(user);
  }

  void RemoveParticipante(User user) {
    participantes.remove(user);
  }
}
