import 'package:flutter_test/flutter_test.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/domain/entities/cart.dart';
import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';

void main() {
  group('Cart', () {
    test('should add a skin to the cart', () {
      final cart = Cart();
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

      cart.add(skin);

      expect(cart.getTotalItems(), 1);
      expect(cart.skins[0], skin);
    });

    test('should remove a skin from the cart', () {
      final cart = Cart();
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

      cart.add(skin);

      expect(cart.getTotalItems(), 1);

      cart.remove(skin);

      expect(cart.getTotalItems(), 0);
    });

    test('should calculate total price of skins in the cart', () {
      final cart = Cart();
      final skin1 = Skin(
        id: '1',
        name: 'AWP | Dragon Lore',
        price: 5000.0,
        float: 0.05,
        imageUrl: 'http://example.com/image.png',
        seed: 123456,
        userId: 'user123',
        skinType: SkinType.rifle,
      );
      final skin2 = Skin(
        id: '2',
        name: 'AK-47 | Redline',
        price: 3000.0,
        float: 0.1,
        imageUrl: 'http://example.com/image2.png',
        seed: 654321,
        userId: 'user456',
        skinType: SkinType.rifle,
      );

      cart.add(skin1);
      cart.add(skin2);

      expect(cart.getTotalPrice(), 8000.0);
    });

    test('should clear the cart', () {
      final cart = Cart();
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

      cart.add(skin);
      cart.clear();

      expect(cart.getTotalItems(), 0);
    });
  });
}
