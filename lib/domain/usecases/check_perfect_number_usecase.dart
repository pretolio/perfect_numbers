import '../entities/perfect_number_result.dart';
import '../repositories/perfect_number_repository.dart';
import '../../core/result/result.dart';

/// Use Case para verificar se um número é perfeito
/// Single Responsibility Principle - faz apenas uma coisa
abstract interface class CheckPerfectNumberUseCase {
  Future<Result<PerfectNumberCheckResult>> call(int number);
}

class CheckPerfectNumberUseCaseImpl implements CheckPerfectNumberUseCase {
  final PerfectNumberRepository _repository;

  const CheckPerfectNumberUseCaseImpl(this._repository);

  @override
  Future<Result<PerfectNumberCheckResult>> call(int number) {
    return _repository.checkPerfectNumber(number);
  }
}
