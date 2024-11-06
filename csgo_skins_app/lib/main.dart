import 'package:csgo_skins_app/components/cart.dart';
import 'package:csgo_skins_app/components/filter_options.dart';
import 'package:csgo_skins_app/components/menu.dart';
import 'package:csgo_skins_app/components/skin_list.dart';
import 'package:csgo_skins_app/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
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
      drawer: Menu(),
      endDrawer: CartDrawer(),
      backgroundColor: const Color.fromARGB(255, 20, 20, 20),
      body: Column(
        children: [
          FilterOptions(onCategorySelected: _onCategorySelected),
          SkinsList(selectedCategory: selectedCategory),
        ],
      ),
    );
  }
}
