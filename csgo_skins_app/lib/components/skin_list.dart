import 'package:csgo_skins_app/components/skin_card.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/services/skins_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SkinsList extends StatelessWidget {
  final SkinService skinsService = SkinService(http.Client());

  SkinsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Skin>>(
        future: skinsService.find(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar skins: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma skin disponível'));
          }

          final skins = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: skins.length,
            itemBuilder: (context, index) {
              return SkinCard(skin: skins[index]);
            },
          );
        },
      ),
    );
  }
}
