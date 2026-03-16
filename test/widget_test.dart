// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hero_demo/main.dart';

void main() {
  testWidgets('Hero example navigates from list to detail page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hero Demo'), findsOneWidget);
    expect(find.text('Cloud Camp'), findsWidgets);

    await tester.tap(find.byKey(const Key('destination-card-cloud-camp')));
    await tester.pumpAndSettle();

    expect(find.text('Detail page'), findsOneWidget);
    expect(find.byType(DestinationDetailPage), findsOneWidget);
  });
}
