import 'dart:convert';
import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/services/skins_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late SkinService skinService;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    skinService = SkinService(mockHttpClient);
  });

  group('SkinService', () {
    final mockSkin = Skin(
      id: '1',
      name: 'AK-47 | Redline',
      price: 500.0,
      float: 0.1,
      imageUrl: 'http://example.com/image.png',
      seed: 123,
      userId: 'user123',
      skinType: SkinType.rifle,
    );

    final mockSkinJson = jsonEncode(mockSkin.toJson());

    test('find() returns a list of skins', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('[$mockSkinJson]', 200),
      );

      final skins = await skinService.find(category: 'rifle');

      expect(skins, isA<List<Skin>>());
      expect(skins.first.name, equals(mockSkin.name));
    });

    test('findOne() returns a skin when the ID exists', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(mockSkinJson, 200),
      );

      final skin = await skinService.findOne('1');

      expect(skin, isA<Skin>());
      expect(skin.name, equals(mockSkin.name));
    });

    test('findOne() throws exception when the ID does not exist', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => skinService.findOne('1'), throwsException);
    });

    test('create() returns a skin when creation is successful', () async {
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer(
        (_) async => http.Response(mockSkinJson, 201),
      );

      final skin = await skinService.create(mockSkin.toJson());

      expect(skin, isA<Skin>());
      expect(skin.name, equals(mockSkin.name));
    });

    test('update() returns an updated skin when the request is successful',
        () async {
      when(() => mockHttpClient.patch(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response(mockSkinJson, 200),
      );

      final updatedSkin = await skinService.update('1', mockSkin.toJson());

      expect(updatedSkin, isA<Skin>());
      expect(updatedSkin.name, equals(mockSkin.name));
    });

    test('update() throws exception when the update fails', () async {
      when(() => mockHttpClient.patch(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => skinService.update('1', mockSkin.toJson()), throwsException);
    });

    test('delete() completes when the skin is successfully deleted', () async {
      when(() => mockHttpClient.delete(any())).thenAnswer(
        (_) async => http.Response('', 200),
      );

      expect(skinService.delete('1'), completes);
    });

    test('delete() throws exception when the deletion fails', () async {
      when(() => mockHttpClient.delete(any())).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => skinService.delete('1'), throwsException);
    });
  });
}
