import 'package:flutter/foundation.dart';

import '../../domain/entities/perfect_number_result.dart';
import '../../domain/usecases/check_perfect_number_usecase.dart';

class CheckNumberViewModel extends ChangeNotifier {
  final CheckPerfectNumberUseCase _checkPerfectNumberUseCase;

  CheckNumberViewModel(this._checkPerfectNumberUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PerfectNumberCheckResult? _result;
  PerfectNumberCheckResult? get result => _result;

  Future<void> checkNumber(String input) async {
    final number = int.tryParse(input);

    if (number == null) {
      _errorMessage = 'Por favor, insira um número válido';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _result = null;
    notifyListeners();

    final response = await _checkPerfectNumberUseCase(number);

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
