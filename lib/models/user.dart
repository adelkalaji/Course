class User {
  int? userId;
  String? userName;
  String? userPass;
  int? userRole;

  User({this.userId, this.userName, this.userPass, this.userRole});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      userName: json['user_name'],
      userPass: json['user_pass'],
      userRole: json['user_role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'user_pass': userPass,
      'user_role': userRole,
    };
  }
}
