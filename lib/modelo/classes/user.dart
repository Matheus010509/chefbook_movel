import 'dart:convert';

class User {
  final String name;
  final String email;
  final String password;
  final String saltKey;
  final String fbID;
  final String url;
  final String profileData;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.saltKey,
    this.fbID = '',
    this.url = '',
    this.profileData = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'saltkey': saltKey,
      'fbID': fbID,
      'url': url,
      'profileData': profileData,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      saltKey: map['saltkey'] ?? '',
      fbID: map['fbID'] ?? '',
      url: map['url'] ?? '',
      profileData: map['profileData'] ?? '',
    );
  }

  static String encode(List<User> users) => json.encode(
    users.map<Map<String, dynamic>>((u) => u.toMap()).toList(),
  );

  static List<User> decode(String usersJson) =>
      (json.decode(usersJson) as List<dynamic>)
          .map<User>((item) => User.fromMap(item))
          .toList();
}