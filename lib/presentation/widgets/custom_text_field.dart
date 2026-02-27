import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget reutilizável para input de números
/// Interface Segregation - widget focado em uma função específica
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
