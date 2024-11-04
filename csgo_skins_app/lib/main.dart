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
                    // Ação do menu hamburguer
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
                // Ação do carrinho
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
          Container(
              color: Colors.blueAccent[100],
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
              )),
          const Expanded(child: Center(child: Text('Produtos'))),
        ],
      ),
    );
  }
}

class CategoryOption extends StatelessWidget {
  final String label;

  const CategoryOption({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () {
          print('$label selecionado');
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
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
              // Ação do item 1
              print('Item 1 clicado');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Ação do item 2
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
              // Ação do item 2
              print('Item 2 clicado');
            },
          ),
          ListTile(
            title: const Text('Entrar'),
            onTap: () {
              // Ação do item 1
              print('Item 1 clicado');
            },
          ),
          ListTile(
            title: const Text('Registrar-se'),
            onTap: () {
              // Ação do item 2
              print('Item 2 clicado');
            },
          ),
        ],
      ),
    );
  }
}
