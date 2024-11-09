import 'package:csgo_skins_app/domain/entities/enums/skin_type.dart';

class Skin {
  final String id;
  final String name;
  double price;
  final double float;
  final String imageUrl;
  final int seed;
  String userId;
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

  String getWear() {
    if (float < 0.07) {
      return 'Factory New';
    } else if (float < 0.15) {
      return 'Minimal Wear';
    } else if (float < 0.38) {
      return 'Field-Tested';
    } else if (float < 0.45) {
      return 'Well-Worn';
    } else {
      return 'Battle-Scarred';
    }
  }

  factory Skin.fromJson(Map<String, dynamic> json) {
    return Skin(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      float: json['float'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      seed: json['seed'],
      skinType: SkinType.values.firstWhere(
        (e) => e.toString().split('.').last == json['skinType'],
      ),
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
      'skinType': skinType.toString().split('.').last,
    };
  }
}
