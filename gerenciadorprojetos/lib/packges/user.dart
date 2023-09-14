class User {
  User({
    required this.Nome,
    required this.Email,
    required this.Password,
    required,
    required this.Usuario,
  });
  User.fromJson(Map<String,dynamic>json):
    Nome=json["Nome"],
    Email=json["Nome"],
    Password=json["Nome"],
    Usuario=json["Nome"];
  String Nome;
  String Email;
  String Password;
  String Usuario;
  Map<String,dynamic>toJson(){
    return {
      "Nome":Nome,
      "Nome":Email,
      "Nome":Password,
      "Nome":Usuario,
  };

}
