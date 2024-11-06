import 'package:csgo_skins_app/domain/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  @override
  _CartDrawerState createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  late Cart cart;

  @override
  void initState() {
    super.initState();
    cart = Cart();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      child: ListView(
        children: [
          const ListTile(
            title: Text('Carrinho', style: TextStyle(color: Colors.white)),
            tileColor: Colors.purple,
          ),
          for (var skin in cart.skins)
            ListTile(
              title:
                  Text(skin.name, style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                'Preço: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(skin.price)}',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  setState(() {
                    cart.remove(skin);
                  });
                },
              ),
            ),
          const Divider(color: Colors.white),
          ListTile(
            title: const Text('Total', style: TextStyle(color: Colors.white)),
            subtitle: Text(
              NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(cart.getTotalPrice()),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Adicione a lógica de compra aqui, como checkout, etc.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Compra realizada com sucesso!')),
                );
              },
              child: const Text(
                'Comprar',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontSize: 18, // Tamanho do texto
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
