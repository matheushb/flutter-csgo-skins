import 'package:flutter/material.dart';

class CategoryOption extends StatelessWidget {
  final String label;
  final Function(String) onSelect;

  const CategoryOption(
      {super.key, required this.label, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          onSelect(label);
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
