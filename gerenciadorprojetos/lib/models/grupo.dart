class Grupo {
  Grupo(
      {required this.dono,
      required this.nome,
      required this.projetos,
      required this.participantes,
      required this.id});

  Grupo.fromJson(Map<dynamic, dynamic> json)
      : nome = json["Nome"],
        projetos = json["Projetos"],
        participantes = json["participantes"],
        dono = json["dono"],
        id = json["_id"];
  String nome;
  List<String> projetos;
  List<String> participantes;
  String dono;
  String id;

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": nome,
      "Projetos": projetos,
      "participantes": participantes,
      "dono": dono,
      "_id": id
    };
  }
}
