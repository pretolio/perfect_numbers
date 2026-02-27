import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/perfect_number_repository_impl.dart';
import 'data/services/perfect_number_calculator.dart';
import 'domain/usecases/check_perfect_number_usecase.dart';
import 'domain/usecases/find_perfect_numbers_usecase.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/viewmodels/check_number_viewmodel.dart';
import 'presentation/viewmodels/find_range_viewmodel.dart';
import 'presentation/viewmodels/home_viewmodel.dart';

void main() {
  runApp(const PerfectNumbersApp());
}

class PerfectNumbersApp extends StatelessWidget {
  const PerfectNumbersApp({super.key});

  @override
  Widget build(BuildContext context) {
    const calculator = PerfectNumberCalculatorImpl();
    final repository = PerfectNumberRepositoryImpl(calculator);
    final checkUseCase = CheckPerfectNumberUseCaseImpl(repository);
    final findUseCase = FindPerfectNumbersUseCaseImpl(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckNumberViewModel(checkUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => FindRangeViewModel(findUseCase),
        ),
      ],
      child: MaterialApp(
        title: 'Perfect Numbers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
