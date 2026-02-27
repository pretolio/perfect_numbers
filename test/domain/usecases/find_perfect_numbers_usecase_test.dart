import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';
import 'package:perfect_numbers/domain/usecases/find_perfect_numbers_usecase.dart';

void main() {
  late FindPerfectNumbersUseCaseImpl useCase;

  setUp(() {
    const calculator = PerfectNumberCalculatorImpl();
    final repository = PerfectNumberRepositoryImpl(calculator);
    useCase = FindPerfectNumbersUseCaseImpl(repository);
  });

  group('FindPerfectNumbersUseCase', () {
    test('should return Success with perfect numbers for valid range', () async {
      final result = await useCase(const FindPerfectNumbersParams(start: 1, end: 30));

      expect(result.isSuccess, isTrue);
      expect(result.data!.perfectNumbers, equals([6, 28]));
    });

    test('should return Success with empty list for range without perfect numbers', () async {
      final result = await useCase(const FindPerfectNumbersParams(start: 7, end: 27));

      expect(result.isSuccess, isTrue);
      expect(result.data!.perfectNumbers, isEmpty);
    });

    test('should return Failure for invalid range', () async {
      final result = await useCase(const FindPerfectNumbersParams(start: 30, end: 1));

      expect(result.isFailure, isTrue);
    });

    test('should return Failure for negative values', () async {
      final result = await useCase(const FindPerfectNumbersParams(start: -5, end: 10));

      expect(result.isFailure, isTrue);
    });
  });
}
