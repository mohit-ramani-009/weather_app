class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? website;

  UserModel({this.id, this.name, this.email, this.phone, this.website});

  factory UserModel.fromApi(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      website: json["website"],
    );
  }
}
