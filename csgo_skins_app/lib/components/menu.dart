import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

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
