class Tarefa {
  Tarefa(
      {required this.title,
      required this.descricao,
      required this.responsavel});

  Tarefa.fromJson(Map<String, dynamic> json)
      : title = json["Title"],
        descricao = json["Descricao"],
        responsavel = json["Responsavel"];
  String title;
  String descricao;
  String responsavel;

  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "Descricao": descricao,
      "Responsavel": responsavel,
    };
  }
}
