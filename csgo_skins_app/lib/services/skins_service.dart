import 'dart:convert';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:http/http.dart' as http;
import 'package:csgo_skins_app/services/abstract_service.dart';

class SkinService extends Service<Skin> {
  final http.Client client;

  String baseUrl = 'http://localhost:3000/skins';

  SkinService(this.client);

  @override
  Future<List<Skin>> find({String category = ''}) async {
    final response = await client.get(
        Uri.parse(baseUrl + (category != '' ? '?skinType=$category' : '')));
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Skin.fromJson(data)).toList();
  }

  @override
  Future<Skin> findOne(String id) async {
    final response = await client.get(Uri.parse(baseUrl));
    return Skin.fromJson(json.decode(response.body));
  }

  @override
  Future<Skin> create(Object body) async {
    final response =
        await client.post(Uri.parse(baseUrl), body: jsonEncode(body));
    return Skin.fromJson(json.decode(response.body));
  }

  @override
  Future<Skin> update(String id, Object body) async {
    final response =
        await client.patch(Uri.parse(baseUrl), body: jsonEncode(body));
    return Skin.fromJson(json.decode(response.body));
  }

  @override
  Future<void> delete(String id) async {
    final response = await client.delete(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete Skin');
    }
  }
}
