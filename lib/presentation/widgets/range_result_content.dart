import 'package:flutter/material.dart';

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
            backgroundColor: hasResults ? Colors.green[50] : Colors.orange[50],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intervalo: ${result.start} até ${result.end}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  hasResults
                      ? 'Encontrados: ${result.count} número(s) perfeito(s)'
                      : 'Nenhum número perfeito encontrado neste intervalo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: hasResults ? Colors.green[700] : Colors.orange[700],
                      ),
                ),
              ],
            ),
          ),
          if (hasResults) ...[
            const SizedBox(height: 16),
            ResultCard(
              title: 'Números Perfeitos',
              content: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: result.perfectNumbers
                    .map((n) => Chip(
                          label: Text(
                            n.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue[100],
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
