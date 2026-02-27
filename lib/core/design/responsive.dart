import 'package:flutter/material.dart';

/// Breakpoints para responsividade
class Breakpoints {
  Breakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

/// Larguras máximas de conteúdo
class ContentWidth {
  ContentWidth._();

  static const double small = 400;
  static const double medium = 600;
  static const double large = 800;
}

/// Widget que centraliza e limita a largura do conteúdo em telas grandes
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = ContentWidth.medium,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > Breakpoints.mobile;

        if (isDesktop) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: padding != null
                  ? Padding(padding: padding!, child: child)
                  : child,
            ),
          );
        }

        return padding != null
            ? Padding(padding: padding!, child: child)
            : child;
      },
    );
  }
}

/// Widget que adapta o layout baseado no tamanho da tela
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Breakpoints.desktop) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= Breakpoints.tablet) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}

/// Extension para verificar o tipo de dispositivo
extension ResponsiveContext on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width < Breakpoints.mobile;
  bool get isTablet =>
      MediaQuery.sizeOf(this).width >= Breakpoints.mobile &&
      MediaQuery.sizeOf(this).width < Breakpoints.desktop;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= Breakpoints.desktop;
}
