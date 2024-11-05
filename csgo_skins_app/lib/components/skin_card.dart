import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:flutter/material.dart';

class SkinCard extends StatelessWidget {
  final Skin skin;

  const SkinCard({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[600],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: Color.fromARGB(255, 146, 98, 236)),
      ),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.network(
                  'https://cors-anywhere.herokuapp.com/${skin.imageUrl}',
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 75);
                  },
                ),
              ),
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color.fromARGB(255, 167, 130, 236),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skin.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      skin.getWear(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'R\$ ${skin.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
