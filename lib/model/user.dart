class User {
  int idUser;
  String name;
  String username;
  String password;
  String email;
  String level;

  User(this.idUser, this.name, this.email, this.password, this.username,
      this.level);
      
  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json['id']),
        json['username'],
        json['email'],
        json['password'],
        json['nama'],
        json['level'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.idUser.toString(),
        'username': this.name,
        'email': this.email,
        'password': this.password,
        'nama': this.username,
        'level': this.level,
      };
}
