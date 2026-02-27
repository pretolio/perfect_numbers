import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/data/repositories/perfect_number_repository_impl.dart';
import 'package:perfect_numbers/data/services/perfect_number_calculator.dart';
import 'package:perfect_numbers/domain/usecases/check_perfect_number_usecase.dart';
import 'package:perfect_numbers/presentation/viewmodels/check_number_viewmodel.dart';

void main() {
  late CheckNumberViewModel viewModel;

  setUp(() {
    const calculator = PerfectNumberCalculatorImpl();
    final repository = PerfectNumberRepositoryImpl(calculator);
    final useCase = CheckPerfectNumberUseCaseImpl(repository);
    viewModel = CheckNumberViewModel(useCase);
  });

  group('CheckNumberViewModel', () {
    test('should have initial state', () {
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for invalid input', () async {
      await viewModel.checkNumber('abc');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for empty input', () async {
      await viewModel.checkNumber('');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should return result for perfect number 6', () async {
      await viewModel.checkNumber('6');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNotNull);
      expect(viewModel.result!.isPerfect, isTrue);
    });

    test('should return result for non-perfect number 10', () async {
      await viewModel.checkNumber('10');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNotNull);
      expect(viewModel.result!.isPerfect, isFalse);
    });

    test('should set error for negative number', () async {
      await viewModel.checkNumber('-5');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should set error for zero', () async {
      await viewModel.checkNumber('0');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.result, isNull);
    });

    test('should reset state', () async {
      await viewModel.checkNumber('6');
      viewModel.reset();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.result, isNull);
    });

    test('should notify listeners on state change', () async {
      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      await viewModel.checkNumber('6');

      expect(notifyCount, greaterThan(0));
    });
  });
}
