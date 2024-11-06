import 'package:csgo_skins_app/components/category_option.dart';
import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final Function(String) onCategorySelected;

  const FilterOptions({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 146, 98, 236),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryOption(label: 'Todas', onSelect: onCategorySelected),
            CategoryOption(label: 'Facas', onSelect: onCategorySelected),
            CategoryOption(label: 'Luvas', onSelect: onCategorySelected),
            CategoryOption(label: 'Rifles', onSelect: onCategorySelected),
            CategoryOption(label: 'Pistolas', onSelect: onCategorySelected),
            CategoryOption(label: 'Smg', onSelect: onCategorySelected),
            CategoryOption(label: 'Pesadas', onSelect: onCategorySelected),
            CategoryOption(label: 'Outras', onSelect: onCategorySelected),
          ],
        ),
      ),
    );
  }
}
