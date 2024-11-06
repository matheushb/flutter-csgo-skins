class User {
  String id;
  final String name;
  final String email;
  final String password;
  double balance;

  User({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    this.balance = 0.0,
  }) : id = id ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ??
          (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
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
