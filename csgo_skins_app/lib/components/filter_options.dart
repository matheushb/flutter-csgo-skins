import 'package:csgo_skins_app/components/category_option.dart';
import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 146, 98, 236),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategoryOption(
                label: 'Todas',
              ),
              CategoryOption(
                label: 'Facas',
              ),
              CategoryOption(
                label: 'Luvas',
              ),
              CategoryOption(
                label: 'Rifles',
              ),
              CategoryOption(
                label: 'Pistolas',
              ),
              CategoryOption(
                label: 'Smg',
              ),
              CategoryOption(
                label: 'Pesadas',
              ),
              CategoryOption(
                label: 'Outras',
              ),
            ],
          ),
        ));
  }
}
