class Admin {
  String? username;
  String? password;

  Admin({
    this.username,
    this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
