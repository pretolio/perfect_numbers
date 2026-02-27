import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/core/result/result.dart';
import 'package:perfect_numbers/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';
import 'package:perfect_numbers/domain/usecases/check_perfect_number_usecase.dart';

void main() {
  late CheckPerfectNumberUseCaseImpl useCase;

  setUp(() {
    const calculator = PerfectNumberCalculatorImpl();
    final repository = PerfectNumberRepositoryImpl(calculator);
    useCase = CheckPerfectNumberUseCaseImpl(repository);
  });

  group('CheckPerfectNumberUseCase', () {
    test('should return Success for perfect number 6', () async {
      final result = await useCase(6);

      expect(result.isSuccess, isTrue);
      expect(result.data!.isPerfect, isTrue);
    });

    test('should return Success for perfect number 28', () async {
      final result = await useCase(28);

      expect(result.isSuccess, isTrue);
      expect(result.data!.isPerfect, isTrue);
    });

    test('should return Success with isPerfect false for 10', () async {
      final result = await useCase(10);

      expect(result.isSuccess, isTrue);
      expect(result.data!.isPerfect, isFalse);
    });

    test('should return Failure for invalid input', () async {
      final result = await useCase(-1);

      expect(result.isFailure, isTrue);
    });
  });
}
