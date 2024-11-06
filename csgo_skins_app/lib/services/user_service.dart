import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:csgo_skins_app/services/abstract_service.dart';

class UserService extends Service<User> {
  final http.Client client;

  String baseUrl = 'http://localhost:3000/users';

  UserService(this.client);

  @override
  Future<List<User>> find() async {
    final response = await client.get(Uri.parse(baseUrl));
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => User.fromJson(data)).toList();
  }

  @override
  Future<User> findOne(String id) async {
    final response = await client.get(Uri.parse(baseUrl));
    return User.fromJson(json.decode(response.body));
  }

  @override
  Future<User> create(Object body) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar usuário');
    }
    return User.fromJson(json.decode(response.body));
  }

  @override
  Future<User> update(String id, Object body) async {
    final response =
        await client.patch(Uri.parse(baseUrl), body: jsonEncode(body));
    return User.fromJson(json.decode(response.body));
  }

  @override
  Future<void> delete(String id) async {
    final response = await client.delete(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
