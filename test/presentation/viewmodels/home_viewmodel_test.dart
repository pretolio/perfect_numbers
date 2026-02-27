import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/presentation/viewmodels/home_viewmodel.dart';

void main() {
  late HomeViewModel viewModel;

  setUp(() {
    viewModel = HomeViewModel();
  });

  group('HomeViewModel', () {
    test('should have initial index 0', () {
      expect(viewModel.currentIndex, equals(0));
    });

    test('should change index', () {
      viewModel.setIndex(1);
      expect(viewModel.currentIndex, equals(1));
    });

    test('should not notify if same index', () {
      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      viewModel.setIndex(0);

      expect(notifyCount, equals(0));
    });

    test('should notify on index change', () {
      int notifyCount = 0;
      viewModel.addListener(() => notifyCount++);

      viewModel.setIndex(1);

      expect(notifyCount, equals(1));
    });
  });
}
