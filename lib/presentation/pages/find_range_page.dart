import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/find_range_viewmodel.dart';
import '../widgets/app_loading.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';
import '../widgets/range_result_content.dart';

class FindRangePage extends StatefulWidget {
  const FindRangePage({super.key});

  @override
  State<FindRangePage> createState() => _FindRangePageState();
}

class _FindRangePageState extends State<FindRangePage> {
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  bool _wasLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FindRangeViewModel>().addListener(_onViewModelChanged);
    });
  }

  void _onViewModelChanged() {
    final viewModel = context.read<FindRangeViewModel>();

    if (viewModel.isLoading && !_wasLoading) {
      AppLoading.show(context, message: 'Buscando...');
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
    _startController.dispose();
    _endController.dispose();
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
            'Encontrar em Range',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Encontre todos os números perfeitos entre dois valores.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _startController,
                  label: 'Início',
                  hint: 'Ex: 1',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  controller: _endController,
                  label: 'Fim',
                  hint: 'Ex: 10000',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Selector<FindRangeViewModel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder: (context, isLoading, _) {
              return LoadingButton(
                text: 'Buscar',
                isLoading: isLoading,
                onPressed: () {
                  context.read<FindRangeViewModel>().findInRange(
                    _startController.text,
                    _endController.text,
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Selector<FindRangeViewModel, bool>(
              selector: (_, vm) => vm.result != null,
              builder: (context, hasResult, _) {
                if (hasResult) {
                  final result = context.read<FindRangeViewModel>().result!;
                  return RangeResultContent(result: result);
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.format_list_numbered, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Defina um intervalo para buscar',
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
