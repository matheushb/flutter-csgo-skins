import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/services/abstract_service.dart';

class SkinsService extends Service {
  @override
  String entity() {
    return 'skins';
  }

  @override
  Future<List<Skin>> find() async {
    final response = await super.find();
    return response.map((data) => Skin.fromJson(data)).toList();
  }
}
