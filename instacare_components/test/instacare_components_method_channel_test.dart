import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instacare_components/instacare_components.dart';

void main() {
  test('button size extension exposes expected horizontal padding', () {
    expect(ButtonSize.small.padding.horizontal, 32);
    expect(ButtonSize.medium.padding.horizontal, 48);
    expect(ButtonSize.large.padding.horizontal, 64);
  });

  testWidgets('InstaCareButton.secondary renders as OutlinedButton', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InstaCareButton.secondary(text: 'Secondary'),
        ),
      ),
    );

    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.text('Secondary'), findsOneWidget);
  });
}

