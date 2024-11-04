import 'package:csgo_skins_app/domain/entities/skin.dart';

class Cart {
  final List<Skin> skins = [];

  void add(Skin skin) {
    skins.add(skin);
  }

  void remove(Skin skin) {
    skins.remove(skin);
  }

  double getTotalPrice() {
    return skins.fold(0, (total, skin) => total + skin.price);
  }

  int getTotalItems() {
    return skins.length;
  }

  void clear() {
    skins.clear();
  }
}
