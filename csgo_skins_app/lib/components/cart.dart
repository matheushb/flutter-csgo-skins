import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        children: [
          ListTile(
            title: const Text('Item 1'),
            textColor: Colors.white,
            onTap: () {
              print('Item 1 clicado');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            textColor: Colors.white,
            onTap: () {
              print('Item 2 clicado');
            },
          ),
        ],
      ),
    );
  }
}
