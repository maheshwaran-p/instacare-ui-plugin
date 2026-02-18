import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instacare_components/instacare_components.dart';

void main() {
  test('button size extension exposes expected heights', () {
    expect(ButtonSize.small.height, 40);
    expect(ButtonSize.medium.height, 48);
    expect(ButtonSize.large.height, 56);
  });

  testWidgets('InstaCareButton renders text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InstaCareButton(text: 'Continue'),
        ),
      ),
    );

    

    expect(find.byType(InstaCareButton), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}

