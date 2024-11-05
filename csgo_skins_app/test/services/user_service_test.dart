import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:csgo_skins_app/services/user_service.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late UserService userService;

  setUp(() {
    mockClient = MockClient();
    userService = UserService(mockClient);
  });

  group('UserService', () {
    test('find() returns a list of users when the http call is successful',
        () async {
      final responseJson = [
        {
          'id': '1',
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'password': 'password123',
          'balance': 100.0,
        },
      ];

      when(() => mockClient.get(Uri.parse('http://localhost:3000/users')))
          .thenAnswer(
        (_) async => http.Response(jsonEncode(responseJson), 200),
      );

      final users = await userService.find();

      expect(users, isA<List<User>>());
      expect(users.length, 1);
      expect(users[0].id, '1');
      expect(users[0].name, 'John Doe');
    });

    test('findOne() returns a user when the http call is successful', () async {
      final responseJson = {
        'id': '1',
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'password': 'password123',
        'balance': 100.0,
      };

      when(() => mockClient.get(Uri.parse('http://localhost:3000/users')))
          .thenAnswer(
        (_) async => http.Response(jsonEncode(responseJson), 200),
      );

      final user = await userService.findOne('1');

      expect(user, isA<User>());
      expect(user.id, '1');
      expect(user.name, 'John Doe');
    });

    test('create() creates a user when the http call is successful', () async {
      final userToCreate = User(
        id: '2',
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        password: 'password456',
      );

      final responseJson = {
        'id': '2',
        'name': 'Jane Doe',
        'email': 'jane.doe@example.com',
        'password': 'password456',
        'balance': 0.0,
      };

      when(() => mockClient.post(
            Uri.parse('http://localhost:3000/users'),
            body: jsonEncode({
              'id': userToCreate.id,
              'name': userToCreate.name,
              'email': userToCreate.email,
              'password': userToCreate.password,
              'balance': userToCreate.balance,
            }),
          )).thenAnswer(
        (_) async => http.Response(jsonEncode(responseJson), 201),
      );

      final createdUser = await userService.create(userToCreate);

      expect(createdUser, isA<User>());
      expect(createdUser.id, '2');
      expect(createdUser.name, 'Jane Doe');
    });

    test('delete() deletes a user when the http call is successful', () async {
      when(() => mockClient.delete(Uri.parse('http://localhost:3000/users')))
          .thenAnswer(
        (_) async => http.Response('', 200),
      );

      await userService.delete('1');

      verify(() => mockClient.delete(Uri.parse('http://localhost:3000/users')))
          .called(1);
    });
  });
}
