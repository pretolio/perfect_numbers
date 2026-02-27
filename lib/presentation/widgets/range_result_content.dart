import 'package:flutter/material.dart';

import '../../core/design/app_theme.dart';
import '../../domain/entities/perfect_number_result.dart';
import 'result_card.dart';

class RangeResultContent extends StatelessWidget {
  final PerfectNumbersRangeResult result;

  const RangeResultContent({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final hasResults = result.perfectNumbers.isNotEmpty;

    return SingleChildScrollView(
      child: Column(
        children: [
          ResultCard(
            title: 'Resultado da Busca',
            backgroundColor: hasResults ? AppTheme.primary : AppTheme.secondary,
            titleColor: AppTheme.textLight,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intervalo: ${result.start} até ${result.end}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textLight,
                      ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  hasResults
                      ? 'Encontrados: ${result.count} número(s) perfeito(s)'
                      : 'Nenhum número perfeito encontrado neste intervalo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textLight,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          if (hasResults) ...[
            const SizedBox(height: AppTheme.spacingMd),
            ResultCard(
              title: 'Números Perfeitos',
              content: Wrap(
                spacing: AppTheme.spacingSm,
                runSpacing: AppTheme.spacingSm,
                children: result.perfectNumbers
                    .map((n) => Chip(
                          label: Text(
                            n.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.chipText,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
