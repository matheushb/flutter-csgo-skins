import 'package:csgo_skins_app/components/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart Widget Tests', () {
    testWidgets('Verifica se os itens do cart são exibidos corretamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: Cart(),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('Verifica se o clique nos itens do cart funciona',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: Cart(),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      await tester.tap(find.text('Item 2'));
      await tester.pump();
    });
  });
}
