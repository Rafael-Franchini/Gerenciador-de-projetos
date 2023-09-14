import 'package:gerenciadorprojetos/models/tarefa.dart';

class Projeto {
  Projeto(
      {required this.Nome,
      required this.Descricao,
      required this.tarefas,
      required this.dataE});

  Projeto.fromJson(Map<dynamic, dynamic> json)
      : Nome = json["Nome"],
        Descricao = json["Descricao"],
        tarefas = json["tarefas"],
        dataE = json["dataE"];
  String Nome;
  String Descricao;
  List<Tarefa> tarefas;
  String dataE;

  void addParticipante(Tarefa tarefa) {
    tarefas.add(tarefa);
  }

  void RemoveTarefa(Tarefa tarefa) {
    tarefas.remove(tarefa);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": Nome,
      "Descricao": Descricao,
      "tarefas": tarefas,
      "dataE": dataE,
    };
  }
}
