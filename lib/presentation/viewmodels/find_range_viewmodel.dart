import 'package:flutter/foundation.dart';

import '../../domain/entities/perfect_number_result.dart';
import '../../domain/usecases/find_perfect_numbers_usecase.dart';

class FindRangeViewModel extends ChangeNotifier {
  final FindPerfectNumbersUseCase _findPerfectNumbersUseCase;

  FindRangeViewModel(this._findPerfectNumbersUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PerfectNumbersRangeResult? _result;
  PerfectNumbersRangeResult? get result => _result;

  Future<void> findInRange(String startInput, String endInput) async {
    final start = int.tryParse(startInput);
    final end = int.tryParse(endInput);

    if (start == null || end == null) {
      _errorMessage = 'Por favor, insira números válidos';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _result = null;
    notifyListeners();

    final response = await _findPerfectNumbersUseCase(
      FindPerfectNumbersParams(start: start, end: end),
    );

    _isLoading = false;

    response.when(
      success: (data) {
        _result = data;
        _errorMessage = null;
      },
      failure: (message) {
        _errorMessage = message;
        _result = null;
      },
    );

    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _result = null;
    notifyListeners();
  }
}
