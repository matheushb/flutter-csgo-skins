import 'package:csgo_skins_app/components/cart.dart';
import 'package:csgo_skins_app/components/filter_options.dart';
import 'package:csgo_skins_app/components/menu.dart';
import 'package:csgo_skins_app/components/skin_list.dart';
import 'package:csgo_skins_app/domain/entities/enums/map_label_to_enum.dart';
import 'package:flutter/material.dart';

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
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = mapCategoryToQuery(category);
      ;
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
      endDrawer: Cart(),
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
