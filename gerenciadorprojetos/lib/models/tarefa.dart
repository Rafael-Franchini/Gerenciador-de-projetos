class Tarefa {
  Tarefa(
      {required this.title,
      required this.descricao,
      required this.prioridade,
      required this.responsavel});
  Tarefa.fromJson(Map<String, dynamic> json)
      : title = json["Title"],
        descricao = json["Descricao"],
        prioridade = json["Prioridade"],
        responsavel = json["Responsavel"];
  String title;
  String descricao;
  String responsavel;
  String prioridade;
  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "Descricao": descricao,
      "Responsavel": responsavel,
      "Prioridade": prioridade,
    };
  }
}
