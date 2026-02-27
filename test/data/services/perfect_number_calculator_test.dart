import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';

void main() {
  late PerfectNumberCalculatorImpl calculator;

  setUp(() {
    calculator = const PerfectNumberCalculatorImpl();
  });

  group('isPerfectNumber', () {
    test('should return true for 6', () {
      expect(calculator.isPerfectNumber(6), isTrue);
    });

    test('should return true for 28', () {
      expect(calculator.isPerfectNumber(28), isTrue);
    });

    test('should return true for 496', () {
      expect(calculator.isPerfectNumber(496), isTrue);
    });

    test('should return true for 8128', () {
      expect(calculator.isPerfectNumber(8128), isTrue);
    });

    test('should return false for 1', () {
      expect(calculator.isPerfectNumber(1), isFalse);
    });

    test('should return false for 0', () {
      expect(calculator.isPerfectNumber(0), isFalse);
    });

    test('should return false for negative numbers', () {
      expect(calculator.isPerfectNumber(-6), isFalse);
    });

    test('should return false for 10', () {
      expect(calculator.isPerfectNumber(10), isFalse);
    });

    test('should return false for 12', () {
      expect(calculator.isPerfectNumber(12), isFalse);
    });

    test('should return false for 100', () {
      expect(calculator.isPerfectNumber(100), isFalse);
    });
  });

  group('getDivisors', () {
    test('should return [1, 2, 3] for 6', () {
      expect(calculator.getDivisors(6), equals([1, 2, 3]));
    });

    test('should return [1, 2, 4, 7, 14] for 28', () {
      expect(calculator.getDivisors(28), equals([1, 2, 4, 7, 14]));
    });

    test('should return [1] for prime number 7', () {
      expect(calculator.getDivisors(7), equals([1]));
    });

    test('should return empty list for 0', () {
      expect(calculator.getDivisors(0), isEmpty);
    });

    test('should return empty list for negative numbers', () {
      expect(calculator.getDivisors(-5), isEmpty);
    });

    test('should return [1, 2, 5] for 10', () {
      expect(calculator.getDivisors(10), equals([1, 2, 5]));
    });
  });

  group('findPerfectNumbersInRange', () {
    test('should return [6] for range 1 to 10', () {
      expect(calculator.findPerfectNumbersInRange(1, 10), equals([6]));
    });

    test('should return [6, 28] for range 1 to 30', () {
      expect(calculator.findPerfectNumbersInRange(1, 30), equals([6, 28]));
    });

    test('should return [6, 28, 496] for range 1 to 500', () {
      expect(calculator.findPerfectNumbersInRange(1, 500), equals([6, 28, 496]));
    });

    test('should return empty list for range 7 to 27', () {
      expect(calculator.findPerfectNumbersInRange(7, 27), isEmpty);
    });

    test('should return [28] for range 7 to 30', () {
      expect(calculator.findPerfectNumbersInRange(7, 30), equals([28]));
    });

    test('should return [6] for range 6 to 6', () {
      expect(calculator.findPerfectNumbersInRange(6, 6), equals([6]));
    });

    test('should handle start less than 2', () {
      expect(calculator.findPerfectNumbersInRange(-5, 10), equals([6]));
    });
  });
}
