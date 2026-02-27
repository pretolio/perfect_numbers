import 'package:flutter/material.dart';

import '../../core/design/app_theme.dart';

class AppLoading {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context, {String? message}) {
    hide();

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingXl,
              vertical: AppTheme.spacingLg,
            ),
            decoration: BoxDecoration(
              color: AppTheme.backgroundCard,
              borderRadius: AppTheme.borderRadiusMedium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: AppTheme.primary,
                ),
                if (message != null) ...[
                  const SizedBox(height: AppTheme.spacingMd),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
