import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Skin skin;

  setUp(() {
    skin = Skin(
      id: '1',
      name: 'AK-47 | Redline',
      price: 15.0,
      float: 0.05,
      imageUrl: 'url',
      seed: 1,
      userId: 'user1',
      skinType: SkinType.rifle,
    );
  });

  test('Skin should calculate wear correctly for Factory New', () {
    expect(skin.getWear(), 'Factory New');
  });

  test('Skin should create from JSON correctly', () {
    final json = {
      'id': '1',
      'name': 'AK-47 | Redline',
      'price': 15.0,
      'float': 0.05,
      'imageUrl': 'url',
      'seed': 1,
      'userId': 'user1',
      'skinType': 'rifle',
    };
    final skinFromJson = Skin.fromJson(json);
    expect(skinFromJson.id, '1');
    expect(skinFromJson.name, 'AK-47 | Redline');
    expect(skinFromJson.price, 15.0);
    expect(skinFromJson.skinType, SkinType.rifle);
  });

  test('Skin should convert to JSON correctly', () {
    final json = skin.toJson();
    expect(json['id'], '1');
    expect(json['name'], 'AK-47 | Redline');
    expect(json['price'], 15.0);
    expect(json['skinType'], 'rifle');
  });
}
