import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SkinType should have correct values', () {
    expect(SkinType.values, [
      SkinType.rifle,
      SkinType.pistol,
      SkinType.smg,
      SkinType.heavy,
      SkinType.knife,
      SkinType.gloves,
      SkinType.agent,
      SkinType.graffiti,
      SkinType.sticker,
      SkinType.musicKit,
      SkinType.box,
      SkinType.key
    ]);
  });

  test('SkinType should match string correctly', () {
    expect(
        SkinType.values
            .firstWhere((e) => e.toString().split('.').last == 'knife'),
        SkinType.knife);
    expect(
        SkinType.values
            .firstWhere((e) => e.toString().split('.').last == 'gloves'),
        SkinType.gloves);
  });
}
