import '../../core/result/result.dart';
import '../../domain/entities/perfect_number_result.dart';
import '../../domain/repositories/perfect_number_repository.dart';
import '../services/perfect_number_calculator.dart';

/// Implementação concreta do repositório
/// Open/Closed Principle - pode ser estendido sem modificar
class PerfectNumberRepositoryImpl implements PerfectNumberRepository {
  final PerfectNumberCalculator _calculator;

  const PerfectNumberRepositoryImpl(this._calculator);

  @override
  Future<Result<PerfectNumberCheckResult>> checkPerfectNumber(int number) async {
    try {
      if (number <= 0) {
        return const Failure('O número deve ser maior que zero');
      }

      final divisors = _calculator.getDivisors(number);
      final isPerfect = _calculator.isPerfectNumber(number);

      return Success(PerfectNumberCheckResult(
        number: number,
        isPerfect: isPerfect,
        divisors: divisors,
      ));
    } catch (e) {
      return Failure('Erro ao verificar número: $e');
    }
  }

  @override
  Future<Result<PerfectNumbersRangeResult>> findPerfectNumbersInRange(
    int start,
    int end,
  ) async {
    try {
      if (start > end) {
        return const Failure('O valor inicial deve ser menor ou igual ao final');
      }

      if (start <= 0 || end <= 0) {
        return const Failure('Os valores devem ser maiores que zero');
      }

      final perfectNumbers = _calculator.findPerfectNumbersInRange(start, end);

      return Success(PerfectNumbersRangeResult(
        start: start,
        end: end,
        perfectNumbers: perfectNumbers,
      ));
    } catch (e) {
      return Failure('Erro ao buscar números perfeitos: $e');
    }
  }
}
