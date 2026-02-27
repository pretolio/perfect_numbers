import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/design/app_theme.dart';
import '../../core/design/responsive.dart';
import '../../domain/entities/perfect_number_result.dart';
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
    return ResponsiveContainer(
      maxWidth: ContentWidth.medium,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Verificar Número Perfeito',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Um número perfeito é igual à soma de seus divisores próprios.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMuted,
                ),
          ),
          const SizedBox(height: AppTheme.spacingLg),
          CustomTextField(
            controller: _controller,
            label: 'Número',
            hint: 'Ex: 6, 28, 496',
          ),
          const SizedBox(height: AppTheme.spacingMd),
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
          const SizedBox(height: AppTheme.spacingLg),
          Expanded(
            child: Selector<CheckNumberViewModel, PerfectNumberCheckResult?>(
              selector: (_, vm) => vm.result,
              builder: (context, result, _) {
                if (result != null) {
                  return CheckResultContent(result: result);
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 64,
                        color: AppTheme.backgroundDark,
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        'Digite um número para verificar',
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
