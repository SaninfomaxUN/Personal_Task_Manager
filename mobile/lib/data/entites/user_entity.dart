class UserEntity {
  final String username;
  final String password;

  UserEntity({required this.username, required this.password});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    if (json['username'] == null || json['password'] == null) {
      throw const FormatException(
        "Los campos username y password son requeridos en el JSON.",
      );
    }
    return UserEntity(username: json['username'] as String, password: '');
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }

  UserEntity copyWith({String? username, String? password}) {
    return UserEntity(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserDto(username: $username, password: $password)'; // Solo para depuración local
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
