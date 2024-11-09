import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late User user;

  setUp(() {
    user = User(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
      balance: 100.0,
    );
  });

  test('User should create from JSON correctly', () {
    final json = {
      'id': '1',
      'name': 'Test User',
      'email': 'test@example.com',
      'password': 'password123',
      'balance': 100.0,
    };
    final userFromJson = User.fromJson(json);
    expect(userFromJson.id, '1');
    expect(userFromJson.name, 'Test User');
    expect(userFromJson.email, 'test@example.com');
    expect(userFromJson.balance, 100.0);
  });

  test('User should convert to JSON correctly', () {
    final json = user.toJson();
    expect(json['id'], '1');
    expect(json['name'], 'Test User');
    expect(json['email'], 'test@example.com');
    expect(json['balance'], 100.0);
  });
}
