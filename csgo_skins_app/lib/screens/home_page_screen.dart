import 'package:csgo_skins_app/components/cart.dart';
import 'package:csgo_skins_app/components/filter_options.dart';
import 'package:csgo_skins_app/components/menu.dart';
import 'package:csgo_skins_app/components/skin_list.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';
  User? _user;

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _updateBalance() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  void _logout() {
    setState(() {
      _user = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deslogado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('../web/icons/logo.png', height: 100),
          ],
        ),
        actions: [
          if (widget.user != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Saldo: ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(widget.user?.balance ?? 0.0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Menu(
        user: _user,
        onLogout: _logout,
      ),
      endDrawer: CartDrawer(
        user: widget.user,
        onBalanceUpdated: _updateBalance,
      ),
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: Column(
        children: [
          FilterOptions(onCategorySelected: _onCategorySelected),
          SkinsList(
            selectedCategory: selectedCategory,
            userId: _user?.id,
          ),
        ],
      ),
    );
  }
}
