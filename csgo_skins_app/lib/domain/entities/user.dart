class User {
  final String id;
  final String name;
  final String email;
  final String password;
  double balance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.balance = 0.0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      balance: json['balance']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'balance': balance,
    };
  }
}
