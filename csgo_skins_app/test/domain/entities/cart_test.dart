import 'package:csgo_skins_app/domain/entities/cart.dart';
import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Cart cart;
  late Skin skin1;
  late Skin skin2;

  setUp(() {
    cart = Cart();
    skin1 = Skin(
      id: '1',
      name: 'AK-47 | Redline',
      price: 15.0,
      float: 0.05,
      imageUrl: 'url',
      seed: 1,
      userId: 'user1',
      skinType: SkinType.rifle,
    );
    skin2 = Skin(
      id: '2',
      name: 'M4A4 | Asiimov',
      price: 20.0,
      float: 0.1,
      imageUrl: 'url',
      seed: 2,
      userId: 'user2',
      skinType: SkinType.rifle,
    );
  });

  test('Cart should add skin correctly', () {
    cart.add(skin1);
    expect(cart.getTotalItems(), 1);
    expect(cart.skins.contains(skin1), true);
  });

  test('Cart should remove skin correctly', () {
    cart.clear();
    cart.add(skin1);
    cart.add(skin2);

    cart.remove(skin1);

    expect(cart.getTotalItems(), 1);
    expect(cart.skins.contains(skin1), false);
    expect(cart.skins.contains(skin2), true);
  });

  test('Cart should calculate total price correctly', () {
    cart.clear();
    cart.add(skin1);
    cart.add(skin2);

    expect(cart.getTotalPrice(), 35.0);
  });

  test('Cart should clear skins correctly', () {
    cart.add(skin1);
    cart.add(skin2);
    cart.clear();
    expect(cart.getTotalItems(), 0);
  });
}
