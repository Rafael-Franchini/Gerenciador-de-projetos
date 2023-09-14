class Tarefa {
  Tarefa(
      {required this.Title,
      required this.Descricao,
      required this.Prioridade,
      required this.Responsavel});
  Tarefa.fromJson(Map<String, dynamic> json)
      : Title = json["Title"],
        Descricao = json["Descricao"],
        Prioridade = json["Prioridade"],
        Responsavel = json["Responsavel"];
  String Title;
  String Descricao;
  String Responsavel;
  String Prioridade;
  Map<String, dynamic> toJson() {
    return {
      "Title": Title,
      "Descricao": Descricao,
      "Responsavel": Responsavel,
      "Prioridade": Prioridade,
    };
  }
}
