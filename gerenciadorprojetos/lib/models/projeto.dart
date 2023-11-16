import 'package:gerenciadorprojetos/models/tarefa.dart';

class Projeto {
  Projeto(
      {required this.id,
      required this.nome,
      required this.dono,
      required this.descricao,
      required this.tarefas,
      required this.dataE});

  Projeto.fromJson(Map<dynamic, dynamic> json)
      : id = json["_id"],
        nome = json["Nome"],
        dono = json["dono"],
        descricao = json["Descricao"],
        tarefas = json["tarefas"],
        dataE = json["dataE"];
  String nome;
  String dono;
  String descricao;
  String id;
  List<Tarefa> tarefas;

  String dataE;

  void addParticipante(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  void removeTarefa(Tarefa tarefa) {
    tarefas.remove(tarefa);
  }

  int totalTarefas() {
    return tarefas.length;
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "_id": id,
      "Nome": nome,
      "dono": dono,
      "Descricao": descricao,
      "tarefas": tarefas,
      "dataE": dataE,
    };
  }
}
