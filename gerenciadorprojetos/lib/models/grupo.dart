class Grupo {
  Grupo(
      {required this.dono,
      required this.nome,
      required this.projetos,
      required this.participantes});
  Grupo.fromJson(Map<dynamic, dynamic> json)
      : nome = json["Nome"],
        projetos = json["Projetos"],
        participantes = json["participantes"],
        dono = json["dono"];
  String nome;
  List<String> projetos;
  List<String> participantes;
  String dono;

  Map<dynamic, dynamic> toJson() {
    return {
      "Nome": nome,
      "Projetos": projetos,
      "participantes": participantes,
      "dono": dono,
    };
  }
}
