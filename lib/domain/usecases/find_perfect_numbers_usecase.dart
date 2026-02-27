import '../entities/perfect_number_result.dart';
import '../repositories/perfect_number_repository.dart';
import '../../core/result/result.dart';

/// Parâmetros para busca de números perfeitos em range
class FindPerfectNumbersParams {
  final int start;
  final int end;

  const FindPerfectNumbersParams({
    required this.start,
    required this.end,
  });
}

/// Use Case para encontrar números perfeitos em um range
/// Single Responsibility Principle - faz apenas uma coisa
abstract interface class FindPerfectNumbersUseCase {
  Future<Result<PerfectNumbersRangeResult>> call(FindPerfectNumbersParams params);
}

class FindPerfectNumbersUseCaseImpl implements FindPerfectNumbersUseCase {
  final PerfectNumberRepository _repository;

  const FindPerfectNumbersUseCaseImpl(this._repository);

  @override
  Future<Result<PerfectNumbersRangeResult>> call(FindPerfectNumbersParams params) {
    return _repository.findPerfectNumbersInRange(params.start, params.end);
  }
}
