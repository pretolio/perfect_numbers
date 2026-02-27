import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_numbers/main.dart';

void main() {
  group('PerfectNumbersApp', () {
    testWidgets('should render app correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      expect(find.text('Perfect Numbers'), findsOneWidget);
      expect(find.text('Verificar Número Perfeito'), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('should navigate to Range tab', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      await tester.tap(find.text('Range'));
      await tester.pumpAndSettle();

      expect(find.text('Encontrar em Range'), findsOneWidget);
    });

    testWidgets('should navigate back to Verificar tab', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      await tester.tap(find.text('Range'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check_circle_outline));
      await tester.pumpAndSettle();

      expect(find.text('Verificar Número Perfeito'), findsOneWidget);
    });

    testWidgets('should show text field in check number page', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Número'), findsOneWidget);
    });

    testWidgets('should show two text fields in range page', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      await tester.tap(find.text('Range'));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Início'), findsOneWidget);
      expect(find.text('Fim'), findsOneWidget);
    });

    testWidgets('should show verify button', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show search button in range page', (WidgetTester tester) async {
      await tester.pumpWidget(const PerfectNumbersApp());

      await tester.tap(find.text('Range'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Buscar'), findsOneWidget);
    });
  });
}
