import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';

class Skin {
  final String id;
  final String name;
  final double price;
  final double float;
  final String imageUrl;
  final int seed;
  final String userId;
  final SkinType skinType;

  Skin({
    required this.id,
    required this.name,
    required this.price,
    required this.float,
    required this.imageUrl,
    required this.seed,
    required this.userId,
    required this.skinType,
  });

  factory Skin.fromJson(Map<String, dynamic> json) {
    return Skin(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      float: json['float'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      seed: json['seed'],
      skinType: SkinType.values[json['skinType']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'float': float,
      'imageUrl': imageUrl,
      'seed': seed,
      'userId': userId,
      'skinType': skinType.toString(),
    };
  }
}
