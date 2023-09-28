import 'package:gerenciadorprojetos/models/tarefa.dart';

class Projeto {
  Projeto(
      {required this.nome,
      required this.descricao,
      required this.tarefas,
      required this.dataE});

  Projeto.fromJson(Map<dynamic, dynamic> json)
      : nome = json["Nome"],
        descricao = json["Descricao"],
        tarefas = json["tarefas"],
        dataE = json["dataE"];
  String nome;
  String descricao;
  List<Tarefa> tarefas;
  String dataE;

  void addParticipante(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  void removeTarefa(Tarefa tarefa) {
    tarefas.remove(tarefa);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": nome,
      "Descricao": descricao,
      "tarefas": tarefas,
      "dataE": dataE,
    };
  }
}
