import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

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
