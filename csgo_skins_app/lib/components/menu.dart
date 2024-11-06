import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            textColor: Colors.white,
            onTap: () {
              print('Item 2 clicado');
            },
          ),
          ListTile(
            textColor: Colors.white,
            title: const Text('Entrar'),
            onTap: () {
              print('Item 1 clicado');
            },
          ),
          ListTile(
            textColor: Colors.white,
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
