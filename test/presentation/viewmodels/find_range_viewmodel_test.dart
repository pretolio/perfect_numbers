import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';
import 'package:perfect_numbers/domain/usecases/find_perfect_numbers_usecase.dart';
import 'package:perfect_numbers/presentation/viewmodels/find_range_viewmodel.dart';

void main() {
  late FindRangeViewModel viewModel;

  setUp(() {
    const calculator = PerfectNumberCalculatorImpl();
    final repository = PerfectNumberRepositoryImpl(calculator);
    final useCase = FindPerfectNumbersUseCaseImpl(repository);
    viewModel = FindRangeViewModel(useCase);
  });

  group('FindRangeViewModel', () {
    test('should have initial state', () {
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for invalid start input', () async {
      await viewModel.findInRange('abc', '30');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for invalid end input', () async {
      await viewModel.findInRange('1', 'xyz');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for empty inputs', () async {
      await viewModel.findInRange('', '');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should return result for valid range with perfect numbers', () async {
      await viewModel.findInRange('1', '30');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNotNull);
      expect(viewModel.result!.perfectNumbers, equals([6, 28]));
    });

    test('should return result for valid range without perfect numbers', () async {
      await viewModel.findInRange('7', '27');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNotNull);
      expect(viewModel.result!.perfectNumbers, isEmpty);
    });

    test('should set error when start is greater than end', () async {
      await viewModel.findInRange('30', '1');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for negative values', () async {
      await viewModel.findInRange('-5', '10');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for zero values', () async {
      await viewModel.findInRange('0', '10');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should reset state', () async {
      await viewModel.findInRange('1', '30');
      viewModel.reset();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNull);
    });

    test('should notify listeners on state change', () async {
      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      await viewModel.findInRange('1', '30');

      expect(notifyCount, greaterThan(0));
    });
  });
}
