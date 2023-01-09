enum UserType { admin, physician, patient }

class User {
  String id;
  String name;
  UserType type;
  String? email;
  User(this.id, this.name, this.type, this.email);
}
