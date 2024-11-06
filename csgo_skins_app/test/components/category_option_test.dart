import 'package:csgo_skins_app/components/category_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryOption Widget Tests', () {
    testWidgets('Verifica se o label é exibido corretamente',
        (WidgetTester tester) async {
      const String testLabel = 'Teste Categoria';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CategoryOption(label: testLabel),
          ),
        ),
      );

      expect(find.text(testLabel), findsOneWidget);
    });

    testWidgets('Verifica se o clique no botão funciona',
        (WidgetTester tester) async {
      const String testLabel = 'Teste Categoria';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CategoryOption(label: testLabel),
          ),
        ),
      );

      await tester.tap(find.text(testLabel));
      await tester.pump();
    });
  });
}
