import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SkinCard extends StatelessWidget {
  final Skin skin;
  final VoidCallback onAddToCart;

  const SkinCard({super.key, required this.skin, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSkinDialog(context),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                        NumberFormat.simpleCurrency(locale: 'pt_BR')
                            .format(skin.price),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.greenAccent,
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
      ),
    );
  }

  void _showSkinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  skin.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Image.network(
                  'https://cors-anywhere.herokuapp.com/${skin.imageUrl}',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 75);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  NumberFormat.simpleCurrency(locale: 'pt_BR')
                      .format(skin.price),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onAddToCart();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Adicionar ao Carrinho"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
