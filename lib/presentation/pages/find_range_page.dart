import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/design/app_theme.dart';
import '../../core/design/responsive.dart';
import '../../domain/entities/perfect_number_result.dart';
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
    return ResponsiveContainer(
      maxWidth: ContentWidth.medium,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Encontrar em Range',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Encontre todos os números perfeitos entre dois valores.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMuted,
                ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _startController,
                  label: 'Início',
                  hint: 'Ex: 1',
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: CustomTextField(
                  controller: _endController,
                  label: 'Fim',
                  hint: 'Ex: 10000',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
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
          const SizedBox(height: AppTheme.spacingLg),
          Expanded(
            child: Selector<FindRangeViewModel, PerfectNumbersRangeResult?>(
              selector: (_, vm) => vm.result,
              builder: (context, result, _) {
                if (result != null) {
                  return RangeResultContent(result: result);
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.format_list_numbered,
                        size: 64,
                        color: AppTheme.backgroundDark,
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        'Defina um intervalo para buscar',
                        style: TextStyle(color: AppTheme.textMuted),
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
