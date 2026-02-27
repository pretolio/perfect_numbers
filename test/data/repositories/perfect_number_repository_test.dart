import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';

void main() {
  late PerfectNumberRepositoryImpl repository;

  setUp(() {
    const calculator = PerfectNumberCalculatorImpl();
    repository = PerfectNumberRepositoryImpl(calculator);
  });

  group('checkPerfectNumber', () {
    test('should return Success with isPerfect true for 6', () async {
      final result = await repository.checkPerfectNumber(6);

      expect(result.isSuccess, isTrue);
      expect(result.data!.isPerfect, isTrue);
      expect(result.data!.number, equals(6));
      expect(result.data!.divisors, equals([1, 2, 3]));
    });

    test('should return Success with isPerfect false for 10', () async {
      final result = await repository.checkPerfectNumber(10);

      expect(result.isSuccess, isTrue);
      expect(result.data!.isPerfect, isFalse);
      expect(result.data!.number, equals(10));
    });

    test('should return Failure for 0', () async {
      final result = await repository.checkPerfectNumber(0);

      expect(result.isFailure, isTrue);
      expect(result.errorMessage, contains('maior que zero'));
    });

    test('should return Failure for negative numbers', () async {
      final result = await repository.checkPerfectNumber(-5);

      expect(result.isFailure, isTrue);
      expect(result.errorMessage, contains('maior que zero'));
    });
  });

  group('findPerfectNumbersInRange', () {
    test('should return Success with perfect numbers for valid range', () async {
      final result = await repository.findPerfectNumbersInRange(1, 30);

      expect(result.isSuccess, isTrue);
      expect(result.data!.perfectNumbers, equals([6, 28]));
      expect(result.data!.start, equals(1));
      expect(result.data!.end, equals(30));
      expect(result.data!.count, equals(2));
    });

    test('should return Success with empty list for range without perfect numbers', () async {
      final result = await repository.findPerfectNumbersInRange(7, 27);

      expect(result.isSuccess, isTrue);
      expect(result.data!.perfectNumbers, isEmpty);
      expect(result.data!.count, equals(0));
    });

    test('should return Failure when start is greater than end', () async {
      final result = await repository.findPerfectNumbersInRange(30, 1);

      expect(result.isFailure, isTrue);
      expect(result.errorMessage, contains('menor ou igual'));
    });

    test('should return Failure for zero values', () async {
      final result = await repository.findPerfectNumbersInRange(0, 10);

      expect(result.isFailure, isTrue);
      expect(result.errorMessage, contains('maiores que zero'));
    });

    test('should return Failure for negative values', () async {
      final result = await repository.findPerfectNumbersInRange(-5, 10);

      expect(result.isFailure, isTrue);
      expect(result.errorMessage, contains('maiores que zero'));
    });
  });
}
