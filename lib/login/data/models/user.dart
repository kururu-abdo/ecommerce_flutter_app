import 'dart:developer';

class User {
  final String id;
  final String email;
   final String name;

   final String? token;
  User({required this.id, 
 required this.name,
  required this.token,
  required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return User(
      token: json['token'],
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }
}
