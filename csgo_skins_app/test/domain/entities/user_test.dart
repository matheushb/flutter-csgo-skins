import 'package:flutter_test/flutter_test.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';

void main() {
  group('User', () {
    test('should create a User from JSON', () {
      final json = {
        'id': '1',
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'password': 'password123',
        'balance': 100.0,
      };

      final user = User.fromJson(json);

      expect(user.id, '1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john.doe@example.com');
      expect(user.password, 'password123');
      expect(user.balance, 100.0);
    });

    test('should convert User to JSON', () {
      final user = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
        balance: 100.0,
      );

      final json = user.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'John Doe');
      expect(json['email'], 'john.doe@example.com');
      expect(json['password'], 'password123');
      expect(json['balance'], 100.0);
    });

    test('should default balance to 0.0 if not provided', () {
      final json = {
        'id': '1',
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'password': 'password123',
      };

      final user = User.fromJson(json);

      expect(user.balance, 0.0);
    });
  });
}
