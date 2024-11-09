import 'dart:async';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/services/skins_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserSkinsScreen extends StatefulWidget {
  final String userId;

  const UserSkinsScreen({super.key, required this.userId});

  @override
  _UserSkinsScreenState createState() => _UserSkinsScreenState();
}

class _UserSkinsScreenState extends State<UserSkinsScreen> {
  late Future<List<Skin>> _userSkinsFuture;
  double _totalValue = 0.0;

  @override
  void initState() {
    super.initState();
    _userSkinsFuture = _fetchUserSkins();
  }

  Future<List<Skin>> _fetchUserSkins() async {
    final skinService = SkinService(http.Client());
    final skins = await skinService.find(userId: widget.userId);
    _totalValue = skins.fold(0, (sum, skin) => sum + skin.price);
    return skins;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Skins',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: FutureBuilder<List<Skin>>(
        future: _userSkinsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhuma skin encontrada.',
                    style: TextStyle(color: Colors.white)));
          }

          final userSkins = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Valor Total: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(_totalValue)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: userSkins.length,
                  itemBuilder: (context, index) {
                    final skin = userSkins[index];
                    return Card(
                      color: const Color.fromARGB(255, 30, 30, 30),
                      elevation: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              "https://cors-anywhere.herokuapp.com/${skin.imageUrl}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  skin.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Preço: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(skin.price)}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
