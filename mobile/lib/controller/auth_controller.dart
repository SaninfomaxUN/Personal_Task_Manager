import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/data/dtos/login_response_dto.dart';
import '../data/entites/user_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiBaseUrl = dotenv.env['API_URL'] ?? '';

Future<LoginResponseDto> loginApi(UserEntity payload) async {
  final url = Uri.parse('$apiBaseUrl/auth/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(payload.toJson()),
  );

  if (response.statusCode == 200) {
    return LoginResponseDto.fromJson(jsonDecode(response.body));
  } else {
    return LoginResponseDto(accessToken: '');
  }
}

