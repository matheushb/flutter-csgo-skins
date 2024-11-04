import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:flutter/material.dart';

class SkinCard extends StatelessWidget {
  final Skin skin;

  const SkinCard({required this.skin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.network(
            skin.imageUrl,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skin.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Adiciona o overflow
                  maxLines: 1, // Limita a uma linha
                ),
                const SizedBox(height: 4),
                Text(
                  'Float: ${skin.float.toStringAsFixed(2)}',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'R\$ ${skin.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
