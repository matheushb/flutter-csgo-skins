import 'dart:convert';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:csgo_skins_app/services/user_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late UserService userService;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    userService = UserService(mockHttpClient);
  });

  group('UserService', () {
    final mockUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      balance: 100.0,
    );

    final mockUserJson = jsonEncode(mockUser.toJson());

    test('find() returns a list of users', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('[$mockUserJson]', 200),
      );

      final users = await userService.find();

      expect(users, isA<List<User>>());
      expect(users.first.name, equals(mockUser.name));
    });

    test('findOne() returns a user when the ID exists', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(mockUserJson, 200),
      );

      final user = await userService.findOne('1');

      expect(user, isA<User>());
      expect(user.name, equals(mockUser.name));
    });

    test('findOne() throws exception when the ID does not exist', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => userService.findOne('1'), throwsException);
    });

    test('create() returns a user when creation is successful', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response(mockUserJson, 201),
      );

      final user = await userService.create(mockUser.toJson());

      expect(user, isA<User>());
      expect(user.name, equals(mockUser.name));
    });

    test('create() throws exception when creation fails', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('', 400),
      );

      expect(() => userService.create(mockUser.toJson()), throwsException);
    });

    test('update() returns an updated user when the request is successful',
        () async {
      when(() => mockHttpClient.patch(
            any(),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response(mockUserJson, 200),
      );

      final updatedUser = await userService.update('1', mockUser.toJson());

      expect(updatedUser, isA<User>());
      expect(updatedUser.name, equals(mockUser.name));
    });

    test('update() throws exception when the update fails', () async {
      when(() => mockHttpClient.patch(
            any(),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => userService.update('1', mockUser.toJson()), throwsException);
    });

    test('delete() completes when the user is successfully deleted', () async {
      when(() => mockHttpClient.delete(any())).thenAnswer(
        (_) async => http.Response('', 200),
      );

      expect(userService.delete('1'), completes);
    });

    test('delete() throws exception when the deletion fails', () async {
      when(() => mockHttpClient.delete(any())).thenAnswer(
        (_) async => http.Response('', 404),
      );

      expect(() => userService.delete('1'), throwsException);
    });
  });
}
