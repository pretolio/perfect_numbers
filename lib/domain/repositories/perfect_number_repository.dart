import '../entities/perfect_number_result.dart';
import '../../core/result/result.dart';

/// Abstração do repositório de números perfeitos
/// Segue Dependency Inversion Principle (SOLID)
/// A camada de domínio não depende de implementações concretas
abstract interface class PerfectNumberRepository {
  /// Verifica se um número é perfeito
  Future<Result<PerfectNumberCheckResult>> checkPerfectNumber(int number);

  /// Encontra todos os números perfeitos em um range
  Future<Result<PerfectNumbersRangeResult>> findPerfectNumbersInRange(
    int start,
    int end,
  );
}
