import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/check_number_viewmodel.dart';
import '../widgets/app_loading.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/check_result_content.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class CheckNumberPage extends StatefulWidget {
  const CheckNumberPage({super.key});

  @override
  State<CheckNumberPage> createState() => _CheckNumberPageState();
}

class _CheckNumberPageState extends State<CheckNumberPage> {
  final _controller = TextEditingController();
  bool _wasLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckNumberViewModel>().addListener(_onViewModelChanged);
    });
  }

  void _onViewModelChanged() {
    final viewModel = context.read<CheckNumberViewModel>();

    if (viewModel.isLoading && !_wasLoading) {
      AppLoading.show(context, message: 'Verificando...');
    } else if (!viewModel.isLoading && _wasLoading) {
      AppLoading.hide();
    }

    _wasLoading = viewModel.isLoading;

    if (viewModel.errorMessage != null) {
      AppSnackbar.showError(context, viewModel.errorMessage!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Verificar Número Perfeito',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Um número perfeito é igual à soma de seus divisores próprios.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: _controller,
            label: 'Número',
            hint: 'Ex: 6, 28, 496',
          ),
          const SizedBox(height: 16),
          Selector<CheckNumberViewModel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder: (context, isLoading, _) {
              return LoadingButton(
                text: 'Verificar',
                isLoading: isLoading,
                onPressed: () {
                  context.read<CheckNumberViewModel>().checkNumber(_controller.text);
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Selector<CheckNumberViewModel, bool>(
              selector: (_, vm) => vm.result != null,
              builder: (context, hasResult, _) {
                if (hasResult) {
                  final result = context.read<CheckNumberViewModel>().result!;
                  return CheckResultContent(result: result);
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Digite um número para verificar',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
