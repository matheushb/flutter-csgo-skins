import 'package:csgo_skins_app/domain/entities/enums/map_label_to_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mapCategoryToQuery should return correct query for category "Todas"',
      () {
    expect(mapCategoryToQuery('Todas'), '');
  });

  test('mapCategoryToQuery should return correct query for category "Facas"',
      () {
    expect(mapCategoryToQuery('Facas'), 'knife');
  });

  test('mapCategoryToQuery should return correct query for category "Luvas"',
      () {
    expect(mapCategoryToQuery('Luvas'), 'gloves');
  });

  test('mapCategoryToQuery should return empty query for invalid category', () {
    expect(mapCategoryToQuery('InvalidCategory'), '');
  });
}
