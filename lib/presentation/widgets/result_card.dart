import 'package:flutter/material.dart';

/// Widget para exibir resultados em card
/// Reutilizável em diferentes contextos
class ResultCard extends StatelessWidget {
  final String title;
  final Widget content;
  final Color? backgroundColor;

  const ResultCard({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
