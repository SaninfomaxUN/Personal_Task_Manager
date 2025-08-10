
class LoginResponseDto {
  final String accessToken;

  LoginResponseDto({required this.accessToken});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    if (json['access_token'] == null) {
      throw const FormatException(
          "El campo 'access_token' es requerido en el JSON.");
    }
    return LoginResponseDto(accessToken: json['access_token'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken};
  }

  LoginResponseDto copyWith({String? accessToken}) {
    return LoginResponseDto(
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  String toString() {
    return 'LoginResponseDto(accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponseDto && other.accessToken == accessToken;
  }

  @override
  int get hashCode => accessToken.hashCode;
}