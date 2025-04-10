class UserModel {
  String username;
  String password;
  String? profilePic;

  UserModel({
    required this.username,
    required this.password,
    this.profilePic,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'profilePic': profilePic,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json['username'],
    password: json['password'],
    profilePic: json['profilePic'],
    );
}
