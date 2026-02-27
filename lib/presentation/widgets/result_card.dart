import 'package:flutter/material.dart';

import '../../core/design/app_theme.dart';

/// Widget para exibir resultados em card
/// Reutilizável em diferentes contextos
class ResultCard extends StatelessWidget {
  final String title;
  final Widget content;
  final Color? backgroundColor;
  final Color? titleColor;

  const ResultCard({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? AppTheme.backgroundCard,
      elevation: AppTheme.elevationLow,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.borderRadiusMedium,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: titleColor ?? AppTheme.textPrimary,
                  ),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            content,
          ],
        ),
      ),
    );
  }
}
