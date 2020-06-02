class UsersModel {
  int id;
  String name;
  String email;

  UsersModel({this.id, this.name, this.email});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
    );
  }
}
