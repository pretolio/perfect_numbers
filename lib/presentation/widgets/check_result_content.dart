import 'package:flutter/material.dart';

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
            backgroundColor: isPerfect ? Colors.green[50] : Colors.orange[50],
            content: Row(
              children: [
                Icon(
                  isPerfect ? Icons.check_circle : Icons.cancel,
                  color: isPerfect ? Colors.green : Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isPerfect
                        ? '${result.number} é um número perfeito!'
                        : '${result.number} não é um número perfeito.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ResultCard(
            title: 'Divisores próprios',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: result.divisors
                      .map((d) => Chip(label: Text(d.toString())))
                      .toList(),
                ),
                const SizedBox(height: 12),
                Text(
                  'Soma: ${result.divisors.fold(0, (a, b) => a + b)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
