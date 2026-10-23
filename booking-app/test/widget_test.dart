import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glow_studio/main.dart';

void main() {
  testWidgets('Glow Studio booking flow works', (WidgetTester tester) async {
    // Tall viewport so the whole ListView page fits without scrolling:
    // the confirm button sits below the fold at the default 800x600 size,
    // and ListView only builds on-screen items, which made plain finders
    // see 0 widgets (and scroll helpers hit duplicate-finder errors).
    tester.view.physicalSize = const Size(800, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GlowStudioApp());

    expect(find.text('Glow Studio'), findsWidgets);
    expect(find.text('Choose a service'), findsOneWidget);

    await tester.tap(find.text('Haircut'));
    await tester.pump();
    await tester.tap(find.text('09:00'));
    await tester.pump();
    await tester.tap(find.text('Confirm booking'));
    await tester.pumpAndSettle();

    expect(find.text('Booking confirmed'), findsOneWidget);
    expect(find.textContaining('Thanks'), findsOneWidget);
    expect(find.textContaining('Haircut'), findsWidgets);
  });
}
