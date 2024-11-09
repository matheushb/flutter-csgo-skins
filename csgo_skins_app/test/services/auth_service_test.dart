import 'dart:convert';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:csgo_skins_app/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late AuthService authService;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    authService = AuthService(mockHttpClient);
  });

  group('AuthService', () {
    const email = 'test@example.com';
    const password = 'password123';

    final mockUser = User(
      id: '1',
      name: 'Test User',
      email: email,
      password: password,
      balance: 100.0,
    );

    final mockUserJson = jsonEncode([mockUser.toJson()]);

    test('login() returns a User when credentials are correct', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(mockUserJson, 200),
      );

      final user = await authService.login(email: email, pass: password);

      expect(user, isA<User>());
      expect(user.email, equals(email));
      expect(user.name, equals(mockUser.name));
    });

    test('login() throws an exception when response status is not 200',
        () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(() => authService.login(email: email, pass: password),
          throwsA(isA<Exception>()));
    });

    test('login() throws an exception when response body is empty', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('', 200),
      );

      expect(() => authService.login(email: email, pass: password),
          throwsA(isA<Exception>()));
    });
  });
}
