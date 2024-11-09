import 'package:csgo_skins_app/domain/entities/cart.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:csgo_skins_app/services/skins_service.dart';
import 'package:csgo_skins_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CartDrawer extends StatefulWidget {
  final User? user;
  final VoidCallback? onBalanceUpdated;

  const CartDrawer({super.key, this.user, this.onBalanceUpdated});

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
              onPressed: () async {
                final user = widget.user;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuário não está logado!')),
                  );
                  return;
                }

                final totalPrice = cart.getTotalPrice();

                if (user.balance < totalPrice) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saldo insuficiente!')),
                  );
                  return;
                }

                final skinService = SkinService(http.Client());

                for (var skin in cart.skins) {
                  final updatedSkin = skin.toJson();
                  updatedSkin['userId'] = user.id;

                  try {
                    await skinService.update(skin.id, updatedSkin);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Erro ao atualizar skin ${skin.name}: $e')),
                    );
                    return;
                  }
                }

                user.balance -= totalPrice;

                try {
                  await UserService(http.Client())
                      .update(user.id, user.toJson());
                  setState(() {
                    cart.clear();
                  });

                  widget.onBalanceUpdated?.call();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Compra realizada com sucesso!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Erro ao atualizar saldo do usuário: $e')),
                  );
                }
              },
              child: const Text(
                'Comprar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
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
