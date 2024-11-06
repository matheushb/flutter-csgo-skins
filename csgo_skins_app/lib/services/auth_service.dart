import 'dart:convert';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final http.Client client;

  String baseUrl = 'http://localhost:3000/users';

  AuthService(this.client);

  Future<User> login({required String email, required String pass}) async {
    final response = await client
        .get(Uri.parse("${baseUrl}?email=${email}&password=${pass}"));

    if (response.statusCode != 200 || response.body.isEmpty) {
      throw Exception('Falha ao fazer login');
    }

    final user = User.fromJson(json.decode(response.body)[0]);

    print(user);

    return user;
  }
}
