import 'package:flutter_test/flutter_test.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';

void main() {
  group('Skin', () {
    test('should create a Skin from JSON', () {
      final json = {
        'id': '1',
        'name': 'AWP | Dragon Lore',
        'price': 5000.0,
        'float': 0.05,
        'imageUrl': 'http://example.com/image.png',
        'seed': 123456,
        'userId': 'user123',
        'skinType': 'rifle',
      };

      final skin = Skin.fromJson(json);

      expect(skin.id, '1');
      expect(skin.name, 'AWP | Dragon Lore');
      expect(skin.price, 5000.0);
      expect(skin.float, 0.05);
      expect(skin.imageUrl, 'http://example.com/image.png');
      expect(skin.seed, 123456);
      expect(skin.userId, 'user123');
      expect(skin.skinType, SkinType.rifle);
    });

    test('should convert Skin to JSON', () {
      final skin = Skin(
        id: '1',
        name: 'AWP | Dragon Lore',
        price: 5000.0,
        float: 0.05,
        imageUrl: 'http://example.com/image.png',
        seed: 123456,
        userId: 'user123',
        skinType: SkinType.rifle,
      );

      final json = skin.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'AWP | Dragon Lore');
      expect(json['price'], 5000.0);
      expect(json['float'], 0.05);
      expect(json['imageUrl'], 'http://example.com/image.png');
      expect(json['seed'], 123456);
      expect(json['userId'], 'user123');
      expect(json['skinType'], 'rifle');
    });

    test('should return correct wear level based on float', () {
      final skin1 = Skin(
          id: '1',
          name: '',
          price: 0,
          float: 0.05,
          imageUrl: '',
          seed: 0,
          userId: '',
          skinType: SkinType.rifle);
      expect(skin1.getWear(), 'Factory New');

      final skin2 = Skin(
          id: '2',
          name: '',
          price: 0,
          float: 0.1,
          imageUrl: '',
          seed: 0,
          userId: '',
          skinType: SkinType.rifle);
      expect(skin2.getWear(), 'Minimal Wear');

      final skin3 = Skin(
          id: '3',
          name: '',
          price: 0,
          float: 0.25,
          imageUrl: '',
          seed: 0,
          userId: '',
          skinType: SkinType.rifle);
      expect(skin3.getWear(), 'Field-Tested');

      final skin4 = Skin(
          id: '4',
          name: '',
          price: 0,
          float: 0.4,
          imageUrl: '',
          seed: 0,
          userId: '',
          skinType: SkinType.rifle);
      expect(skin4.getWear(), 'Well-Worn');

      final skin5 = Skin(
          id: '5',
          name: '',
          price: 0,
          float: 0.5,
          imageUrl: '',
          seed: 0,
          userId: '',
          skinType: SkinType.rifle);
      expect(skin5.getWear(), 'Battle-Scarred');
    });
  });
}
