import 'package:csgo_skins_app/components/skin_card.dart';
import 'package:csgo_skins_app/domain/entities/skin.dart';
import 'package:csgo_skins_app/services/skins_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: Builder(
            builder: (BuildContext context) => IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    print('Menu hambúrguer clicado');
                  },
                )),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                print('Carrinho clicado');
              },
            ),
          ),
        ],
      ),
      drawer: Menu(),
      endDrawer: Cart(),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          FilterOptions(),
          SkinsList(),
        ],
      ),
    );
  }
}

class SkinsList extends StatelessWidget {
  final SkinsService skinsService = SkinsService();

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

class FilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 146, 98, 236),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategoryOption(
                label: 'Todas',
              ),
              CategoryOption(
                label: 'Facas',
              ),
              CategoryOption(
                label: 'Luvas',
              ),
              CategoryOption(
                label: 'Rifles',
              ),
              CategoryOption(
                label: 'Pistolas',
              ),
              CategoryOption(
                label: 'Smg',
              ),
              CategoryOption(
                label: 'Pesadas',
              ),
              CategoryOption(
                label: 'Outras',
              ),
            ],
          ),
        ));
  }
}

class CategoryOption extends StatelessWidget {
  final String label;

  const CategoryOption({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          print('$label selecionado');
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              print('Item 1 clicado');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              print('Item 2 clicado');
            },
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              print('Item 2 clicado');
            },
          ),
          ListTile(
            title: const Text('Entrar'),
            onTap: () {
              print('Item 1 clicado');
            },
          ),
          ListTile(
            title: const Text('Registrar-se'),
            onTap: () {
              print('Item 2 clicado');
            },
          ),
        ],
      ),
    );
  }
}
