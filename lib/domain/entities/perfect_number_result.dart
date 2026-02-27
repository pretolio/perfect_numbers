/// Entidade que representa o resultado da verificação de número perfeito
class PerfectNumberCheckResult {
  final int number;
  final bool isPerfect;
  final List<int> divisors;

  const PerfectNumberCheckResult({
    required this.number,
    required this.isPerfect,
    required this.divisors,
  });
}

/// Entidade que representa o resultado da busca de números perfeitos em um range
class PerfectNumbersRangeResult {
  final int start;
  final int end;
  final List<int> perfectNumbers;

  const PerfectNumbersRangeResult({
    required this.start,
    required this.end,
    required this.perfectNumbers,
  });

  int get count => perfectNumbers.length;
}
