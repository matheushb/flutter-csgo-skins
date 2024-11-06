import 'package:csgo_skins_app/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Menu Widget Tests', () {
    testWidgets('Verifica se os itens do menu são exibidos corretamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: Menu(),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Entrar'), findsOneWidget);
      expect(find.text('Registrar-se'), findsOneWidget);
    });

    testWidgets('Verifica se o clique nos itens do menu funciona',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: Menu(),
          ),
        ),
      );

      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pump();

      await tester.tap(find.text('Entrar'));
      await tester.pump();

      await tester.tap(find.text('Registrar-se'));
      await tester.pump();
    });
  });
}
