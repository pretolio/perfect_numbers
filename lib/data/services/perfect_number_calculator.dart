/// Serviço que contém a lógica de cálculo de números perfeitos
/// Separado para facilitar testes e manutenção
/// Single Responsibility Principle
abstract interface class PerfectNumberCalculator {
  bool isPerfectNumber(int number);
  List<int> getDivisors(int number);
  List<int> findPerfectNumbersInRange(int start, int end);
}

class PerfectNumberCalculatorImpl implements PerfectNumberCalculator {
  const PerfectNumberCalculatorImpl();

  @override
  bool isPerfectNumber(int number) {
    if (number <= 1) return false;

    final divisors = getDivisors(number);
    final sum = divisors.fold(0, (acc, d) => acc + d);

    return sum == number;
  }

  @override
  List<int> getDivisors(int number) {
    if (number <= 0) return [];

    final divisors = <int>[];

    for (int i = 1; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        divisors.add(i);
      }
    }

    return divisors;
  }

  @override
  List<int> findPerfectNumbersInRange(int start, int end) {
    final perfectNumbers = <int>[];

    final actualStart = start < 2 ? 2 : start;

    for (int i = actualStart; i <= end; i++) {
      if (isPerfectNumber(i)) {
        perfectNumbers.add(i);
      }
    }

    return perfectNumbers;
  }
}
