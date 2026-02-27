import 'package:flutter/material.dart';

import '../../core/design/app_theme.dart';
import '../../domain/entities/perfect_number_result.dart';
import 'result_card.dart';

class CheckResultContent extends StatelessWidget {
  final PerfectNumberCheckResult result;

  const CheckResultContent({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final isPerfect = result.isPerfect;

    return SingleChildScrollView(
      child: Column(
        children: [
          ResultCard(
            title: 'Resultado',
            backgroundColor: isPerfect ? AppTheme.primary : AppTheme.secondary,
            titleColor: AppTheme.textLight,
            content: Row(
              children: [
                Icon(
                  isPerfect ? Icons.check_circle : Icons.info_outline,
                  color: AppTheme.textLight,
                  size: 32,
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Text(
                    isPerfect
                        ? '${result.number} é um número perfeito!'
                        : '${result.number} não é um número perfeito.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textLight,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          ResultCard(
            title: 'Divisores próprios',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppTheme.spacingSm,
                  runSpacing: AppTheme.spacingSm,
                  children: result.divisors
                      .map((d) => Chip(label: Text(d.toString())))
                      .toList(),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  'Soma: ${result.divisors.fold(0, (a, b) => a + b)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
